import { log } from '@/infra/logs/logger';
import type { FastifyInstance } from 'fastify';

export const healthCheckRoute = async (server: FastifyInstance) => {
  server.get('/health', async (request, reply) => {
    log.info('Health Check OK');
    return reply.status(200).send({ message: 'Health Check OK' });
  });
};
