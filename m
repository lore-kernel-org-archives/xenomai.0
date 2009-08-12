Message-ID: <4A82DC78.9060408@domain.hid>
Date: Wed, 12 Aug 2009 17:15:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE20060EFA4BEC@us194mx002.tycoelectronics.net>
	<4A81CA67.9060301@domain.hid> <4A81CE4F.9060301@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060EFA4DEE@us194mx002.tycoelectronics.net>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE20060EFA4DEE@us194mx002.tycoelectronics.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_setschedparam: Function not implemented
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Charlton, John" <john.charlton@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Charlton, John wrote:
> Gilles,
> 
> Thank you for the reply.  Here is the output of ld-linux.so.2.  I do not have ldd on the open embedded target embedded controller:
> ld-linux.so.2 --list ./latency:
>         linux-gate.so.1 =>  (0xffffe000)
>         libnative.so.1 => /usr/xenomai/lib/libnative.so.1 (0xb7f1c000)
>         librtdm.so.1 => /usr/xenomai/lib/librtdm.so.1 (0xb7f1a000)
>         libpthread.so.0 => /lib/libpthread.so.0 (0xb7eff000)
>         libm.so.6 => /lib/libm.so.6 (0xb7ed9000)
>         libc.so.6 => /lib/libc.so.6 (0xb7da4000)
>         /lib/ld-linux.so.2 (0xb7f23000)
> 
> ld-linux.so.2 --list ./cyclictest:
>         linux-gate.so.1 =>  (0xffffe000)
>         libpthread_rt.so.1 => /usr/xenomai/lib/libpthread_rt.so.1 (0xb7fbe000)
>         libpthread.so.0 => /lib/libpthread.so.0 (0xb7fa3000)
>         librt.so.1 => /lib/librt.so.1 (0xb7f8e000)
>         libc.so.6 => /lib/libc.so.6 (0xb7e59000)
>         /lib/ld-linux.so.2 (0xb7fc8000)

These two are Ok. I think your debug log contained the output of several
commands. You should try and run the commands one by one by yourself,
and report the errors you get for the command that produce it.

> 
> .config:
(snip)
> CONFIG_XENO_SKIN_POSIX=y

Well, since the POSIX skin is enabled, you should not get the message
Xenomai Posix skin init: pthread_setschedparam: Function not
implemented. Are you sure you run the kernel you think you are running?

(snip)
> CONFIG_XENO_DRIVERS_TIMERBENCH=m

timerbench is configured as a module, you should load it before you run
latency -t 1 or latency -t 2, or you will get the message:

latency: failed to open benchmark device, code -38
(modprobe xeno_timerbench?)

Note that the error message gives you the solution.

>> Exactly what version of Xenomai kernel-space suppors runs with what
>> version of user-space support?

You did not answer that question. With what version of Xenomai
user-space and kernel-space do you get these issues?

-- 
                                          Gilles


