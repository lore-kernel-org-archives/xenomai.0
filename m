Message-ID: <DUB121-W42011D0A38E8540A396B2C81C80@phx.gbl>
From: mobin Motallebizadeh <mobin.seven@live.com>
Date: Sat, 30 May 2015 19:09:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] smp.c error on rc4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I'm getting this error in making kernel( Xenomai 3.0 rc4 - ipipe patch 3.16=
 - kernel 3.16 - target: armv7)
arch/arm/kernel/smp.c: In function =91ipi_timer=92:arch/arm/kernel/smp.c:53=
1:2: error: implicit declaration of function =91=92 [-Werror=3Dimplicit-fun=
ction-declaration]cc1: some warnings being treated as errorsscripts/Makefil=
e.build:257: recipe for target 'arch/arm/kernel/smp.o' failedmake[1]: *** [=
arch/arm/kernel/smp.o] Error 1make[1]: *** Waiting for unfinished jobs....M=
akefile:901: recipe for target 'arch/arm/kernel' failedmake: *** [arch/arm/=
kernel] Error 2
WHY? 		 	   		  =
