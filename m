Message-ID: <2ff1a98a0804300201u2fa3d6cfgf2cd9f833ce62f4e@domain.hid>
Date: Wed, 30 Apr 2008 11:01:11 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1209512080.1662.311.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1209512080.1662.311.camel@domain.hid>
Subject: Re: [Xenomai-help] Latency test locking AT91 system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Travis Stratman <tstratman@domain.hid>
Cc: Xenomai Help List <xenomai@xenomai.org>

On Wed, Apr 30, 2008 at 1:34 AM, Travis Stratman <tstratman@domain.hid> wrote:
>  The klatency test only works the first time that I run it, all further
>  tests cause a segmentation fault. Here is the strace of the last few
>  calls on klatency when it does fail:
>  gettimeofday({1209511560, 302399}, NULL) = 0
>  rt_sigaction(SIGINT, {0x88c8, [INT], SA_RESTART|0x4000000}, {SIG_DFL},
>  8) = 0
>  rt_sigaction(SIGTERM, {0x88c8, [TERM], SA_RESTART|0x4000000}, {SIG_DFL},
>  8) = 0
>  rt_sigaction(SIGHUP, {0x88c8, [HUP], SA_RESTART|0x4000000}, {SIG_DFL},
>  8) = 0
>  rt_sigaction(SIGALRM, {0x88c8, [ALRM], SA_RESTART|0x4000000}, {SIG_DFL},
>  8) = 0
>  open("/proc/xenomai/registry/native/pipes/klat_pipe", O_RDONLY) = 3
>  read(3, "#C\0\0\0\0\0\0\220\1\0\0\321q\0\0\0\0\0\0\0\0\0\0\362\204"...,
>  32) = 32
>  --- SIGSEGV (Segmentation fault) @ 0 (0) ---
>  +++ killed by SIGSEGV +++

Yes, I discovered this issue recently but did not fix it yet. You have
to compile the klatency driver as a module and load/unload it for each
run of the klatency user-space application. If you compile the driver
as a module and use the run script, all should happen automatically.

-- 
 Gilles

