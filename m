Message-ID: <4EF9D91D.2050509@domain.hid>
Date: Tue, 27 Dec 2011 15:41:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] pull request for adeos-ipipe-2.6.38.8-arm-1.18-05
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Adeos <adeos-main@gna.org>

The following changes since commit e68e48bebdc551a534ecd6fdbd839eb9ee2637f7:

  forward port, rebase on 2.6.38-noarch,
adeos-ipipe-2.6.38.8-arm-1.18-03 (2011-10-21 21:14:32 +0200)

are available in the git repository at:
  git://git.xenomai.org/ipipe-gch.git for-ipipe-2.6.38-arm

Gilles Chanteperdrix (4):
      fcse: fix compilation error
      adeos-ipipe-2.6.38.8-arm-1.18-04
      ipipe-arm: fix compilation with I-pipe tracer
      adeos-ipipe-2.6.38.8-arm-1.18-05

 arch/arm/include/asm/cacheflush.h |    1 +
 arch/arm/include/asm/ipipe.h      |    4 ++--
 arch/arm/include/asm/irqflags.h   |    4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
                                                                Gilles.

