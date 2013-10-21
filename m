Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <patchbomb.1382364570@devws164.be.alcatel-lucent.com>
Date: Mon, 21 Oct 2013 16:09:30 +0200
From: Kim De Mey <kim.demey@gmail.com>
Subject: [Xenomai] [PATCH 0 of 3 v2] Xenomai-forge thread_obj: unset
 __THREAD_S_SAFE when not needed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Adjusted patches after feedback & suggestions:

PATCH 1: Setting the __THREAD_S_SAFE for thobj->status is done later 
only when necessary.

PATCH 2: Add warning when pipe() system call fails + assert on return 
value of notifier_init().

PATCH 3: Extends task-9 with 3 more test loops (of which two make the
error that PATCH 1 solves occur). 


 lib/copperplate/notifier.c  |   5 ++++-
 lib/copperplate/threadobj.c |   6 ++++--
 lib/psos/testsuite/task-9.c |  38 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 44 insertions(+), 5 deletions(-)

