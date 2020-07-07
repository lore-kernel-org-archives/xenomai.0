Subject: Re: xenomai 3.1/ipipe-core-4.19.128-cip28-arm-10.patch
References: <16c407c9-8ed4-4b43-b38b-aac8a270e686@gmail.com>
 <CALLqZ8RXOhONVAti+XyW6dRSCWYcnLnyG1=fYyXQgU+k7RPWAA@mail.gmail.com>
 <a1b13b3e-3d27-586a-c8bb-fec44a368f58@gmail.com>
 <CALLqZ8REwJXSjZ4m3D3_VGdfgf66ZcG0_oWq0MajEn3jMCXQWw@mail.gmail.com>
From: Robert Berger <xenomai.list@gmail.com>
Message-ID: <2ebbba9d-19be-86fe-59ee-6981f0dc5930@gmail.com>
Date: Wed, 8 Jul 2020 01:57:43 +0300
MIME-Version: 1.0
In-Reply-To: <CALLqZ8REwJXSjZ4m3D3_VGdfgf66ZcG0_oWq0MajEn3jMCXQWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I just had a chat on the Yocto IRC and they claim, that I should not 
rebuild glibc against different kernel headers. That's yet another no no ;)

Which version of glibc do you use?

I have version 2.31.

01:38:11) RP: RobertBerger: one llbc can be run against multiple kernels 
and multiple kernel versions
(01:39:26) rber@freenode: Yep, but I thought it's built against a kernel 
version/some number of syscalls and you can upgrade the kernel 
underneath, but not downgrade
(01:40:26) rber@freenode: If you downgrade the kernel potentially 
syscalls are being called which are not available in the old kernel.
(01:41:27) RP: RobertBerger: that isn't how it works
(01:41:42) rber@freenode: Ah OK ;)
(01:41:50) rber@freenode: So you say it's a runtime thing?
(01:42:46) RP: RobertBerger: the libc adapts to the kernel version its 
running against. That kernel is in the range of "latest linux kernel 
when the libc was released" to OLDEST_KERNEL
(01:43:07) rber@freenode: OK

Regards,

Robert

