Message-ID: <bc4264770702230214l630ec862i1072083dd0236cb5@domain.hid>
Date: Fri, 23 Feb 2007 10:14:20 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] CAN driver
In-Reply-To: <45DE0A43.8030800@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45DC1D05.1000206@domain.hid> <45DD9814.4060809@domain.hid>
	<bc4264770702220536veb7de41saf40e41fccbbf377@domain.hid>
	<45DD9DB0.1010103@domain.hid>
	<bc4264770702220557x7d43d767m5383e8d8ce60204a@domain.hid>
	<45DDA504.4070408@domain.hid>
	<bc4264770702220652m138956ceh32713b862ee1080a@domain.hid>
	<45DDB542.2050601@domain.hid> <45DDFF9D.5020104@domain.hid>
	<45DE0A43.8030800@domain.hid>
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
Cc: Xenomai-help@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

Hi Wolfgang,

> Well, the modules name is xeno_can_peak_dng.ko as listed when doing:
>
>    $ make modules
>    ...
>    LD [M]  drivers/xenomai/can/sja1000/xeno_can_peak_dng.ko
Yes I have this.

>                                        ^^^^^^^^^^^^^^^^^^^^
> And I load the modules with the following command:
>
>    $ modprobe xeno_can_peak_dng type=epp io=0x378 irq=7
I am having trouble here. The above line returns:
FATAL Module xeno_can_peak_dng not found

even when I call it from the directory the driver is in.

insmod from the directory I have the driver in returns:

insmod: error inserting 'xeno_can_peak_dng.ko': -1 no such device.

Any idea what may be wrong?

Regards,

Roland



>
> Wolfgang.
>
>

