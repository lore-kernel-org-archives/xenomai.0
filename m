Message-ID: <51840209.8010708@xenomai.org>
Date: Fri, 03 May 2013 20:29:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAG5EsAE0rcOW3DP=bwYpuOYEJoqXFTKDt+SzOzhqDpT8jXFjwA@mail.gmail.com>
In-Reply-To: <CAG5EsAE0rcOW3DP=bwYpuOYEJoqXFTKDt+SzOzhqDpT8jXFjwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problems with xnintr_enable xnintr_disable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ross Williamson <rwilliamson@astro.caltech.edu>
Cc: xenomai <xenomai@xenomai.org>

On 05/03/2013 08:20 PM, Ross Williamson wrote:

> I'm in the unfortunate position of having a closed-source kernel
> module that I need to recompile a kernel for - I have matched the
> kernel version/xenomai version however when I insert the module I get
> the folllowing error:
> 
> Unknown symbol xnintr_enable
> Unknown symbol xnintr_disable
> 
> both these symbols are in the System.map for the kernel so I'm
> confused as to why the kernel module is reporting this.
> 
> Module.symvers:0x00000000 xnintr_enable vmlinux EXPORT_SYMBOL_GPL
> System.map:80068270 T xnintr_enable
> 
> I suspect I'm doing something dumb....


xnintr_enable and xnintr_disable, like all services exported by Xenomai
in kernel-space, are only available to modules using the GPL license.

-- 
                                                                Gilles.

