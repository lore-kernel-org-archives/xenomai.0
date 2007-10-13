From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Date: Sat, 13 Oct 2007 19:12:53 +0200
References: <4710F5A5.4060400@domain.hid>
In-Reply-To: <4710F5A5.4060400@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200710131912.53574.Sebastian.Smolorz@domain.hid>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Cross compiling for ARM
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi Jan,

Jan Kiszka wrote:
> in order to build Xenomai's userland with a toolchain that is prefixed
> with "armv5l-linux-", I had to patch configure.in like this
>
> Index: configure.in
> ===================================================================
> --- configure.in	(Revision 3050)
> +++ configure.in	(Arbeitskopie)
> @@ -83,7 +83,7 @@ case "$host" in
>          XENO_LINUX_ARCH=bfinnommu
>  	XENO_LINUX_INSTALL_TARGET=install
>          ;;
> - arm-*)
> + arm*-*)
>   	XENO_TARGET_ARCH=arm
>   	XENO_LINUX_ARCH=arm
>  	XENO_LINUX_INSTALL_TARGET=install_image
>
> in order to call "configure --host=armv5l-linux ...". Am I doing
> something crazy or is this really a required patch for Xenomai?

I never had such problems compiling Xenomai for ARM. Our toolchains are 
generally prefixed with "arm-linux-". For the --host option I 
use "--host=arm-unknown-linux-gnu". It works without a flaw.

-- 
Sebastian

