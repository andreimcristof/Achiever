using AchieverCrud.Domain.Database;
using AchieverCrud.Domain.Models;
using Amazon.Lambda.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AchieverCrud.Domain.Services
{
    public class DomainService<T> : IDomainService<T> where T: Model<T>
    {
        private readonly ILambdaLogger logger;
        private readonly IRepository<T> repository;
        public DomainService(IRepository<T> repository, ILambdaLogger logger) 
        { 
            this.repository = repository;
            this.logger = logger;
        }

        public async Task Create(string json)
        {
            T? item = Model<T>.FromJson(json);

            if (item != null)
            {
                try
                {
                    await repository.Create(item);
                }
                catch (Exception e)
                {
                    logger.LogError($"Error creating: {e.Message}{e.StackTrace}");
                    throw;
                }
            }
            else
            {
                throw new Exception("Cannot parse json data");
            }
        }

        public async Task Delete(string id)
        {
            try
            {
                await repository.Delete(id);
            }
            catch (Exception e)
            {
                logger.LogError($"Error deleting: {e.Message}{e.StackTrace}");
                throw;
            }
        }

        public async Task<List<T>> GetSingleWithDetails(string id)
        {
            try
            {
                return await repository.GetGroupedInfo(id);
            }
            catch (Exception e)
            {
                logger.LogError($"Error getting group: {e.Message}{e.StackTrace}");
                throw;
            }
        }

        public async Task<List<T>> GetAll()
        {
            try
            {
                return await repository.GetAll();
            }
            catch (Exception e)
            {
                logger.LogError($"Error getting all: {e.Message}{e.StackTrace}");
                throw;
            }
        }

        public async Task<T> Update(string json)
        {
            T? item = Model<T>.FromJson(json);
            try
            {
                if (item != null)
                {
                    return await repository.Update(item);
                }
                else
                {
                    throw new Exception("Cannot parse json data");
                }
            }
            catch (Exception e)
            {
                logger.LogError($"Error updating: {e.Message}{e.StackTrace}");
                throw;
            }
        }

        public async Task<T> GetSingle(string id)
        {
            try
            {
                return await repository.GetSingle(id);
            }
            catch (Exception e)
            {
                logger.LogError($"Error getting single: {e.Message}{e.StackTrace}");
                throw;
            }
        }
    }
}
