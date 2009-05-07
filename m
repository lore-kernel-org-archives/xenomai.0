Message-ID: <4A02DBE5.1010704@domain.hid>
Date: Thu, 07 May 2009 15:02:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A0198FCE1@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A0198FCE1@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] sem_wait increments fault counter
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

roderik.wildenburg@domain.hid wrote:
> Dear Gurus,
> 
> every time I call sem_wait a fault counter is incremented (TRAP 0).
> sem_wait itself does not return an error :
> 
> uc101 # cat /proc/xenomai/faults
> TRAP         CPU0
>   0:            1    (Data or instruction access)
>   1:            0    (Alignment)
>   2:            0    (Altivec unavailable)
>   3:            0    (Program check exception)
>   4:            0    (Machine check exception)
>   5:            0    (Unknown)
>   6:            0    (Instruction breakpoint)
>   7:            0    (Run mode exception)
>   8:            0    (Single-step exception)
>   9:            0    (Non-recoverable exception)
>  10:            0    (Software emulation)
>  11:            0    (Debug)
>  12:            0    (SPE)
>  13:            0    (Altivec assist)
> 
> what could be the reason for this? Is this serious?
> I have to add that sem_wait is called form a Linux-Prozess (linked with
> xenomai libraries, but no xenomai thread is created) when this happens.

Your not enough specific to get an answer. Are you talking about Linux'
sem_wait or about Xenomai's sem_wait ? What Xenomai library are you
talking about, Xenomai native skin library or Xenomai posix skin library
? If using the Xenomai posix skin library (which would mean that you use
in fact Xenomai's sem_wait), the main thread is actually a xenomai
thread, and in order to actually not create a xenomai thread, you would
have to call __real_pthread_create instead of pthread_create. Otherwise,
all threads are Xenomai threads.

-- 
                                                 Gilles.

