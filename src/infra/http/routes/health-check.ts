import type { FastifyInstance } from 'fastify';

export const healthCheckRoute = async (server: FastifyInstance) => {
  server.get('/health', async (request, reply) => {
    return reply.status(200).send({ message: 'ECS Health Check OK' });
  });
};
