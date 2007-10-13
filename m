MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18192.64969.6767.492824@domain.hid>
Date: Sat, 13 Oct 2007 19:18:01 +0200
In-Reply-To: <4710F5A5.4060400@domain.hid>
References: <4710F5A5.4060400@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
 > Hi all,
 > 
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

Yes, I guess this is required.

-- 


					    Gilles Chanteperdrix.

