Message-ID: <4936C897.1000406@domain.hid>
Date: Wed, 03 Dec 2008 18:57:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <493306F5.2080605@domain.hid>
	<49330CD3.4090700@domain.hid>	<4933BAE2.3000502@domain.hid>
	<4933F1A4.8060209@domain.hid>
	<4933F18F.7080103@domain.hid> <4933FE5A.5060501@domain.hid>
	<49355B5D.8070802@domain.hid> <49355A59.4050600@domain.hid>
	<49357C02.1090001@domain.hid> <49365C69.5040807@domain.hid>
	<49366B2B.4050705@domain.hid> <493689EB.8000300@domain.hid>
	<4936C9CA.1090507@domain.hid>
In-Reply-To: <4936C9CA.1090507@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread cancelation and scheduling magics
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Running under gdb shows:
> 
>   Program received signal SIGSEGV, Segmentation fault.
>   [Switching to Thread 0x4885d4b0 (LWP 1127)]
>   0x0ff49100 in pthread_cancel () from /lib/libpthread.so.0
>   (gdb) where
>   #0  0x0ff49100 in pthread_cancel () from /lib/libpthread.so.0
>   #1  0x10001d64 in ctrl_func (parm=0x0) at cancel-test.c:104
>   #2  0x0ffa98e4 in __pthread_trampoline ()
>      from /home/wolf/xenomai/lib/libpthread_rt.so.1
>   #3  0x0ff42a6c in start_thread () from /lib/libpthread.so.0
>   #4  0x0fdd18a0 in clone () from /lib/libc.so.6
>   Backtrace stopped: previous frame inner to this frame (corrupt stack?)
> 
> Is pthread_cancel used from the Linux pthread library? And
> pthread_testcancel() as well?

Yes, and I guess, as you said, that it happens because calc_func is dead
when you try and cancel it.

-- 
                                                 Gilles.

