Message-ID: <52528C80.2090101@siemens.com>
Date: Mon, 07 Oct 2013 12:27:12 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] ipipe-3.8: Build fix for !CONFIG_IPIPE
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

The following changes since commit 7f4e51c5a3588c691d55950d8962f30f1717d1ab:

  ipipe-core-3.8.13-x86-3.patch (2013-09-26 20:47:46 +0200)

are available in the git repository at:

  git://git.xenomai.org/ipipe-jki for-upstream/3.8

for you to fetch changes up to 74307024d967e97252a49537e92b8eccea5f5c0b:

  x86/ipipe: Fix !CONFIG_IPIPE build breakage of x86-64 (2013-10-07 12:25:09 +0200)

----------------------------------------------------------------
Jan Kiszka (1):
      x86/ipipe: Fix !CONFIG_IPIPE build breakage of x86-64

 arch/x86/kernel/entry_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

