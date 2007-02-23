Message-ID: <bc4264770702230404w42cc72c2ke9d6f3affe2e7244@domain.hid>
Date: Fri, 23 Feb 2007 12:04:18 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] CAN driver
In-Reply-To: <45DEC91C.7040702@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45DC1D05.1000206@domain.hid>
	<bc4264770702220557x7d43d767m5383e8d8ce60204a@domain.hid>
	<45DDA504.4070408@domain.hid>
	<bc4264770702220652m138956ceh32713b862ee1080a@domain.hid>
	<45DDB542.2050601@domain.hid> <45DDFF9D.5020104@domain.hid>
	<45DE0A43.8030800@domain.hid>
	<bc4264770702230214l630ec862i1072083dd0236cb5@domain.hid>
	<bc4264770702230252y28552658o562d46341924ea40@domain.hid>
	<45DEC91C.7040702@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-help@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

Hi Gilles,

Thanks
>
> Maybe running modinfo xeno_can_peak_dng would help ?
>

filename:       xeno_can_peak_dng.ko
author:         Wolfgang Grandegger <wg@domain.hid>
description:    RTCAN board driver for PEAK-Dongle
license:        GPL
vermagic:       2.6.16 486 gcc-3.4
depends:
parm:           irq:The interrupt number (array of byte)
parm:           io:The io-port address (array of ushort)
parm:           type:The type of interface (sp, epp) (array of charp)


This is the output. This is probably a beginners question but why irq
7 must be supplied and what sp or epp means is not answered by this
info.

Any idea?

Regards,

Roland.


> --
>                                                  Gilles Chanteperdrix
>

