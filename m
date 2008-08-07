Message-ID: <489ABCD3.1020208@domain.hid>
Date: Thu, 07 Aug 2008 11:13:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2b490f270808061420l5da130b1sb8a2ccd9c34d46f5@domain.hid>
In-Reply-To: <2b490f270808061420l5da130b1sb8a2ccd9c34d46f5@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] SATA problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dehann Fourie <dehann.fourie@domain.hid>
Cc: xenomai@xenomai.org

Dehann Fourie wrote:
> Hi,
> 
> I have changed to a SATA hard drive on my Xeno machine, but now have kernel
> panic - not sync: unable to kill init! I have done some reading on the sda?
> destination for a SATA device. It seems to me that the PC doesn't find the
> SATA hard drive and I suspect the problem is at root="\dev\sda1" in the
> grub. Part I don't get is that it is the same as my original kernel? My
> config is:
> 
> AMD Geode 500MHz
> single partition SATA hard drive
> Debian 4.03
> Xenomai 2.4.4
> vanilla kernel 2.6.25

"kernel panic - not sync: unable to kill init", the real message comes
before, and generally the most important error message is the first one.

First, to see if the problems comes or not from Xenomai, I advise to
compile a kernel without Xenomai and I-pipe support first.

If you still have a problem without Xenomai and I-pipe support, then I
am afraid you are writing to the wrong list: we know how to compile
Linux, but not every specific detail about every IDE controller.

Now, from what I read in the kernel configuration, it seems that the
kernel has no support for SATA controllers for Geode. The only
controllers for Geode I see are:
- In the ATA/ATAPI/MFM/RLL support menu:
  . AMD CS5535 chipset support
- In the Serial ATA (prod) and Parallel ATA (experimental) drivers menu:
  . CS5510/5520 PATA support

All of them PATA controllers. I do not really know if PATA drivers in
the "experimental" menu appear as /dev/sda or /dev/hda, but you may try
this. And in any case, the boot logs should help you (when the IDE
controller is correctly configured, you should see messages about the
IDE disks detected and their name).

-- 
                                                 Gilles.

