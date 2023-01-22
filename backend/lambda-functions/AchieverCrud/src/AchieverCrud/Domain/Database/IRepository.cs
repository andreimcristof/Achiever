using AchieverCrud.Domain.Models;
using Amazon.Lambda.Core;

namespace AchieverCrud.Domain.Database
{
    public interface IRepository<T> where T : Model<T>
    {
        /// <summary>
        /// Gets the specified item by id.
        /// </summary>
        /// <param name="id"></param>
        /// <param name="keyAddition">some databases (like dynamodb) need a key composed of two items. This param allows for it.</param>
        /// <returns></returns>
        public Task<T> GetSingle(string id);
        public Task<List<T>> GetGroupedInfo(string id);
        public Task<List<T>> GetAll();
        public Task Create(T item);
        public Task<T> Update(T item);
        public Task Delete(string id);
    }
}