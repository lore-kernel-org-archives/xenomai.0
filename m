Message-ID: <532DC328.8010703@xenomai.org>
Date: Sat, 22 Mar 2014 18:06:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] pull request for ipipe 3.10(.32)
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

The following changes since commit 1cc9c3c8da3521c00ade2fa5e0cc10b27f95f7c6:

  arm/ipipe: fix transition to cpu-idle mode (2014-03-19 15:03:03 +0100)

are available in the git repository at:

  git://git.xenomai.org/ipipe-gch.git for-ipipe-3.10

for you to fetch changes up to 24d6a057271dcb3b4a3035b7517f49a5f35dac07:

  ipipe: remove left-over from previous implementation of ipipe_smp_p (2014-03-22 18:04:57 +0100)

----------------------------------------------------------------
Gilles Chanteperdrix (2):
      arm/ipipe: disable SMP code with hw irqs off
      ipipe: remove left-over from previous implementation of ipipe_smp_p

 arch/arm/kernel/ipipe.c |    5 +++++
 include/linux/ipipe.h   |    1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
                                                                Gilles.

