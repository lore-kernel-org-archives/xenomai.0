Message-ID: <4D3AEC05.20609@domain.hid>
Date: Sat, 22 Jan 2011 15:39:01 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF53B8EEE0.69903FD4-ONC125781F.002A9283-C125781F.002FEBD2@domain.hid>
In-Reply-To: <OF53B8EEE0.69903FD4-ONC125781F.002A9283-C125781F.002FEBD2@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] debug posix skin - pthread_cond_wait return EPERM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Pierre.QUELIN@solystic.com wrote:
> 
>> Kolja Waschk wrote:
>>>>> file cond-torture-posix
>>>> Ok. On my side: I call set solib-absolute-prefix to where the debug
>>>> binaries for the target filesystem are. And I call
>>>> handle SIG34 nostop noprint pass.
>>>>
>>>> Coud you try and do the same?
>>> Is SIG34 the same on blackfin? I do not remember ever having seen SIG34,
> only
>>> SIG32 ("Real-time event 32")
>>>
>>> Independent of that, the result is always the same SEGV. I cannot use
> the absolute-prefix currently, as the directory layout is different on the
> target. So my script is now
>>> set solib-absolute-prefix notexistent
>>> set
> solib-search-path /opt/uClinux/blackfin-linux-dist/staging/usr/lib:/opt/uClinux/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib
> 
>>> file cond-torture-posix
>>> handle SIG34 nostop noprint pass
>>> target remote 10.0.10.9:2222
>>>
>>> And regardless whether I add an "break main", the SEGV will occur
> immediately after telling gdb to "cont".
>>> Does my "try.c" always succeed (all errbits=0x0010) in your environment?
>> Ok, I get the failure if I set up a breakpoint right after the call to
>> pthread_cond_wait, as noted by Pierre. After some debugging, it appears
>> that the syscall is restarted whereas it should return to user-spacce
>> and let the user-space skin do its job. So, it seems that somehow, the
>> behaviour is different for gdb signals than for usual signals.
>>
>> Working on it now, will tell you when we have a status.
> 
> The following patch seems to fix the issue, but I am not yet sure
> whether it is really correct:
> 
> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
> index d27494c..717a8a0 100644
> --- a/ksrc/nucleus/shadow.c
> +++ b/ksrc/nucleus/shadow.c
> @@ -770,7 +770,7 @@ static inline void request_syscall_restart(xnthread_t
> *thread,
>                          if (__xn_interrupted_p(regs)) {
>                                      __xn_error_return(regs,
>                                                                (sysflags &
> __xn_exec_norestart) ?
> -
> -ERESTARTNOHAND : -ERESTARTSYS);
> +                                                              -EINTR :
> -ERESTARTSYS);
>                                      notify = !xnthread_test_state(thread,
> XNDEBUG);
>                          }
> 
> 
> 
> --
>                                                                 Gilles.
> 
> Sorry but I'm a novice.
> 
> As I understand, your patch is a kernel patch and I need to rebuild the
> kernel package.

Yes.

> Where can I find the cond-torture-posix application to reproduce the
> problem with your test case ?

It is part of Xenomai installation.

> My PC is a very standard one (Xeon dual core and my distro an Ubuntu 10.10
> so I think it's very easy to reproduce the test case.
> Do you know if there is a bug tracker where tickets are logged to be
> informed when this point will be solved ?

No. We use the mailing list for this. From our point of view, however,
the point is solved.

Also note that I did not replied to you personally, only to the list,
because otherwise I receive spam from you.

-- 
                                                                Gilles.

