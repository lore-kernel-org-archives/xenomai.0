Sender: Jeff Weber <madjsw@domain.hid>
Message-ID: <4B87ED5A.5050401@domain.hid>
Date: Fri, 26 Feb 2010 09:48:42 -0600
From: Jeff Weber <jweber@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] warnings linking demo rtdm modules
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I'm writing a kernel module that uses RTDM, and have started with a
Makefile based upon examples/rtdm/driver-api/Makefile.

Both the example Makefile, and therefore mine as well, emit linker warnings:

make -f /usr/src/linux-2.6.31.12-xenomai-2.5.1/scripts/Makefile.modpost
   scripts/mod/modpost   -i
/usr/src/linux-2.6.31.12-xenomai-2.5.1/Module.symvers -I
/usr/src/xenomai-2.5.1/examples/rtdm/driver-api/Module.symvers  -o
/usr/src/xenomai-2.5.1/examples/rtdm/driver-api/Module.symvers -S -K
/usr/src/linux-2.6.31.12-xenomai-2.5.1/Module.markers -M
/usr/src/xenomai-2.5.1/examples/rtdm/driver-api/Module.markers -w  -s
WARNING: "rtdm_dev_register"
[/usr/src/xenomai-2.5.1/examples/rtdm/driver-api/tut02-skeleton-drv.ko]
undefined!
WARNING: "rtdm_sem_init"
[/usr/src/xenomai-2.5.1/examples/rtdm/driver-api/tut02-skeleton-drv.ko]
undefined!
WARNING: "rtdm_sem_down"
[/usr/src/xenomai-2.5.1/examples/rtdm/driver-api/tut02-skeleton-drv.ko]
undefined!
...


How do I fix these warnings?

It appears modpost would be happy if given a *.symvers file for
xeno_rtdem.ko.  However I could not find such a file.

Both the demo and my modules do load without errors, however.

I have built the nucleus and rtdm kernel as modules, and am running xeno
version 2.5.1.

thanks,
Jeff


