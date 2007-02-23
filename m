Message-ID: <45DEC91C.7040702@domain.hid>
Date: Fri, 23 Feb 2007 11:59:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN driver
References: <45DC1D05.1000206@domain.hid>	<bc4264770702220536veb7de41saf40e41fccbbf377@domain.hid>	<45DD9DB0.1010103@domain.hid>	<bc4264770702220557x7d43d767m5383e8d8ce60204a@domain.hid>	<45DDA504.4070408@domain.hid>	<bc4264770702220652m138956ceh32713b862ee1080a@domain.hid>	<45DDB542.2050601@domain.hid>
	<45DDFF9D.5020104@domain.hid>	<45DE0A43.8030800@domain.hid>	<bc4264770702230214l630ec862i1072083dd0236cb5@domain.hid>
	<bc4264770702230252y28552658o562d46341924ea40@domain.hid>
In-Reply-To: <bc4264770702230252y28552658o562d46341924ea40@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: Xenomai-help@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

roland Tollenaar wrote:
> Hi
> 
> Just a quick update on the situation.
> 
> 
>>>And I load the modules with the following command:
>>>
>>>   $ modprobe xeno_can_peak_dng type=epp io=0x378 irq=7
> 
> I had to sort out the module.conf matter but this now also responds with:
> 
> "No such device"
> 
> Which I presume is correct if the device is not attached?
> 
> What would be nice is a brief explantion of the paramters
> 
> io=0x378 looks like the hardware address of the parallel port. ?
> irq the interrupt request number. Why 7? Is that specific to the
> parallel port or would that be the same for all the CAN devices?
> type=epp ? What does this mean?

Maybe running modinfo xeno_can_peak_dng would help ?

-- 
                                                 Gilles Chanteperdrix

