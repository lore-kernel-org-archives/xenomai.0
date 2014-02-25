Message-ID: <530D0D7B.9010501@xenomai.org>
Date: Tue, 25 Feb 2014 22:39:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] request pull for xenomai-forge
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

The following changes since commit 21c98d8c4e2ce4320f688163570dab9b11da55c1:

  doc: provide details about the new registry hierarchy (2014-02-21 17:31:27 +0100)

are available in the git repository at:

  git://git.xenomai.org/xenomai-gch.git for-forge

for you to fetch changes up to 87d6615a4572e945bdaaf6609e47e82235606d6f:

  cobalt/xnlock: allow moving out-of-line (2014-02-24 01:25:02 +0100)

----------------------------------------------------------------
Gilles Chanteperdrix (1):
      cobalt/xnlock: allow moving out-of-line

 include/cobalt/kernel/lock.h   |   45 +++++++++++++++++++++++++++++++++----------
 kernel/cobalt/arch/arm/Kconfig |    4 ++++
 kernel/cobalt/lock.c           |   17 ++++++++++++++--
 3 files changed, 54 insertions(+), 12 deletions(-)

-- 
                                                                Gilles.

