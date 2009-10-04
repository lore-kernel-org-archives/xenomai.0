Date: Sat, 3 Oct 2009 18:58:06 -0700
From: Joaquin Rapela <rapela@domain.hid>
Message-ID: <20091004015806.GA31497@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-help] kernel panic & quick build guide
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org
Cc: Nadav Ivzan <ivzan@domain.hid>


Hello list,

I am following the "Xenomai quick build guide" http://www.xenomai.org/index.php/Xenomai_quick_build_quide to install xenomai version 2.4.4 with linux kernel 2.6.25.11. I am running ubuntu on an IBM Thinkpad Z60t. When I try to boot the
2.6.25.11-xenomai-2.4.4 image I get the following kernel panic error: 

> Please append a correct "root=" boot options; here are teh available partitions:
> 0100    65536 ram0 (driver?)
> 0101    65536 ram1 (driver?)
...
> 0300 78150744 hda driver: ide-disk
> 0301    76670181 hda1
> 0302           1 hda2
> 0305     1477948 hda5
>
> Kernel panic - not syncing: VFS: Unable to mount root fs on unkown-block (0,0)

My xenomai entry in /boot/grub/menu.lst is:

> title		kernel 2.6.25.11 with xenomai 2.4.4 and Ubuntu 8.04
> root		(hd0,0)
> kernel	/boot/vmlinuz-2.6.25.11-xenomai-2.4.4 root=/dev/sda1 ro xeno_nucleus.xenomai_gid=1001

I googled this problem, and the main suggestion that I found is to compile my
hard disk drivers not as a module, but compile it into the kernel itself. I am
not sure if I am doing this correctly. In an attempt to do this, I selected the
following options in menuconfig:

> Device Drivers  --->  SCSI device support  --->   <*> SCSI disk support
(because my disk is SCSI)

> Device Drivers --->  ATA/ATAPI/MFM/RLL support  --->   Include IDE/ATA-2 DISK
> support 

> In the section   *** PCI IDE chipsets support *** of Device Drivers ---> I
> compiled into the kernel all the drivers that were marked as modules.

> In the section File systems  ---> I compiled into the kernel
> <*> Ext3 journalling file system support
> [*]   Ext3 extended attributes
> [*]     Ext3 POSIX Access Control Lists
> [*]     Ext3 Security Labels

Am I missing an important options?

Some info about my computer:

> Thinkpad Z60t running Ubuntu 8.04.

> # uname -a
> Linux guest-wireless-204-140-139-048.usc.edu 2.6.24-24-generic #1 SMP Fri Jun 5 10:34:09 UTC 2009 i686 GNU/Linux

My hard disk is a:

> # lshw -C disk
>
>   *-disk                  
>        description: ATA Disk
>        product: TOSHIBA MK8032GS
>        vendor: Toshiba
>        physical id: 0
>        bus info: scsi@domain.hid
>        logical name: /dev/sda
>        version: AS11
>        serial: 95LX0568T
>        size: 74GiB (80GB)
>        capabilities: partitioned partitioned:dos
>        configuration: ansiversion=5 signature=cccdcccd
 
I would greatly appreciate any hint.

Cordially, Joaquin

-- 
Joaquin Rapela
PhD Student, Electrical Engineering
University of Southern California
Los Angeles, CA 90089-2520
tel/fax: (213) 821-2070
http://www-scf.usc.edu/~rapela
----------------------------------

"Everyone believes himself a priori to be perfectly free, even in his
 individual actions, and thinks that at every moment he can commence another
 manner of life ... But a posteriori, through experience, he finds to his
 astonishment that he is not free, but subjected to necessity, that in spite of
 all his resolutions and reflections he does not change his conduct, and that
 from the beginning of his life to the end of it, he must carry out the very
 character which he himself condemns."
                                                             The Wisdom of Life
                                                            Arthur Schopenhauer

