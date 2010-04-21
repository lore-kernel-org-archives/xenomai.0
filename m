Message-ID: <4BCEE8AC.4080101@domain.hid>
Date: Wed, 21 Apr 2010 13:59:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <k2xbfcfb7e81004210425l88dbbb99gb8b1ec4dd254300d@domain.hid>
In-Reply-To: <k2xbfcfb7e81004210425l88dbbb99gb8b1ec4dd254300d@domain.hid>
Content-Type: text/plain; charset=UTF-8
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

You are using Xenomai 2.5.2 right? switchtest is not working in Xenomai
2.5.2 because RTDM syscalls were switchted do __xn_exec_conforming. This
gave birth to a long discussion, and finally a commit to fix the issue.
Xenomai 2.5 current head contains this change.

> trying to test context-switch timings using 'switchtest' testsuite
> application.

switchtest does not test context switch timing.

> 
> Looking at the testsuite code, i found that
>   - 'latency' (which can successfully operate the xeno_switchtest driver )
>      uses rtdm_dev_xxx calls whereas

No, latency uses the timerbench driver. The fact that the device almost
has the same name is misleading and has been fixed in Xenomai 2.5
current head too.

>  - 'switchtest' application uses the posix 'open'/'close' system-calls
>     for driver-interaction
> 
> Looking at ksrc/drivers/testing/switchtest.c, i found that there is no
> registration
> of switchtest under linux-device-driver subsystem (even as a misc driver
> like rtnet or rtheap do).

True. But there is a registration as an RTDM device.

> Thus, there doesnt seem to be a way through which a linux-process (non-RT
> mode)
> may access xeno_switchtest driver through /dev/rttest<x>
> (or the new /dev/rttest-switchtst<x>
>   ref: https://mail.gna.org/public/xenomai-git/2010-04/msg00073.html).

No. It should work. The device is registered as an RTDM device, and the
switchtest application opens the same device using open, which is turned
into the corresponding rtdm syscall by the posix skin.

> 
> In case there is such a registration required, i would be more than willing
> to contribute.
> 
> In case, the 'open' system-call is handled by one of the skins
>  (i have native, posix,rtai and rtdm enabled in my kernel-config),
> kindly point out the code and enlighten.
> 
> Thanks for running this awesome project and all the help/pointers.

It works here, are you sure you enabled the switchtest driver?

-- 
					    Gilles.

