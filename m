Message-ID: <4D73D4F8.7090409@domain.hid>
Date: Sun, 06 Mar 2011 19:39:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Pull request for 2.6.35-noarch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Adeos <adeos-main@gna.org>

The following changes since commit d4fed6e691867958881ef2f95c668680925d761e:
  Philippe Gerum (1):
        ipipe: disable __ipipe_check_root_resched() for non-preemptible kernels

are available in the git repository at:

  git://git.xenomai.org/ipipe-gch.git for-ipipe-2.6.35-noarch

Gilles Chanteperdrix (1):
      ipipe: inline irq_to_desc for non-sparse irqs

 include/linux/irqnr.h |    4 ++++
 kernel/irq/handle.c   |    3 ++-
 2 files changed, 6 insertions(+), 1 deletions(-)

-- 
                                                                Gilles.

