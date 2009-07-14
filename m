Date: Tue, 14 Jul 2009 21:14:45 +0200 (CEST)
From: "Waschk,Kolja" <xenoka09@domain.hid>
Message-ID: <alpine.DEB.2.00.0907142049190.4341@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Subject: [Xenomai-help] rtdm_mmap_to_user without MMU
Reply-To: xenoka09@domain.hid
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

Hi,

I'm starting to develop a RTDM driver to be used in uClinux on a Blackfin-based
device. Its main task is to receive lots of framed data (30 MBit/s) and pass
them to an application in user space, retaining the framing info. A major
concern is the performance. I'd like to avoid copying, so I looked into using
rtdm_mmap_to_user(). It seems to use the mmap op of /dev/zero, which is "return
ENOSYS"(*) in drivers/char/mem.c on systems without a MMU. In other words, it
doesn't seem to be usable in uClinux. Well, I could just forget about mmap,
there is no MMU and thus my user code can access the data anyway. But what'd be
the proper way to cope with this? I'd really like to code it so it would work
on a system with MMU as well (maybe in next year's project...)

Probably I'll move a bit more of the user space code (the decoding of the frame
into a larger structure) into the driver, turning the "copying" into
"decoding", which has to be done anyway. But ideally the kernel part should
be kept as simple as possible.

Kolja

(*) I might have missed something between, because the actual error code is ENODEV






