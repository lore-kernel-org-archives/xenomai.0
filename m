Message-ID: <4AD8241C.6090200@domain.hid>
Date: Fri, 16 Oct 2009 09:43:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1f3e02580910132319v3ce08b2frb811d749def9f17@domain.hid>	
	<4AD57CE3.4050206@domain.hid>
	<1f3e02580910152226h4fb94068kfce63fec4be38c3f@domain.hid>
In-Reply-To: <1f3e02580910152226h4fb94068kfce63fec4be38c3f@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Support for ARCH_MV88F6290
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Didenko Sergey <didenkos@domain.hid>
Cc: xenomai@xenomai.org, Jorge Ramirez <jorge.ramirez.ortiz@domain.hid>, mohamad.sharifi@domain.hid

Didenko Sergey wrote:
> CROSS_COMPILE - arm-none-linux-gnueabi

So, your compiler is named arm-none-linux-gnueabi-gcc

> checking build system type... i686-pc-linux-gnu
> checking host system type... arm-unknown-linux-gnu
> checking for a BSD-compatible install... /usr/bin/install -c
> checking for arm-linux-gcc... no
> checking for gcc... gcc
> configure: WARNING: using cross tools not prefixed with host triplet

No need to go further. Here you know that something went wrong.
configure tells you that it will use gcc (the x86 compiler) as compiler
because it could not find a compiler named arm-linux-gcc. This will
definitely not work.

Your compiler is arm-none-linux-gnueabi-gcc, not arm-linux-gcc, so, you
should either configure passing --host=arm-none-linux-gnueabi, or define
the CC variable to be arm-none-linux-gnueabi-gcc.

This is explained in README.INSTALL.

-- 
					    Gilles.

