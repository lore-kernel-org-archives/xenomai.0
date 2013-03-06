Message-ID: <5137734F.2000907@siemens.com>
Date: Wed, 06 Mar 2013 17:48:15 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] x86/ipipe: Tracing related fixes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

The following changes since commit 85d706363aec4d1467d127d51429ddd623655707:

  Merge branch 'core-next' (2013-02-20 15:38:20 +0100)

are available in the git repository at:

  git://git.xenomai.org/ipipe-jki for-upstream/master

The first one is what I already posted for 3.5, the second fix should
unbreak ftrace for any arch, but I only tested on x86.

Jan Kiszka (2):
      x86/ipipe: Do not call TRACE_IRQS_OFF before __ipipe_divert_exception
      ipipe: Harden __ftrace_ops_list_func

 arch/x86/kernel/entry_32.S |    4 ++--
 arch/x86/kernel/entry_64.S |    8 ++++++--
 kernel/trace/ftrace.c      |    5 +++--
 3 files changed, 11 insertions(+), 6 deletions(-)

