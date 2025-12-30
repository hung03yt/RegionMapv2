using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Volo.Abp.AspNetCore.Mvc;

namespace RegionMap.Controllers
{
    [AllowAnonymous]
    [Route("api/hello")]
    public class HelloController : AbpController
    {
        [HttpGet]
        public string Get() => "hello";
    }
}
