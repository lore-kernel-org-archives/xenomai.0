Message-ID: <4F173B1C.3000300@domain.hid>
Date: Wed, 18 Jan 2012 22:35:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CA+vRzyJBZswywEyhG8JUXZRr3j7tKwhOaT1nKJti4ScLn7sZLg@domain.hid>
In-Reply-To: <CA+vRzyJBZswywEyhG8JUXZRr3j7tKwhOaT1nKJti4ScLn7sZLg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] "Inappropriate ioctl for device" with
 xeno_16550A on Xenomai 2.6, not Xenomai 2.5
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Manuel Vonthron <manuel.vonthron@domain.hid>
Cc: xenomai@xenomai.org

On 01/18/2012 10:09 PM, Manuel Vonthron wrote:
> Dear all,
> 
> I am using the driver "xeno_16550A" for serial communication between a
> powersupply and its controlling PC (x86). I started working with Xenomai
> 2.5.5, but I recently switched to another machine where I installed Xenomai
> 2.6.
> 
> On this new machine, I get the "Inappropriate ioctl for device" error while
> setting up my serial connection:
>   err = rt_dev_ioctl(fd, RTSER_RTIOC_SET_CONFIG, &serial_config);
>   >> error -25: Inappropriate ioctl for device
> The following reads/writes don't fail but without proper configuration,
> messages aren't understood by the device.
> 
> My tests with non-RT code and the regular Linux driver keeps working with
> this new machine and again, the RT code is the very same, I only updated my
> Makefile to match the new version.
> 
> - setserial infos:
>   /dev/ttyS0 uart 16550A port 0x03f8 irq 4 baud_base 115200 spd_normal
> skip_test
> - xeno_16550A loaded with:
>   `modprobe -v xeno_16550A io=0x03f8 irq=4 baud_base=115200`
> - result of "rtdm" unit test:
>   SetupExclusive openSuccessive openDefer close by driver handlerDefer
> close by pending referenceNormal closeDeferred module unload#
> 
> Do you have any idea where the error comes from and how would I fix it?

It could be due to the version of gc. Try passing
CFLAGS="-fno-omit-frame-pointer"
on configure commande line.

-- 
                                                                Gilles.

