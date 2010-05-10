Message-ID: <4BE7FB63.20007@domain.hid>
Date: Mon, 10 May 2010 14:26:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <SNT119-W55D22350A5B495E79B9B80B0F90@domain.hid>
In-Reply-To: <SNT119-W55D22350A5B495E79B9B80B0F90@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai for arm:error header files
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: federico lolli <federicololli@domain.hid>
Cc: xenomai@xenomai.org

federico lolli wrote:
> Hi,
> I would like to compile Xenomai for arm.
> processor is: at91sam9g20 -> at91sam9.
> the compiler is emdebian, arm-linux-gnueabi-gcc
>  but I get the following errors in the compilation:
> 
> fede@domain.hid$ sudo ./configure
> --build=i686-pc-linux-gnueabi --host=arm-linux-gnueabi
> --enable-arm-mach=at91sam9

You do not need to be root to run configure.

> (...)
> fede@domain.hid$ sudo make

You do not need to be root to run make either.

> (...)
> rt_print.c:1: warning: target CPU does not support interworking

Your toolchain is an EABI toolchain, you should pass --enable-arm-eabi
configure.

> (...)
> /usr/arm-linux-gnueabi/include/bits/errno.h:25:26: error: linux/errno.h:
> No such file or directory

Your toolchain is probably not installed correctly.

-- 
					    Gilles.

