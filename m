Message-ID: <55A7A4E2.4060309@siemens.com>
Date: Thu, 16 Jul 2015 14:34:42 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <20150702165642.GS13256@hermes.click-hack.org>
 <5595757A.60301@siemens.com> <20150702173508.GU13256@hermes.click-hack.org>
 <20150702175526.GV13256@hermes.click-hack.org> <55957B86.7020009@siemens.com>
 <20150702184232.GX13256@hermes.click-hack.org> <559587A0.7020005@siemens.com>
 <20150702185525.GY13256@hermes.click-hack.org> <559591E5.5060106@siemens.com>
 <55959E70.1020407@siemens.com> <20150703105149.GZ13256@hermes.click-hack.org>
In-Reply-To: <20150703105149.GZ13256@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Remove
 unused mode parameter from COBALT_SYSCALL
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 2015-07-03 12:51, Gilles Chanteperdrix wrote:
> On Thu, Jul 02, 2015 at 10:26:24PM +0200, Jan Kiszka wrote:
>> Just FYI - still requires testing and more review - find a first
>> generator version below.
>>
>> Jan
>>
>>
>> cobalt/posix/syscall: Generate cobalt_syscalls and cobalt_sysmodes
>>
>> ---
>>  .../arch/x86/include/asm/xenomai/syscall32.h       |  12 +-
>>  kernel/cobalt/posix/Makefile                       |  12 ++
>>  kernel/cobalt/posix/gen-syscall-entries.sh         |  24 +++
>>  kernel/cobalt/posix/syscall.c                      | 208 ++-------------------
>>  scripts/prepare-kernel.sh                          |   4 +-
>>  5 files changed, 57 insertions(+), 203 deletions(-)
>>  create mode 100755 kernel/cobalt/posix/gen-syscall-entries.sh
>>
>> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
>> index 8bd40d4..58b7336 100644
>> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
>> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
>> @@ -45,14 +45,14 @@
>>  #define __syshand32x__(__name)	((cobalt_syshand)(cobalt32x_ ## __name))
>>  
>>  #define __COBALT_CALL32x_INITHAND(__handler)	\
>> -  , [__COBALT_X32_BASE ... __COBALT_X32_BASE + __NR_COBALT_SYSCALLS-1] = __handler
>> +	[__COBALT_X32_BASE ... __COBALT_X32_BASE + __NR_COBALT_SYSCALLS-1] = __handler,
>>  
>>  #define __COBALT_CALL32x_INITMODE(__mode)	\
>> -  , [__COBALT_X32_BASE ... __COBALT_X32_BASE + __NR_COBALT_SYSCALLS-1] = __mode
>> +	[__COBALT_X32_BASE ... __COBALT_X32_BASE + __NR_COBALT_SYSCALLS-1] = __mode,
>>  
>>  /* x32 default entry (no thunk) */
>>  #define __COBALT_CALL32x_ENTRY(__name, __handler)		\
>> -	, [sc_cobalt_ ## __name + __COBALT_X32_BASE] = __handler
>> +	[sc_cobalt_ ## __name + __COBALT_X32_BASE] = __handler,
>>  
>>  /* x32 thunk installation */
>>  #define __COBALT_CALL32x_pure_THUNK(__name)	\
>> @@ -113,14 +113,14 @@
>>  #define __syshand32emu__(__name)	((cobalt_syshand)(cobalt32emu_ ## __name))
>>  
>>  #define __COBALT_CALL32emu_INITHAND(__handler)	\
>> -  , [__COBALT_IA32_BASE ... __COBALT_IA32_BASE + __NR_COBALT_SYSCALLS-1] = __handler
>> +	[__COBALT_IA32_BASE ... __COBALT_IA32_BASE + __NR_COBALT_SYSCALLS-1] = __handler,
>>  
>>  #define __COBALT_CALL32emu_INITMODE(__mode)	\
>> -  , [__COBALT_IA32_BASE ... __COBALT_IA32_BASE + __NR_COBALT_SYSCALLS-1] = __mode
>> +	[__COBALT_IA32_BASE ... __COBALT_IA32_BASE + __NR_COBALT_SYSCALLS-1] = __mode,
>>  
>>  /* ia32 default entry (no thunk) */
>>  #define __COBALT_CALL32emu_ENTRY(__name, __handler)		\
>> -	, [sc_cobalt_ ## __name + __COBALT_IA32_BASE] = __handler
>> +	[sc_cobalt_ ## __name + __COBALT_IA32_BASE] = __handler,
>>  
>>  /* ia32 thunk installation */
>>  #define __COBALT_CALL32emu_THUNK(__name)	\
> 
> Whether this is needed is debatable. From my point of view, it is
> not needed. But in any case, this has nothing to do with what this
> patch does.

It's a precondition for generating a regular list of table entries. But
I'll split this up into a separate patch.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

