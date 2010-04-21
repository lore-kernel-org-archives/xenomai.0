Message-ID: <4BCEE77E.1060304@domain.hid>
Date: Wed, 21 Apr 2010 13:54:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <k2xbfcfb7e81004210425l88dbbb99gb8b1ec4dd254300d@domain.hid>
In-Reply-To: <k2xbfcfb7e81004210425l88dbbb99gb8b1ec4dd254300d@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [xeno_switchtest] missing linux-dev registration?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Nero Fernandez <grimlynch@domain.hid>
Cc: xenomai@xenomai.org

Nero Fernandez wrote:
> This is regarding the pervasive error "Unable to open switchtest device"
> while
> trying to test context-switch timings using 'switchtest' testsuite
> application.
> 
> Looking at the testsuite code, i found that
>   - 'latency' (which can successfully operate the xeno_switchtest driver )
>      uses rtdm_dev_xxx calls whereas
>  - 'switchtest' application uses the posix 'open'/'close' system-calls
>     for driver-interaction
> 
> Looking at ksrc/drivers/testing/switchtest.c, i found that there is no
> registration
> of switchtest under linux-device-driver subsystem (even as a misc driver
> like rtnet or rtheap do).

No, those devices (though they may have '/dev/' in their path when used
in POSIX apps) only show up in the RTDM namespace, which is decoupled
from Linux. See /proc/xenomai/named_devices for registered devices.

And the frontends only accesses the RTDM versions (actually, POSIX apps
fall back to the Linux namespace if there is not match in RTDM, but the
latter is then normally the problem).

> Thus, there doesnt seem to be a way through which a linux-process (non-RT
> mode)
> may access xeno_switchtest driver through /dev/rttest<x>
> (or the new /dev/rttest-switchtst<x>
>   ref: https://mail.gna.org/public/xenomai-git/2010-04/msg00073.html).
> 
> In case there is such a registration required, i would be more than willing
> to contribute.
> 
> In case, the 'open' system-call is handled by one of the skins
>  (i have native, posix,rtai and rtdm enabled in my kernel-config),
> kindly point out the code and enlighten.

Can you clarify your test setup again? What Xenomai versions (kernel &
userland) are you using? Is it a regression? What are the steps that
lead to this error?

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

