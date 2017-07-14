From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9cf742c9-4fa9-a236-a941-3b2565ce1e28@siemens.com>
Date: Fri, 14 Jul 2017 21:10:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] next: Fixes for pthread_mutex_trylock
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

The following changes since commit 5bd2093981417bf21d958c4a639837ed0963838a:

  lib/cobalt: init: hint about failure due to disabled core (2017-06-03 18:10:25 +0200)

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git 51a01ff89b8d0b2160675ec03db7f92562ff0af8

for you to fetch changes up to 51a01ff89b8d0b2160675ec03db7f92562ff0af8:

  cobalt: Fix slow-path of mutex_trylock in kernel (2017-07-14 20:58:38 +0200)

At least patch 3 should go to stable as well. I tried to look for
potential issues in stable, ie. without prio-ceiling, /wrt patch 5 as
well but I didn't find anything obvious.

Patch 1 is off-topic, but I ran into again while using syscall(invalid)
to trigger a mode switch.

Jan

----------------------------------------------------------------
Jan Kiszka (5):
      cobalt/kernel: Handle bogus fastcall syscalls gracefully
      smokey: Add test cases for trylock on ceiling mutexes
      cobalt: Fix mutex_trylock slow-path in userspace
      cobalt: Align structure of mutex_trylock with mutex_timedlock
      cobalt: Fix slow-path of mutex_trylock in kernel

 kernel/cobalt/posix/mutex.c                | 16 +--------
 kernel/cobalt/posix/syscall.c              |  8 +++--
 lib/cobalt/mutex.c                         | 11 +++----
 testsuite/smokey/posix-mutex/posix-mutex.c | 52 ++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 24 deletions(-)

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

