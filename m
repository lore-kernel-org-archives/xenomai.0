Message-ID: <8a1ce332-c142-332b-3a00-b31944d0073d@siemens.com>
Date: Tue, 1 Mar 2022 19:28:15 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] y2038: cobalt: posix/signal: Take care of compat mode
 for sigtimedwait64
Content-Language: en-US
References: <20220221132504.55876-1-florian.bezdeka@siemens.com>
 <20220221132504.55876-4-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220221132504.55876-4-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org
Cc: johannes.lauenstein@siemens.com

On 21.02.22 14:25, Florian Bezdeka wrote:
> The compat syscall was previously routed to the native entrypoint.
> While the timeout is always based on time64_t the siginfo has to be
> handled different in compat mode.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
> index 1c83ff4e3..3986b227b 100644
> --- a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
> +++ b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h
> @@ -64,6 +64,7 @@ __COBALT_CALL32emu_THUNK(sendmsg)
>  __COBALT_CALL32emu_THUNK(mmap)
>  __COBALT_CALL32emu_THUNK(backtrace)
>  __COBALT_CALL32emu_THUNK(mq_timedreceive64)
> +__COBALT_CALL32emu_THUNK(sigtimedwait64)
>  __COBALT_CALL32emu_THUNK(recvmmsg64)
>  
>  #endif /* !_COBALT_X86_ASM_SYSCALL32_TABLE_H */

There are way more new 64-bit calls. Matching their original versions
against this header, I would say we need more thunks, no?

for time64func in $(git grep 64, kernel/cobalt/posix/syscall32.c | \
  sed 's/.*(\([^6]*\)64,.*/\1/'); do
    git grep -q $time64func \
      kernel/cobalt/arch/x86/include/asm/xenomai/syscall32-table.h && \
        echo $time64func; done

sem_timedwait
clock_getres
clock_gettime
clock_settime
clock_nanosleep
mutex_timedlock
cond_wait_prologue
mq_timedsend
mq_timedreceive
sigtimedwait
monitor_wait
event_wait
recvmmsg

We now have mq_timedreceive64, sigtimedwait64 and recvmmsg64 with
thunks. There rest is missing, no?

Interestingly, we also have no thunk for old recvmmsg so far. Probably a
bug of it own.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

