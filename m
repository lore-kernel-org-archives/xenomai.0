Message-ID: <540D4F8C.3020205@siemens.com>
Date: Mon, 08 Sep 2014 08:41:16 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL 2.x] posix: Flush print buffer on fclose
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Xenomai <xenomai@xenomai.org>

Found this in my queue. It's from February this year, I forgot to
propose it for merge. Still need to check the forge situation.

The following changes since commit aed548fa55b2e1bf8b2fce9bc313dc9fcff23407:

  arm: fix compilation issue with --enable-debug (2014-09-07 22:24:16 +0200)

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

for you to fetch changes up to f4cfe2ceddc1cee4034d791cb9866451f385de03:

  posix: Flush print buffer on fclose (2014-09-08 07:26:27 +0200)

----------------------------------------------------------------
Jan Kiszka (1):
      posix: Flush print buffer on fclose

 include/posix/stdio.h          | 2 ++
 src/skins/posix/posix.wrappers | 1 +
 src/skins/posix/printf.c       | 6 ++++++
 src/skins/posix/wrappers.c     | 6 ++++++
 4 files changed, 15 insertions(+)

