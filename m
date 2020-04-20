Date: Tue, 21 Apr 2020 01:18:50 +0300
From: Vitaly Chikunov <vt@altlinux.org>
Subject: FAILURE run_gdb:287: checking expression "primary_mode", expected
 "$", found "N"
Message-ID: <20200420221850.xjzzrpdfoherz6hm@altlinux.org>
References: <20200131152713.1811748-1-rpm@xenomai.org>
 <0c811fd4-dc46-0bce-99b3-64c150725d3d@siemens.com>
 <230535ea0245408dbd941bc26c4f6df9@intel.com>
 <bbab7ccf-0f5e-617a-2d94-afc79f2d7efa@siemens.com>
 <CALLqZ8Qk-BEuYjYtRpqkTVT5N9iWJHpU=3n109jCMCy4Yd_8TA@mail.gmail.com>
 <20200201112301.5d3146d9@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200201112301.5d3146d9@md1za8fc.ad001.siemens.net>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hello,

I try ipipe-core-4.19.114-cip24-x86-12 + xenomai-3.1 patches.
But how to interpret this test result?

  4.19.114-xenomai-alt1.cip24.12:~# xeno-test -k
  Started child 6707: /bin/bash /usr/lib/xenomai/xeno-test-run-wrapper /usr/bin/xeno-test -k
  ++ echo 0
  ++ testdir=/usr/lib/xenomai
  ++ /usr/lib/xenomai/smokey --run --keep-going random_alloc_rounds=64 pattern_check_rounds=64
  arith OK
  bufp OK
  cpu_affinity skipped (no kernel support)
  fpu_stress OK
  FAILURE run_gdb:287: checking expression "primary_mode", expected "$", found "N"
  child 6707 returned: exited with status 1
  4.19.114-xenomai-alt1.cip24.12:~#

System info:

  4.19.114-xenomai-alt1.cip24.12:~# xeno-config --info
  Xenomai version: Xenomai/cobalt v3.0.9 -- #5b99a6128 (2019-11-04 19:44:03 +0100)
  Linux REX 4.19.114-xenomai-alt1.cip24.12 #1 SMP Sun Apr 19 09:59:30 UTC 2020 x86_64 GNU/Linux
  Kernel parameters: BOOT_IMAGE=/boot/vmlinuz-4.19.114-xenomai-alt1.cip24.12 root=UUID=56b25751-2d48-4138-99ac-7e48a8ecbf63 ro nokaslr panic=0 console=ttyS1,115200 kgdboc=ttyS1,115200
  I-pipe release #12 detected
  Cobalt core 3.1 detected
  Compiler: gcc version 9.2.1 20200123 (ALT Sisyphus 9.2.1-alt3) (GCC)
  Build args: --build=x86_64-alt-linux --host=x86_64-alt-linux --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64 --libexecdir=/usr/lib --localstatedir=/var/lib --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info --disable-dependency-tracking --disable-silent-rules --without-included-gettext --with-core=cobalt --includedir=/usr/include/xenomai --with-testdir=/usr/lib/xenomai build_alias=x86_64-alt-linux host_alias=x86_64-alt-linux CFLAGS=-fno-omit-frame-pointer

gdb version is 8.3.

A bit of background: I try to build Xenomai packages for ALT linux, so that
people can experiment with open-source real-time system. This is intended for
amd64 platform. I wish that there is not errors or crashes in basic
functionality.

Thanks,


