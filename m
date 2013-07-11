MIME-Version: 1.0
From: benehub@aol.com
Message-Id: <8D04C20495DBA75-794-B61A4@webmailstg-m05.sysops.aol.com>
Date: Thu, 11 Jul 2013 03:35:01 -0400 (EDT)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] no kernel-patch on the boot menu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Hello=20

I installed xenomai2.6.2.1  linux-2.6.32 adeos-ipipe-2.6.32.7.x86-2.6-02.pa=
tch=20
next I followed=20
http://www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/#_buil=
ding_for_x86_32_64bit



$ $xenomai_root/scripts/prepare-kernel.sh --arch=3Dx86 \
  --adeos=3D$xenomai_root/ksrc/arch/x86/patches/adeos-ipipe-2.6.29.4-x86-X.=
Y-ZZ.patch \
  --linux=3D$linux_tree
$ cd $linux_tree
$ make [ARCH=3Di386] menuconfig



I configured my kernel then I did a "make", waited a long time and now when=
 I boot , I just see my previous kernel.

There is not kernel patched. Why?

I



I use a DELL INSPIRON 800 with DEBIAN SQUEEZE XFCE



Best regards



hubhub
