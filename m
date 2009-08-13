Message-ID: <035001ca1c6b$92879d40$0109220a@domain.hid>
From: "Henry Bausley" <hbausley@domain.hid>
References: <004301c9a683$c6b00200$0109220a@domain.hid>	<004801c9a69a$4a63aaf0$0109220a@domain.hid>
	<49BFBF48.7080102@domain.hid> <49BFCAEB.8080007@domain.hid>
	<001801c9a734$e0c7ac90$0109220a@domain.hid>
	<49BFEA33.5090803@domain.hid>
Date: Thu, 13 Aug 2009 15:12:47 -0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ENXIO error with large shared memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This problems was due to the limits of vmalloc.  To increase
the limit required changing the PAGE_OFFSET

The virtual address space used by vmalloc() is in the
range of VMALLOC_START and VMALLOC_END. If
CONFIG_HIGMEM is defined while building the kernel (it
will be, if the machine has more than 1GB memory), and
the PAGE_OFFSET is the default value of 0xc0000000,
this range is approximately 0xf8000000 to 0xfe000000.
This is about 96MB.
from ->  http://mail.nl.linux.org/kernelnewbies/2001-12/msg00004.html


then changed the advanced kernel settings

#
# Advanced setup
#
CONFIG_ADVANCED_OPTIONS=y
# CONFIG_LOWMEM_SIZE_BOOL is not set
CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_PAGE_OFFSET_BOOL=y
CONFIG_PAGE_OFFSET=0x80000000
CONFIG_KERNEL_START_BOOL=y
CONFIG_KERNEL_START=0x80000000
CONFIG_PHYSICAL_START=0x00000000
CONFIG_TASK_SIZE_BOOL=y
CONFIG_TASK_SIZE=0x80000000
# CONFIG_CONSISTENT_START_BOOL is not set
CONFIG_CONSISTENT_START=0xff100000


from

#
# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set

#
# Default settings for advanced configuration options are used
#
CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_PAGE_OFFSET=0xc0000000
CONFIG_KERNEL_START=0xc0000000
CONFIG_PHYSICAL_START=0x00000000
CONFIG_TASK_SIZE=0xc0000000
CONFIG_CONSISTENT_START=0xff100000
CONFIG_CONSISTENT_SIZE=0x00200000
CONFIG_NET=y



----- Original Message ----- 
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
To: "Henry Bausley" <hbausley@domain.hid>
Cc: <xenomai@xenomai.org>
Sent: Tuesday, March 17, 2009 10:21 AM
Subject: Re: [Xenomai-help] ENXIO error with large shared memory


> Henry Bausley wrote:
>> The patch makes it work for 32M.  However if I try to go larger ie.48M or
>> 64M I get the following
>
> Do you get the same error if you only run a simple program that does
> such a big allocation ?
>
> In other words, is it the big allocation by itself which causes this
> "badness" or the accumulation of allocations (and possible memory
> corruption).
>
> You should be aware that the vmalloc space also has limits. Why do you
> need to share such big areas between kernel and user-space ?
>
> -- 
>                                                 Gilles. 




**********************************************************
Outbound scan for Spam or Virus by Barracuda at Delta Tau
**********************************************************

