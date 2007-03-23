From: xenomai@domain.hid
Subject: Re: [Xenomai-help] New install of Xenomai 2.3 for 2.6.17 kernel....
	Various problems
Date: Fri, 23 Mar 2007 17:20:17 +0000
Message-Id: <032320071720.17158.46040C510000F948000043062216557996070E0301020A98@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Noulard <eric.noulard@domain.hid>
Cc: xenomai@xenomai.org


 > I did configure a dual-core box with Broadcom GigE I/F and experience
> trouble weird behavior and total lockup if
>  MSI was enabled
>  HPET was enabled.
> 
> My trouble comes out only to 1 of the 3 ethernet I/F but...
> 
> I disabled MSI and HPET and all is working fine until now (with xenomai 2.3.0).
> 

I ended up turning off the SUSE Firewall and I could get out.  I'll look into why that is happening later.  I am back to my 100% cpu usage problem though.... As soon as I load the xeno-timerbench module either the beagled or hald peg the cpu.  If I don't load xeno-timerbench, it doesn't happen.  Only one process does this... never both.

Mike

