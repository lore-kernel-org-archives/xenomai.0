Message-ID: <4ABB73FC.5040705@domain.hid>
Date: Thu, 24 Sep 2009 15:28:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Pull request (2.4 branch)
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

The following changes since commit 8e46e88f80eb8ff52f4af020e3b44b437df234e2:
  Philippe Gerum (1):
        scripts: allow concurrent invocations of wrap-link.sh

are available in the git repository at:

  git://git.xenomai.org/xenomai-gch.git for-2.4

Gilles Chanteperdrix (1):
      Do not use the 2 stages build for building non-posix applications

Stephen Sinclair (1):
      Copy the udev rules into rules.d if it exists.

 Makefile.am          |    7 ++++++-
 Makefile.in          |    7 ++++++-
 scripts/wrap-link.sh |   50
+++++++++++++++++++++++++++-----------------------
 3 files changed, 39 insertions(+), 25 deletions(-)

-- 
                                          Gilles


