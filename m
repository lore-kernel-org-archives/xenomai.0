Message-ID: <4D388975.80606@domain.hid>
Date: Thu, 20 Jan 2011 20:13:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>	<alpine.DEB.1.10.1101200922440.1211@domain.hid>	<4D384CC9.2040303@domain.hid>	<alpine.DEB.1.10.1101201702340.1990@domain.hid>	<4D386922.5080807@domain.hid>	<alpine.DEB.1.10.1101201811090.1990@domain.hid>
	<4D38809E.3080906@domain.hid>
In-Reply-To: <4D38809E.3080906@domain.hid>
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
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org, Pierre.QUELIN@solystic.com

Gilles Chanteperdrix wrote:
> Kolja Waschk wrote:
>>>> file cond-torture-posix
>>> Ok. On my side: I call set solib-absolute-prefix to where the debug
>>> binaries for the target filesystem are. And I call
>>> handle SIG34 nostop noprint pass.
>>>
>>> Coud you try and do the same?
>> Is SIG34 the same on blackfin? I do not remember ever having seen SIG34, only
>> SIG32 ("Real-time event 32")
>>
>> Independent of that, the result is always the same SEGV. I cannot use the absolute-prefix currently, as the directory layout is different on the target. So my script is now
>>
>> set solib-absolute-prefix notexistent
>> set solib-search-path /opt/uClinux/blackfin-linux-dist/staging/usr/lib:/opt/uClinux/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib
>> file cond-torture-posix
>> handle SIG34 nostop noprint pass
>> target remote 10.0.10.9:2222
>>
>> And regardless whether I add an "break main", the SEGV will occur immediately after telling gdb to "cont".
>>
>> Does my "try.c" always succeed (all errbits=0x0010) in your environment?
> 
> Ok, I get the failure if I set up a breakpoint right after the call to
> pthread_cond_wait, as noted by Pierre. After some debugging, it appears
> that the syscall is restarted whereas it should return to user-spacce
> and let the user-space skin do its job. So, it seems that somehow, the
> behaviour is different for gdb signals than for usual signals.
> 
> Working on it now, will tell you when we have a status.

The following patch seems to fix the issue, but I am not yet sure 
whether it is really correct:

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index d27494c..717a8a0 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -770,7 +770,7 @@ static inline void request_syscall_restart(xnthread_t *thread,
 		if (__xn_interrupted_p(regs)) {
 			__xn_error_return(regs,
 					  (sysflags & __xn_exec_norestart) ?
-					  -ERESTARTNOHAND : -ERESTARTSYS);
+					  -EINTR : -ERESTARTSYS);
 			notify = !xnthread_test_state(thread, XNDEBUG);
 		}
 


-- 
                                                                Gilles.

