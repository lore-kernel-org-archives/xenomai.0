Message-ID: <4AF88CB1.6010700@domain.hid>
Date: Mon, 09 Nov 2009 22:42:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BB99A6BA28709744BF22A68E6D7EB51F03248BDB59@domain.hid>	<4AA95F97.6010802@domain.hid>	<BB99A6BA28709744BF22A68E6D7EB51F03248BDBCD@midas.usurf.usu.edu>	<4AA96689.3010502@domain.hid>
	<BB99A6BA28709744BF22A68E6D7EB51F03248BDC03@domain.hid>
	<BB99A6BA28709744BF22A68E6D7EB51F03310B0104@domain.hid>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F03310B0104@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Installation and Makefile Help
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jonathan Haws <Jonathan.Haws@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jonathan Haws wrote:
> else
> 
> #	We are calling make from the kernel build system, therefore we simply define
> #	what the modules are.
> 	
> 	obj-m := fpgaDriver.o

EXTRA_CFLAGS+=-Iinclude/xenomai

> 
> endif

You can put that in a file named "Kbuild" too, this avoids the big if.

There are Makefile examples in xenomai sources "examples" sub-directory.

-- 
					    Gilles.

