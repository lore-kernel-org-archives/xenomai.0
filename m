Message-ID: <4A5D88E9.2010305@domain.hid>
Date: Wed, 15 Jul 2009 09:44:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <alpine.DEB.2.00.0907142049190.4341@domain.hid>
In-Reply-To: <alpine.DEB.2.00.0907142049190.4341@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rtdm_mmap_to_user without MMU
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

Waschk,Kolja wrote:
> Hi,
> 
> I'm starting to develop a RTDM driver to be used in uClinux on a Blackfin-based
> device. Its main task is to receive lots of framed data (30 MBit/s) and pass
> them to an application in user space, retaining the framing info. A major
> concern is the performance. I'd like to avoid copying, so I looked into using
> rtdm_mmap_to_user(). It seems to use the mmap op of /dev/zero, which is "return
> ENOSYS"(*) in drivers/char/mem.c on systems without a MMU. In other words, it

rtdm_mmap_to_user uses remap_pfn_range internally when there is no MMU.
And IIRC, it is supposed to work also in this scenario. You may just not
expect being able to specify a remap target address...

> doesn't seem to be usable in uClinux. Well, I could just forget about mmap,
> there is no MMU and thus my user code can access the data anyway. But what'd be
> the proper way to cope with this? I'd really like to code it so it would work
> on a system with MMU as well (maybe in next year's project...)
> 
> Probably I'll move a bit more of the user space code (the decoding of the frame
> into a larger structure) into the driver, turning the "copying" into
> "decoding", which has to be done anyway. But ideally the kernel part should
> be kept as simple as possible.

Yes, generally the right approach.

> 
> Kolja
> 
> (*) I might have missed something between, because the actual error code is ENODEV

Can you provide some hardware-independent test case?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

