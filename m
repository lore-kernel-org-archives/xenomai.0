Message-ID: <4EA2F003.6000608@domain.hid>
Date: Sat, 22 Oct 2011 18:32:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Pull request for ipipe-2.6.38-noarch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Adeos <adeos-main@gna.org>

The following changes since commit 641d8e87531c6367a6357335378194ea06a23701:

  ipipe: Prevent unwritable pages after mprotect (2011-07-21 09:51:56 +0200)

are available in the git repository at:
  git://git.xenomai.org/ipipe-gch.git for-ipipe-2.6.38-noarch

Gilles Chanteperdrix (4):
      ipipe: inline irq_to_desc for non-sparse irqs
      ipipe: delay printk when called on root domain with hw irqs off
      ipipe noarch: allow hostrt without clockevents
      ipipe noarch: add const attribute to irq_get_irq_data

 include/linux/ipipe_tickdev.h |   38 +++++++++++++++++++++++---------------
 include/linux/irq.h           |    2 +-
 include/linux/irqnr.h         |    4 ++++
 kernel/irq/irqdesc.c          |    2 ++
 kernel/printk.c               |   11 +++++++----
 5 files changed, 37 insertions(+), 20 deletions(-)

-- 
                                                                Gilles.

