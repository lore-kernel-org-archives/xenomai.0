Message-ID: <5420A09E.60105@xenomai.org>
Date: Tue, 23 Sep 2014 00:20:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] I-pipe 3.10 pull request
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

The following changes since commit 8e940c2c151bcf2d065ccbc2adbf0c90b209b7d3:

  arm/ipipe: bump core revision level (2014-09-22 18:21:44 +0200)

are available in the git repository at:

  git://git.xenomai.org/ipipe-gch.git for-ipipe-3.10

for you to fetch changes up to 0caa54772542da89f7e4aca845c1af04522db4b4:

  arm/ipipe: bump core revision level (2014-09-23 00:16:43 +0200)

----------------------------------------------------------------
Gilles Chanteperdrix (3):
      arm/ipipe: fix ipipe_syscall_root with mayday and EABI
      arm/fcse: avoid compilation error without FCSE
      arm/ipipe: bump core revision level

 arch/arm/include/asm/fcse.h  |   12 ++++----
 arch/arm/include/asm/ipipe.h |    8 +++---
 arch/arm/kernel/ipipe.c      |   67 +++++++++++++++++++++++++++++++++------------
 3 files changed, 59 insertions(+), 28 deletions(-)

-- 
                                                                Gilles.

