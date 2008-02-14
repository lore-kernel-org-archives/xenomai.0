Message-Id: <47B415340200000100192592@domain.hid>
Date: Thu, 14 Feb 2008 10:17:24 -0500
From: "Hubert Talbot" <Hubert.Talbot@domain.hid>
References: <mailman.5479.1202920211.28415.xenomai@xenomai.org>
In-Reply-To: <mailman.5479.1202920211.28415.xenomai@xenomai.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Xenomai-2.4.2 vs kernel-2.6.24 (i686)
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

I try to build kernel 2.6.24 with adeos-ipipe-2.6.24-x86-2.0-03.patch
and I get this:

  ...
  AR      arch/x86/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/x86/kernel/built-in.o: In function `do_machine_check_vector':
ipipe.c:(.text+0x128de): undefined reference to `do_machine_check'
make[1]: *** [.tmp_vmlinux1] Erreur 1
make[1]: quittant le r=E9pertoire * /usr/src/linux-2.6.24 *
make: *** [debian/stamp-build-kernel] Erreur 2

real	7m59.559s
user	6m36.813s
sys	0m40.419s


Just to report the problem...


Hubert

