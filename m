Message-ID: <475656F0.6010603@domain.hid>
Date: Wed, 05 Dec 2007 08:44:48 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <200712050741.16685.niklaus.giger@domain.hid>
In-Reply-To: <200712050741.16685.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems running xenomai on Yosemite PPC440 board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Hi Niklaus,

Niklaus Giger wrote:
> Hi
> 
> I built a xenomai kernel and the xenomai tools using a checkout of the trunk 
> like this
> cd /home/hcu/celsius/linux-2.6-xenomai
> /home/hcu/celsius/xenomai-trunk/scripts/prepare-kernel.sh --linux=/home/hcu/celsius/linux-2.6-xenomai --adeos=/home/hcu/celsius/xenomai-trunk/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.23-ppc-1.6-00.patch --arch=ppc
> make  ARCH=ppc CROSS_COMPILE=ppc_4xx- 
> O=/home/hcu/celsius/build-linux-yosemite-ppc-DENX-v2.6.23.1 
> yosemite_defconfig
> make  ARCH=ppc CROSS_COMPILE=ppc_4xx-

CROSS_COMPILE=ppc_4xxFP- !?

Wolfgang.


