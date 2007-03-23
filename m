From: xenomai@domain.hid
Subject: Re: [Xenomai-help] New install of Xenomai 2.3 for 2.6.17 kernel....
	Various problems
Date: Fri, 23 Mar 2007 15:33:45 +0000
Message-Id: <032320071533.27467.4603F3590000E5E600006B4B2216557996070E0301020A98@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

> Btw, make sure 100% that all your modules issued from the kernel
> compilation in question have been properly installed under /lib/modules.
> 
> Additionally, it has been reported (and I recently experienced this
> myself) than under some specific circumstances, only running a "make
> clean" in an old Xenomai-enabled kernel tree before upgrading the
> Xenomai support with prepare-kernel.sh, then compiling anew, is _not_
> enough. This may introduce some funky issues, likely due to missed
> dependencies in the kernel tree.


I did originally build the kernel form fresh source and have only patched once.  I am however rebuilding after a make mrproper just for kicks.  Since building the nucleus as a module, It appears that things are being scheduled on both processors  for linux.  I still however can't get my network connection to work properly.  It is a Broadcom NetExtreme GigE card.  It successfully get's a DHCP address as if it is working fine.  No messages in any of the log files.  I however can not get out at all.  When trying to get in from the outside with ssh it supplies me the host key but then hangs for about 1 minute then prompts me for a password and works fine from there.    From inside, even pings dont work.

Mike

