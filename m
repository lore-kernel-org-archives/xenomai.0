content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] build fails with "more than 10 operands in `asm'"
Date: Wed, 1 Feb 2006 20:29:46 +0100
Message-ID: <1CFEB358338412458B21FAA0D78FE86D042A2F73@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: wallace@domain.hid, xenomai@xenomai.org

Gary Wallace wrote:
>  I have tried building both xenomai 2.0.3 and 2.1-rc2 but receive the
>following compilation error for both versions:
>
>xenomai-2.0.3/skins/native/lib/task.c: In function `rt_task_send':
>xenomai-2.0.3/skins/native/lib/task.c:354: more than 10 operands in
`asm'

IIRC, this is a limitation of an old binutils. You may solve this by
either upgrading to a more recent binutils or split the asm block.

BTW, what is the minimum gcc/binutils version recommended by the Xenomai

project? Is it documented somewhere?

>  I'm using a cross compiler (gcc 2.95.3 from
>http://www.kegel.com/crosstool/), the target is ppc and the host
>machine is i386 linux.  The target kernel is version 2.6.14.6 with
>i-pipe version 1.1-02.

If GNU libc is okay for you and you don't depend on uClibc, you may
consider
the excellent ELDK 3.1.1 with GCC 3.3.3, or the shiny new ELDK 4.0 with=20
GCC 4 [1].

[1] http://www.denx.de/en/News/PressReleaseELDK40


Cheers,
--=20
Stephane


