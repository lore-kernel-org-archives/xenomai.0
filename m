Message-ID: <54775097.30705@siemens.com>
Date: Thu, 27 Nov 2014 17:25:59 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [pull] forge: Adjust default registry mount point
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

The following changes since commit c13ff82ac09f6daa94778dcd8b51902efd754f3d:

  rtnet: update at91_ether driver (2014-11-16 20:06:04 +0100)

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-forge

for you to fetch changes up to d36ae28f9c0549c0af66e896711dde21ea769587:

  regd: Switch to tmpfs as default (2014-11-27 17:19:33 +0100)

----------------------------------------------------------------
Jan Kiszka (2):
      lib/copperplate: Use single source for default registry path
      regd: Switch to tmpfs as default

 doc/asciidoc/MIGRATION.adoc           | 2 +-
 doc/asciidoc/README.APPLICATIONS.adoc | 6 +++---
 doc/asciidoc/README.INSTALL.adoc      | 4 ++--
 lib/copperplate/init.c                | 4 ++--
 lib/copperplate/internal.h            | 3 +++
 lib/copperplate/regd/regd.c           | 4 +---
 6 files changed, 12 insertions(+), 11 deletions(-)

