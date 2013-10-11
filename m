Message-ID: <5257A979.7080208@siemens.com>
Date: Fri, 11 Oct 2013 09:32:09 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] forge: Cleanup COPYING files
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Philippe,

The following changes since commit 926e0441446aae116bf5b0701753e4b87a5386a2:

  doc: update installation guidelines (2013-10-04 15:46:23 +0200)

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-forge

for you to fetch changes up to f1559e40a39b1a54e0348732402a68eb0dfef0a4:

  Rename include and lib copying files (2013-10-10 15:15:56 +0200)

If you do not like COPYING.* renaming, just skip the second patch. The
first on is important as we currently have code that is formally under
no COPYING file.

Jan

----------------------------------------------------------------
Jan Kiszka (2):
      Consolidate and clarify scope of license files
      Rename include and lib copying files

 kernel/cobalt/COPYING => COPYING     |   0
 include/{COPYING => COPYING.INC}     |   0
 kernel/cobalt/posix/COPYING          | 341 ------------------------
 kernel/cobalt/rtdm/COPYING           | 340 -----------------------
 lib/{analogy/COPYING => COPYING.LIB} |   0
 lib/alchemy/COPYING                  | 458 -------------------------------
 lib/cobalt/COPYING                   | 504 -----------------------------------
 lib/copperplate/COPYING              | 458 -------------------------------
 lib/psos/COPYING                     | 504 -----------------------------------
 lib/vxworks/COPYING                  | 458 -------------------------------
 10 files changed, 3063 deletions(-)
 rename kernel/cobalt/COPYING => COPYING (100%)
 rename include/{COPYING => COPYING.INC} (100%)
 delete mode 100644 kernel/cobalt/posix/COPYING
 delete mode 100644 kernel/cobalt/rtdm/COPYING
 rename lib/{analogy/COPYING => COPYING.LIB} (100%)
 delete mode 100644 lib/alchemy/COPYING
 delete mode 100644 lib/cobalt/COPYING
 delete mode 100644 lib/copperplate/COPYING
 delete mode 100644 lib/psos/COPYING
 delete mode 100644 lib/vxworks/COPYING

