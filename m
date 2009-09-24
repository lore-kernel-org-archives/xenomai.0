Message-ID: <4ABB7331.5010602@domain.hid>
Date: Thu, 24 Sep 2009 15:25:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Pull request.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

The following changes since commit 2d29c076e15c1e0bb2aa1fa83b132da230aeab60:
  Philippe Gerum (1):
        scripts: allow concurrent invocations of wrap-link.sh

are available in the git repository at:

  git://git.xenomai.org/xenomai-gch.git for-head

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


