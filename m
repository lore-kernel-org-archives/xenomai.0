Message-ID: <4FD9A8BF.6040404@xenomai.org>
Date: Thu, 14 Jun 2012 11:02:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHyVJywDajR-Mwn27kB5mcX8SGeZqwCUWPUVE_v-oCkNg5U8wA@mail.gmail.com>
In-Reply-To: <CAHyVJywDajR-Mwn27kB5mcX8SGeZqwCUWPUVE_v-oCkNg5U8wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Help??
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mohit Jandwani <mohitjandwani@gmail.com>
Cc: xenomai@xenomai.org

On 06/14/2012 10:07 AM, Mohit Jandwani wrote:
> OK I am sorry for bothering you so much first of all but I am helpless.
> I found that exynos 4 is actually quad processors.so exynos4_defconfig is
> for that.But there is still a mach-exynos directory with a file called
> clock-exynos4210.c, have no idea what it does.

This is linux support for exynos. You have to modify files in this
directory to add support for I-pipe.

> And as I gather on the guide that I have to add some functions in the
> time.c and irq.c files of mach-board of "Linux Kernel Source Code" right?

I quote the guide "To start porting the I-pipe patch to a new board,
look in these directories to see where the hardware timer and its
interrupt are handled (usually arch/arm/mach-X/time.c) and where
cascaded interrupt, if any, are decoded (usually arch/arm/mach-X/irq.c).
In the rest of this document we will call these files time.c and irq.c,
even though they may have another name for your board. "

> I am really confused about the OMAP, how do I get hold of the functions
> defined for OMAP?

The omap support is modified to support the I-pipe. You can look at how
it is done and imitate for exynos. To find the files modified by the
I-pipe kernel, you can:
- run lsdiff on the I-pipe patch
- grep CONFIG_IPIPE in the I-pipe patched kernel

-- 
					    Gilles.

