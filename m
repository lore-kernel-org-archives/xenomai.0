Message-ID: <53204C41.8050309@xenomai.org>
Date: Wed, 12 Mar 2014 13:00:01 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] forge pull request
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

The following changes since commit 7cf3f8c31925ed048fefb27746599958fa678ebd:

  cobalt: bump ABI revision level for all archs (2014-03-12 10:41:59 +0100)

are available in the git repository at:

  git://git.xenomai.org/xenomai-gch.git for-forge

for you to fetch changes up to fc4c3dcfb4a120b6ad4ac5190e8106b317072afd:

  registry: use pkg-config to retrieve fuse flags (2014-03-12 12:56:10 +0100)

----------------------------------------------------------------
Gilles Chanteperdrix (5):
      cobalt/arm: remove #ifdefs for old versions
      cobalt/xnid: use 64 bits ids
      cobalt/xnid: allow iteration
      copperplate: missing uses of early printf services
      registry: use pkg-config to retrieve fuse flags

 configure.ac                    |   21 ++++-----------------
 include/cobalt/kernel/tree.h    |   21 +++++++++++++++++----
 kernel/cobalt/arch/arm/switch.S |   42 +++---------------------------------------
 kernel/cobalt/tree.c            |    4 ++--
 lib/copperplate/init.c          |    4 ++--
 lib/copperplate/registry.c      |    4 ++--
 6 files changed, 30 insertions(+), 66 deletions(-)

-- 
                                                                Gilles.

