From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 06 Mar 2010 18:08:32 +0100
Message-ID: <1267895312.27899.15.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL-REQUEST] assorted fixes for 2.5.x
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


The following changes since commit af93ec87f975b387243127090b578d57922b38dc:
  Gilles Chanteperdrix (1):
        posix: fix recursive condvar implementation

are available in the git repository at:

  git://xenomai.org/xenomai-rpm.git for-upstream

Andreas Glatz (3):
      native: corrected spelling mistake in macro __xeno_flush_rq()
      nucleus: check IRQ object before attaching or detaching it
      native: removed redundant code in rt_intr_delete()

Philippe Gerum (7):
      asm-generic: fix dist rule to include timeconv.h
      scripts: fix xeno-config to return proper POSIX cflags
      scripts: fix xeno-config for the deprecated --posix-cflags form
      posix: do not uselessly detach IRQ descriptor before deletion
      nucleus/intr: factor out consistency checks
      nucleus/intr: factor out attachment bit setting
      nucleus/intr: fix error code from xnintr_detach()

Stefan Kisdaroczi (1):
      debian: fix package libxenomai1

 debian/changelog                |    9 ++++
 debian/libxenomai1.dirs         |    2 +-
 debian/libxenomai1.lintian      |    2 +-
 debian/rules                    |    6 +-
 include/asm-generic/Makefile.am |    1 +
 include/native/ppd.h            |    2 +-
 ksrc/nucleus/intr.c             |   91 ++++++++++++++++++++++-----------------
 ksrc/skins/native/intr.c        |    5 +-
 ksrc/skins/posix/intr.c         |    5 +-
 scripts/xeno-config.in          |    5 +-
 10 files changed, 74 insertions(+), 54 deletions(-)

-- 
Philippe.



