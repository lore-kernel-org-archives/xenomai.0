Message-ID: <47F4AC62.4090909@domain.hid>
Date: Thu, 03 Apr 2008 12:07:30 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
References: <7289437c0804030246v7992ec23kedcc2c8b71dc14f8@domain.hid>
In-Reply-To: <7289437c0804030246v7992ec23kedcc2c8b71dc14f8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Question about rtdm_mmap_to_user()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

http://www.captain.at/xenomai-real-time-driver-example.php :-)

Perrine Martignoni wrote:
> Hello,
> 
> I try to allocate a buffer in kernel space (with kmalloc) and then map 
> it into user-space (with rtdm_mmap_to_user).
> After, I fill in the buffer in user space with the address returned by 
> rtdm_mmap_to_user, and when I read it into the kernel space with the 
> kernel address, I don't have the values put in user-space.
> 
> What I'm doing wrong ?
> Have you a simple example of use of rtdm_mmap_to_user ?
> 
> Thanks in advance.
> Best Regards,
> Perrine
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


