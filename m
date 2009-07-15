Date: Wed, 15 Jul 2009 16:35:21 +0200 (CEST)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <Pine.LNX.4.62.0907151048370.24398@domain.hid>
Message-ID: <Pine.LNX.4.62.0907151610090.24888@domain.hid>
References: <alpine.DEB.2.00.0907142049190.4341@domain.hid>
	<4A5D88E9.2010305@domain.hid>
	<Pine.LNX.4.62.0907151048370.24398@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] rtdm_mmap_to_user without MMU
Reply-To: Kolja Waschk <xenoka09@domain.hid>
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

I finally seem to have a complete solution for my case. It's probably
still missing one or the other detail, but it starts to work. I only
added a few lines to ksrc/skins/rtdm/drvlib.c in rtdm_do_mmap:

1. Because linux/mm/nommu.c/validate_mmap_request() checks the
capabilities of the backing dev, and /dev/zero lacks BDI_CAP_MAP_DIRECT
capability, the /dev/mem has to be used instead of /dev/zero.

> filp = filp_open("/dev/mem", O_RDWR, 0);

2. A get_unmapped_area() f_op has to be provided on nommu systems. It is
also checked by validate_mmap_request(). I just copy in the pointer from
old_fops: the /dev/mem f_op->get_unmapped_area simply passes pgoffs.

> rtdm_mmap_fops.get_unmapped_area = old_fops->get_unmapped_area;

3. Since /dev/mem is used, the offset passed to do_mmap() has to
point to the actual buffer (probably the physical address, for now I
just used mmap_data->src_vaddr).

> user_ptr = (void *)do_mmap(filp, (unsigned long)*pptr, len, prot,
>            MAP_SHARED, mmap_data->src_vaddr);

Kolja


