Message-ID: <51128272.9010109@siemens.com>
Date: Wed, 06 Feb 2013 17:18:58 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <5111750E.6090700@siemens.com>
In-Reply-To: <5111750E.6090700@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [FOR TESTING] I-pipe for 3.8-rc6-x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-02-05 22:09, Jan Kiszka wrote:
> Hi,
> 
> to move forward with our kernel support, I've started porting I-pipe to
> upcoming 3.8. The result survived a very basic test in a VM, more
> torturing is definitely required. In case someone already wants to have
> a look or start porting other archs:
> 
>   git://git.xenomai.org/ipipe-jki next-x86
>   (Note: "next" branches may be rebased without warning)
> 
> Xenomai generates minor troubles while building. PCI drivers seem to
> require some massaging, and we get an ugly warning of Kconfig on every
> build:

Brief update:
 - Xenomai patches for those two issues are now in my for-upstream
   queue (git.xenomai.org/xenomai-jki).
 - Xenomai's FPU switching collides with the new eager FPU management
   of the kernel.
   This affects only recent Intel CPUs with xsave support and a can be
   avoided by disabling this method for now ("eagerfpu=off" kernel
   parameter). I'm looking into fixing this properly.

Besides this, at least x86-64 works well. I still need to check 32-bit,
though.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

