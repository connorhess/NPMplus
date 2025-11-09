#!/usr/bin/env node

const schema = require("./schema");
const logger = require("./logger").global;

async function appStart() {
	const migrate = require("./migrate");
	const setup = require("./setup");
	const app = require("./app");
	const internalNginx = require("./internal/nginx");
	const internalCertificate = require("./internal/certificate");
	const internalIpRanges = require("./internal/ip_ranges");

	return migrate
		.latest()
		.then(setup)
		.then(schema.getCompiledSchema)
		.then(internalIpRanges.fetch)
		.then(() => {
			internalNginx.reload();
			internalCertificate.initTimer();
			internalIpRanges.initTimer();

			// Use TCP port in development (Windows doesn't support Unix sockets well)
			// Use Unix socket in production (Docker environment)
			const listenTarget = process.env.NODE_ENV === 'development'
				? parseInt(process.env.BACKEND_PORT || 3000, 10)
				: "/run/npmplus.sock";

			const listenHost = process.env.NODE_ENV === 'development' ? "127.0.0.1" : undefined;

			const server = app.listen(listenTarget, listenHost, () => {
				if (process.env.NODE_ENV === 'development') {
					logger.info(`Backend PID ${process.pid} listening on http://127.0.0.1:${listenTarget}`);
				} else {
					logger.info("Backend PID " + process.pid + " listening on unix socket");
				}

				process.on("SIGTERM", () => {
					logger.info("PID " + process.pid + " received SIGTERM");
					server.close(() => {
						logger.info("Stopping.");
						process.exit(0);
					});
				});
			});
		})
		.catch((err) => {
			logger.error(err.message, err);
			setTimeout(appStart, 1000);
		});
}

try {
	appStart();
} catch (err) {
	logger.error(err.message, err);
	process.exit(1);
}
