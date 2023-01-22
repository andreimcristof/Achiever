

using AchieverCrud.Domain.Models;

namespace AchieverCrud.Domain.Services
{
    public interface IDomainService<T> where T : Model<T>
    {
        public Task Create(string json);
        public Task Delete(string id);
        public Task<T> GetSingle(string id);
        public Task<List<T>> GetSingleWithDetails(string id);
        public Task<List<T>> GetAll();
        public Task<T> Update(string json);
    }
}