From: Wolfgang Denk <wd@denx.de>
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <A46EF8CF1BBB8E4B8A27B73E177C4664EA5CA7@MAIL-SINTERS-01.sinters-int.fr>
References: <A46EF8CF1BBB8E4B8A27B73E177C4664EA5CA7@MAIL-SINTERS-01.sinters-int.fr>
Date: Thu, 21 Mar 2013 17:53:02 +0100
Message-Id: <20130321165302.E33BD200547@gemini.denx.de>
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

Dear Younes,

In message <A46EF8CF1BBB8E4B8A27B73E177C4664EA5CA7@MAIL-SINTERS-01.sinters-int.fr> you wrote:
> 
> I have seen on the website, that Xenomai supports the i.MX27 and i.MX6 by Freescale.
> 
> I need this complementary informations :

This is a long list of questions, and most of them are difficult to
answer without at least minimal background information about the
requirements of your project.  I'll try anyway...

> - What is the size of Xenomai in RAM / ROM and footprint on the platforms i.MX27 and i.MX6 ?

This largely depends on how you use Xenomai.

The impact of the kernel patch is usually so small that you can
neglect it.  As for the user space libraries, these total in a some
200...300 KiB in the root file system, but usually you will use a
single skin only, so you will need much less.

> - Which are the build systems to generate the kernel on the platforms ?

Whatever you use to build your normal Linux kernel images.

If you just start with such development (as it appears from your
questions), you should have a look at the build environment provided
by the Linux Foundation's Yocto Project [1], and embedded distros that
build on top of this, as for example the ELDK [2].

[1] http://www.yoctoproject.org/
[2] http://www.denx.de/wiki/ELDK-5/

> - What about the developement tools ?

Like with standard Linux, you will normally use the standard GNU based
tool chain, eventually in combination with some IDE of your choice.

> - Concerning the development environment : Is it command line ? workbench? and the frameworks for creating applications?

You chose.  Everything that works with plain GNU/Linux systems will
work in the very same way with Xenomai.

> - What are the programming langages ?

Same as with standard Linux.  As for real-time applications, these are
usually written in C and/or C++.

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

This question is not precise enough.

First, you do not explain wether you are talking about standard Linux
drivers, or about real-time capable drivers.

Which drivers are supported on a specific board is mostly a question
of the quality and completeness of the board support package for your
hardware, so the first thing we need to know is which actual hardware
you have in mind, and where you got the BSP from, etc.

In general device support is pretty good in recent versions of
mainline Linux, and for the typical embedded devices (for example,
CAN) there are also real-time capable RTDM drivers.

> - Is it compatible with multi-core ?

Yes, SMP is suported on the i.MX6.

> - Is it possible to interface Matlab Simulink models ?

I have no idea.

> - Is there BSPs ?

Yes, depending on where you get your hardware from. If you have a
choice, then go for a vendor that hashis hardware supported in the
recent (v3.9) mainline kernel.


Note 1:  We are in the final steps of adding Xenomai support to the
         ELDK mentioned in [2] above.  We're in the final testing
	 stages now, but due to Easter vacation I guess the release
	 will not happen before April.  But if you are interested
	 please feel free to contact me for early access.

<shameless plug>
Note 2:  In addition to the free community support you can get here on
	 the mailing list you can also get commercial support for all
	 the topics you asked about above, of course including
	 Xenomai, and/or porting Linux/Xenomai/drivers to your
	 hardware.  Again, please feel free to contact me if you need
	 help.
<shameless plug>

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The biggest difference between time and space is that you can't reuse
time.                                                 - Merrick Furst

