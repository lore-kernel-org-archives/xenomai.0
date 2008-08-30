From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Sat, 30 Aug 2008 23:41:30 +0200
References: <1743f3b40808290145s26f4fa4dp82abee4b8a66fcbf@domain.hid>
In-Reply-To: <1743f3b40808290145s26f4fa4dp82abee4b8a66fcbf@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808302341.30890.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] RTDM driver examples compile problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

> I'm trying to port Xenomai to the new PowerPC-based MPC5121e micro from
> Freescale. I'm using the toolchain included in the LTIB (Linux Target Image
> Builder) envirnoment from Freescale.
> I've got problems when compiling the RTDM xenomai examples. It seems that a
> "-m64" option is used, which is not supported, but I cannot see how to
> disable it. I'm not an expert (really a newbie!) so excuse me, maybe this
> is not an issue at all. The output is:
>
> make -C ../linux-2.6.24
> SUBDIRS=/home/antonio/tools/ltib-mpc5121ads-20080528/rpm/BUILD/rtdm-test-1.
>0 modules

It seems the options "-m64, -mno-red-zone, etc." are x86-64 specific (then not 
adapted for your powerpc card).

Why not filling the ARCH and CROSS_COMPILE variables ? like this:

make -C ../linux-xxwx SUBDIRS=xxx ARCH=powerpc CROSS_COMPILE=powerpc-linux- 
modules.

ARCH is you CPU family
CROSS_COMPILE has to be set with your compiler prefix (for example, with a 
compiler named powerpc-linux-gcc, CROSS_COMPILE must be powerpc-linux-).

You can find many howtos on it on internet: for example:
http://www.denx.de/wiki/view/DULG/LinuxConfiguration#Section_6.2.

Alexis.


