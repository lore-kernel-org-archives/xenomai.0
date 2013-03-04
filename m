Message-ID: <51351D5F.4070201@xenomai.org>
Date: Mon, 04 Mar 2013 23:17:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] I-pipe pull requests
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

Please pull the for-3.4 and for core-3.5.7 in the ipipe-gch.git, there
is only one commit.

Regards.

The following changes since commit 946ca3977e75316751caecc7182f4e64af6499d5:

  ipipe-core-3.5.7-blackfin-3 (2013-01-22 11:41:34 +0100)

are available in the git repository at:
  git://git.xenomai.org/ipipe-gch.git for-core-3.5.7

Gilles Chanteperdrix (1):
      arm/ipipe: fix off-by-one error in IPI virqs allocation

 arch/arm/kernel/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


The following changes since commit 7b032e6d3c458a49e6419d098c54d90f2def9290:

  ipipe-core-3.4.6-powerpc-4 (2013-01-22 11:43:59 +0100)

are available in the git repository at:
  git://git.xenomai.org/ipipe-gch.git for-core-3.4

Gilles Chanteperdrix (1):
      arm/ipipe: fix off-by-one error in IPI virqs allocation

 arch/arm/kernel/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


-- 
                                                                Gilles.

