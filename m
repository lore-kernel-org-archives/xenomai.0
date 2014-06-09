Message-ID: <5395D9B1.9030305@xenomai.org>
Date: Mon, 09 Jun 2014 17:58:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [GIT PULL] fix null pointer dereference with FCSE
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

The following changes since commit 692101a5be6afadde30db54b0d8baa4699891231:

  Merge remote-tracking branch 'gilles/for-ipipe-3.14.0' into ipipe-3.14 (2014-05-29 14:53:58 +0200)

are available in the git repository at:


  git://git.xenomai.org/ipipe-gch.git for-ipipe-3.14.0

for you to fetch changes up to bbd8f8f171f2af32953e66a02d9f7162291b8970:

  arm/fcse: fix NULL pointer dereference (2014-06-09 17:39:45 +0200)

----------------------------------------------------------------
Gilles Chanteperdrix (1):
      arm/fcse: fix NULL pointer dereference

 arch/arm/include/asm/mmu_context.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
                                                                Gilles.

