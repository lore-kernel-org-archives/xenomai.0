Message-ID: <5176A9B0.6080601@siemens.com>
Date: Tue, 23 Apr 2013 17:33:04 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Rework of mlockall and dlopen handling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

I've coded down what we discussed and pushed it into 'for-upstream'.
This does not yet remove redundant mlockall from included userspace
code or change the docs, but the core mechanisms are ready. Patch list
below summarizes the steps.

Jan


Jan Kiszka (4):
      Invoke mlockall on every skin library initialization
      posix: Control auto-shadowing via environment variable
      Remove mlockall alert handler
      Drop --enable-dlopen, disable optimized TLS support by default

 configure.in               |   70 +++----------------------------------------
 include/asm-generic/bind.h |   10 ------
 src/skins/common/bind.c    |   24 ++++-----------
 src/skins/posix/init.c     |   52 +++++++++++---------------------
 src/skins/psos+/init.c     |   15 +---------
 src/skins/uitron/init.c    |   15 +---------
 6 files changed, 31 insertions(+), 155 deletions(-)

