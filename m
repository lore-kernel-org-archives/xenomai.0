Date: Wed, 15 Jul 2009 12:24:59 +0200 (CEST)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4A5D88E9.2010305@domain.hid>
Message-ID: <Pine.LNX.4.62.0907151048370.24398@domain.hid>
References: <alpine.DEB.2.00.0907142049190.4341@domain.hid>
	<4A5D88E9.2010305@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] rtdm_mmap_to_user without MMU
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

> rtdm_mmap_to_user uses remap_pfn_range internally when there is no MMU.

Ah, thanks, I missed the part in rtdm_do_mmap where the
/dev/zero->f_op are temporarily replaced with rtdm_mmap_fops.

Now I was able to find the actual ENODEV source down in linux/mm/nommu.c
validate_mmap_request() where the following code path is followed:

if(file)
{
     ...
     if (mapping && mapping->backing_dev_info)
         capabilities = mapping->backing_dev_info->capabilities;
     ...
     if (!file->f_op->get_unmapped_area)
         capabilities &= ~BDI_CAP_MAP_DIRECT;
     ...
     if (flags & MAP_SHARED) {
         ....
         if (!(capabilities & BDI_CAP_MAP_DIRECT))
             return -ENODEV;
...

The mapping->backing_dev_info->capabilities is only BDI_CAP_MAP_COPY,
no BDI_CAP_MAP_DIRECT. So even if drvlib would provide a
get_unmapped_area op, validate_mmap_request would answer ENODEV.

It seems that /dev/mem instead of /dev/zero has the required
capabilities. So I changed rtdm_do_mmap to open dev/mem instead
of dev/zero and provide a get_unmapped_area:

#ifndef CONFIG_MMU
     rtdm_mmap_fops.get_unmapped_area = old_fops->get_unmapped_area;
#endif

Now the rtdm_mmap_to_user returns zero, indicating no error, but I still
do not get a usable pptr (it's NULL as on input) from it. I somehow
expect to get src_addr back in pptr.

> Can you provide some hardware-independent test case?

I'm using the code from 
http://www.captain.at/xenomai-real-time-driver-example.php
almost unmodified except for some plausibility checking around
mmappointer after calling the ioctl.

Kolja

