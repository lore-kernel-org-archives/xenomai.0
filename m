MIME-Version: 1.0
From: Ross Williamson <rwilliamson@astro.caltech.edu>
Date: Fri, 3 May 2013 11:20:20 -0700
Message-ID: <CAG5EsAE0rcOW3DP=bwYpuOYEJoqXFTKDt+SzOzhqDpT8jXFjwA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Problems with xnintr_enable xnintr_disable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

I'm in the unfortunate position of having a closed-source kernel
module that I need to recompile a kernel for - I have matched the
kernel version/xenomai version however when I insert the module I get
the folllowing error:

Unknown symbol xnintr_enable
Unknown symbol xnintr_disable

both these symbols are in the System.map for the kernel so I'm
confused as to why the kernel module is reporting this.

Module.symvers:0x00000000 xnintr_enable vmlinux EXPORT_SYMBOL_GPL
System.map:80068270 T xnintr_enable

I suspect I'm doing something dumb....

--
Ross Williamson
Research Scientist - Sub-mm Group
California Institute of Technology
626-395-2647 (office)
312-504-3051 (Cell)

