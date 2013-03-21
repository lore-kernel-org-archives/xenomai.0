From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 21 Mar 2013 12:25:13 -0400
Message-ID: <20130321162513.GL1271@csclub.uwaterloo.ca>
References: <A46EF8CF1BBB8E4B8A27B73E177C4664EA5CA7@MAIL-SINTERS-01.sinters-int.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46EF8CF1BBB8E4B8A27B73E177C4664EA5CA7@MAIL-SINTERS-01.sinters-int.fr>
Subject: Re: [Xenomai] Informations about Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Younes CHALABI <y.chalabi@sinters.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Mar 21, 2013 at 03:52:01PM +0000, Younes CHALABI wrote:
> I have seen on the website, that Xenomai supports the i.MX27 and i.MX6 by Freescale.
> 
> I need this complementary informations :
> 
> - What is the size of Xenomai in RAM / ROM and footprint on the platforms i.MX27 and i.MX6 ?

Xenomai is a linux kernel patch and user space libraries to allow running
some realtime code on linux.  How big your linux system is depends what
you put in it.

> - Which are the build systems to generate the kernel on the platforms ?

It is a linux kernel.  You compile it with gcc usually.

> - What about the developement tools ?

Not relevant to a kernel patch.  Do whatever you normally do for linux
development.

> - Concerning the development environment : Is it command line ? workbench? and the frameworks for creating applications?

Same thing.  Do whatever works for you.  I think vim as a text editor
and running make works great.

> - What are the programming langages ?

It certainly allows you to use C code.  Of course most languages can
talk to C libraries in some way.

> - Are these drivers supported ? 
>    - Screen
>    - Touchscreen
>    - WLAN
>    - USB 2.0 / 3.0 / OTG 
>    - SPI 
>    - I2C 
>    - Ethernet (gigabit)
>    - UART 
>    - PCI Express 
>    - CAN 
>    - I/O Micro
>    - Video : LVD / HDMI / DVI 

What the kernel supports depends on which kernel you use.

> - Is it compatible with multi-core ?

I haven't tried, but I believe xenomai supports SMP on some architectures
at least.

> - Is it possible to interface Matlab Simulink models ?

Never heard of it.

> - Is there BSPs ?

That's more of a board maker issue in terms of what they support for
linux.  As long as their kernel is supported by the xenomai pathes then
you could probably use their BSP if you really want to.  I personally
think BSPs are collections of close to unusable drivers by makers that
don't really understand how linux drivers are supposed to be made and
generally best avoided except possibly as example code for getting real
drivers written.

Perhaps some official xenomai developers have better answers though.

-- 
Len Sorensen

