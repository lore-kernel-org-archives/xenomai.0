From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sat, 8 Dec 2007 16:51:09 +0100
References: <200712072347.07847.niklaus.giger@domain.hid>
	<475A72DA.5090008@domain.hid>
In-Reply-To: <475A72DA.5090008@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712081651.09378.niklaus.giger@domain.hid>
Subject: Re: [Xenomai-help] Are these results running the xeno-test on a
	Sequoia board okay?
Reply-To: niklaus.giger@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Am Samstag, 8. Dezember 2007 schrieb Philippe Gerum:
> Niklaus Giger wrote:
> > Hi
<...> 
> I built it like this using the DENX-kernel
> > cd /home/hcu/celsius/linux-2.6-xenomai
> > /home/hcu/celsius/xenomai-trunk/scripts/prepare-kernel.sh --linux=/home/hcu/celsius/linux-2.6-xenomai --adeos=/home/hcu/celsius/xenomai-trunk/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.23-powerpc-DENX-2.0-03.patch --arch=powerpc
> 
> You need to use adeos-ipipe-2.6.23-ppc-1.6-00.patch for the sequoia
> since it still depends on the ppc/ tree, on top of DENX-v2.6.23.8.
> Passing --arch=ppc to prepare-kernel.sh instead of --arch=powerpc
> without specifying an Adeos patch would pre-select the right one.

However the kernel built this way (based on the git hash given in the
patches/README) my sequoia board just hangs after
> Bytes transferred = 1633510 (18ece6 hex)
> ## Booting image at 00200000 ...
>    Image Name:   Linux-2.6.23.8-dirty
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1633446 Bytes =  1.6 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK

Best regards
-- 
Niklaus Giger

