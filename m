Message-ID: <4732FC4F.1060301@domain.hid>
Date: Thu, 08 Nov 2007 13:08:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200711061807.26236.lepalom@domain.hid>
	<200711071859.33094.lepalom@domain.hid> <4732991C.1080008@domain.hid>
	<200711081041.57506.lepalom@domain.hid>
In-Reply-To: <200711081041.57506.lepalom@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] IRQ issues in xenomai and rtnet
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Leopold Palomo-Avellaneda <lepalom@domain.hid>
Cc: xenomai@xenomai.org, mathias_koehrer@domain.hid

Leopold Palomo-Avellaneda wrote:
> A Dijous 08 Novembre 2007, Roland Tollenaar va escriure:
>> so your system hanging on 
>> boot strikes me as a bit odd. Unless of course you start rtnet in one of
>> the rc bootscrips of course?
> 
> no, the hanging at boot time is when I don't put the noapic option in the 
> 2.6.22 kernels (it's known bug) with 2.6.23 depends of irqpoll, or the manual 
> assignment in the bios.

You mean this is a known mainline issue, or does it only happen with
I-pipe applied or additionally Xenomai loaded? In the former case, I
would suggest trying your scenario on a different box, as you may suffer
from at least tricky if not unfixable hardware/BIOS problems.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

