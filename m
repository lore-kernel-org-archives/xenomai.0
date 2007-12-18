Message-ID: <4767D7A4.7070008@domain.hid>
Date: Tue, 18 Dec 2007 15:22:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <7289437c0712140324s41dd3255u9534c606bc510ec7@domain.hid>	
	<476792F5.6030108@domain.hid>	
	<7289437c0712180212l6d47beb5r5766386d333456c1@domain.hid>	
	<4767C175.7060907@domain.hid>
	<7289437c0712180611i45662e10k1f02c66e584ec99b@domain.hid>
In-Reply-To: <7289437c0712180611i45662e10k1f02c66e584ec99b@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM mmap and DMA
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Perrine Martignoni wrote:
> So, if I understand, I have to use the Dma Api of Linux (linux/dma-mapping.h)
> to allocate a dma buffer and then call rtdm_mmap_to_user to map it in user
> space.
> Isn't it disadvantageous to do it in regular Linux ?

Of course, memory allocation and releasing must never happen over RT
context, but rather during (non-RT) open/close etc.

Mapping/unmapping is a trivial and safe operation on many archs, but not
on all (beware of some IOMMU being involved, then mapping becomes
indeterministic). If unsure, check for your target if it is running
through complex and potentially memory-allocating code paths, e.g. via
lxr.linux.no. If there are problems (not expected on today's mid- to
low-end HW), you have to manage also the mappings during init and keep
them during runtime. Standard pattern for RT development.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

