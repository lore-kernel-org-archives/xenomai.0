Message-ID: <46219B08.8060507@domain.hid>
Date: Sat, 14 Apr 2007 21:24:56 -0600
From: Terry Laurenzo <tlaurenzo@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: TJ Laurenzo <tlaurenzo@domain.hid>
Subject: [Xenomai-core] RTDM SPI Driver for Blackfin 537
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

I know its not the best form to reference a blog on a mailing list, but 
I'm tired and don't want to repeat myself.  I have published information 
on an RTDM SPI Driver that I have implemented for the Blackfin 537: 
http://www.rcode.net/blog/tlaurenzo/category/linux/

I needed this for my own project but felt that it could be useful for a 
larger audience.  This was my first attempt at a "real" RTDM driver, so 
I by no means claim perfection!  Feedback or pointers are appreciated.

This driver has been used extensively on the 06R2 uClinux release.  As 
of today, I have just verified it with the 07R1 release candidate and 
the newly published Adeos patch for it.

I also have a Blackfin port of the RT 16550 Serial driver in the works 
(targeting Blackfin builtin UARTs instead of 16550) if anyone is interested.


Terry

