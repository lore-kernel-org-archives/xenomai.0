Subject: Re: [PATCH] Fix building eth_p_all demo with Mercury core
References: <20200924025828.21815-1-vt@altlinux.org>
 <c172ae8d-2c58-1478-0f15-e4f51cc650ff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9880bc86-1ae8-20e2-c723-9639677da7e1@siemens.com>
Date: Mon, 28 Sep 2020 19:03:03 +0200
MIME-Version: 1.0
In-Reply-To: <c172ae8d-2c58-1478-0f15-e4f51cc650ff@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Vitaly Chikunov <vt@altlinux.org>, Xenomai <xenomai@xenomai.org>

On 28.09.20 18:54, Jan Kiszka via Xenomai wrote:
> On 24.09.20 04:58, Vitaly Chikunov wrote:
>> Error message:
>>
>> In file included from eth_p_all.c:43:
>> /usr/include/xenomai/boilerplate/ancillaries.h:56:17: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘__early_panic’
>>    56 | void __noreturn __early_panic(const char *fn,
>>       |                 ^~~~~~~~~~~~~
>> /usr/include/xenomai/boilerplate/ancillaries.h:59:17: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘___panic’
>>    59 | void __noreturn ___panic(const char *fn,
>>       |                 ^~~~~~~~
>> /usr/include/xenomai/boilerplate/ancillaries.h:63:17: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘__panic’
>>    63 | void __noreturn __panic(const char *fn,
>>       |                 ^~~~~~~
>>
>> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
>> ---
>>  demo/posix/cobalt/eth_p_all.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/demo/posix/cobalt/eth_p_all.c b/demo/posix/cobalt/eth_p_all.c
>> index 91aef9fbd..ad4c54878 100644
>> --- a/demo/posix/cobalt/eth_p_all.c
>> +++ b/demo/posix/cobalt/eth_p_all.c
>> @@ -40,6 +40,7 @@
>>  #include <net/if.h>
>>  #include <arpa/inet.h>
>>  #include <netinet/ether.h>
>> +#include <boilerplate/compiler.h>
>>  #include <boilerplate/ancillaries.h>
>>  
>>  char buffer[10*1024];
>>
> 
> Thanks, applied.
> 
> Jan
> 

Strictly spoken, this is under "cobalt", originally not intended for
mercury. But nothing speaks against making this compile with any core.

But looking at the code again, the intention was not make it depend on
xenomai-specifics (boilerplate/ancillaries.h) which is now causing the
problem on mercury. Let's rather get rid of namecpy.

Pulling this back, will send a different fix.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

