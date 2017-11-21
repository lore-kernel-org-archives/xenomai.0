References: <6c55f15a-66ea-a9cd-943b-ed568f229984@xenomai.org>
 <85bfdeed-375d-7073-a53f-d9d5d22f8778@alaxarxa.net>
 <62be2b45-b6f7-30b9-b3ee-891acd75ac60@xenomai.org>
 <4651e006-d67f-d442-bc12-d634ec78f897@alaxarxa.net>
 <f7f0cc07-b729-e116-82d1-fe1caecbe5c8@alaxarxa.net>
 <7d1be9ab-9ba9-9724-375d-928731213673@alaxarxa.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2b807f73-f46a-8a04-5b17-31d0bcf4ac42@xenomai.org>
Date: Tue, 21 Nov 2017 11:58:51 +0100
MIME-Version: 1.0
In-Reply-To: <7d1be9ab-9ba9-9724-375d-928731213673@alaxarxa.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai 3.0.6 doesn't build the patched kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 11/21/2017 10:16 AM, Leopold Palomo-Avellaneda wrote:
> On 20/11/17 17:26, Leopold Palomo-Avellaneda wrote:
>> On 20/11/17 17:25, Leopold Palomo-Avellaneda wrote:
>>> On 20/11/17 14:38, Philippe Gerum wrote:
>>>> On 11/20/2017 01:14 PM, Leopold Palomo-Avellaneda wrote:
>>>>> Hi,
>>>>>
>>>>> trying to build the new Xenomai version (3.0.6), after have prepared the linux
>>>>> sources, I got this error:
>>>>>
>>>>> In file included from arch/x86/xenomai/machine.c:22:0:
>>>>> arch/x86/xenomai/include/asm/xenomai/syscall.h: In function
>>>>> ‘__xn_get_syscall_nr’:
>>>>> arch/x86/xenomai/include/asm/xenomai/syscall.h:46:31: error: implicit
>>>>> declaration of function ‘__COBALT_CALL32_SYSNR’
>>>>> [-Werror=implicit-function-declaration]
>>>>>    #define __xn_syscall(regs)    __COBALT_CALL32_SYSNR(__xn_reg_sys(regs) \
>>>>>                                  ^
>>>>> arch/x86/xenomai/include/asm/xenomai/syscall.h:60:32: note: in expansion of
>>>>> macro ‘__xn_syscall’
>>>>>     return __xn_syscall_p(regs) ? __xn_syscall(regs) :
>>>>>                                   ^~~~~~~~~~~~
>>>>> cc1: some warnings being treated as errors
>>>>>
>>>>> I have used the prepare-kernel script and built the Debian packages. The
>>>>> platform is a Debian Stretch (amd64) with the default compiler.
>>>>>
>>>>> linux version linux-4.9.51 and
>>>>>
>>>>> http://xenomai.org/downloads/ipipe/v4.x/x86/ipipe-core-4.9.51-x86-4.patch
>>>>>
>>>>> as a patch.
>>>>>
>>>>>
>>>>>
>>>>
>>>> As a work around, drop CONFIG_IA32_EMULATION if you don't need it.
>>>>
> 
> Hi,
> 
> trying to compile again I found some ugly warnings (gcc-6)

[snip]

> 
> 
> it's strange to me because 3.0.5 built without any problems. Probably I activate
> something in the kernel that provoke the errors. Any idea?.
> 
> 

Not yet. Thanks for the heads up though.

We used to have a build farm for checking proper compilation of many 
configurations nightly until last year, but we do not anymore. 
Therefore, those issues are likely to pop up in the future, until the 
situation is fixed.

Meanwhile, please send me the .config privately. I'll have a look. Thanks.

-- 
Philippe.

