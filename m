Sender: Thomas De Schampheleire <patrickdepinguin@domain.hid>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <patchbomb.1318861189@domain.hid>
Date: Wed, 19 Oct 2011 09:35:06 +0200
From: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Subject: [Xenomai-help] [PATCH 0 of 4] xenomai-forge PSOS: miscellaneous
	fixes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This patch series includes some misc. fixes to xenomai-forge:

* definition of ERR_OBJTFULL (should also be added to Xenomai proper)
* port long_names feature to xenomai-forge and fix it
* add tm_getm() function (not present in pSOS but present in Xenomai proper)
* fix compiler warning in task.c

Signed-off-by: Thomas De Schampheleire <thomas.de.schampheleire@domain.hid>
Signed-off-by: Ronny Meeus <ronny.meeus@domain.hid>

---
 include/psos/Makefile.am  |   2 +-
 include/psos/Makefile.in  |   2 +-
 include/psos/long_names.h |  14 ++++++++++++++
 include/psos/psos.h       |   5 +++++
 lib/psos/init.c           |  15 +++++++++++++++
 lib/psos/pt.c             |   6 ++++++
 lib/psos/queue.c          |   6 ++++++
 lib/psos/rn.c             |   5 +++++
 lib/psos/sem.c            |   6 ++++++
 lib/psos/task.c           |   9 +++++++--
 lib/psos/tm.c             |   7 +++++++
 11 files changed, 73 insertions(+), 4 deletions(-)



