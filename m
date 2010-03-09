Message-ID: <4B968DB5.5020302@domain.hid>
Date: Tue, 09 Mar 2010 19:04:37 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [pull request] Improve ftrace interaction
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

The following changes since commit 7c90959b7e4eb5ef8a775ec17005c23f30daade1:
  Philippe Gerum (1):
        ipipe: introduce 3-level IRQ pending map

are available in the git repository at:

  git://git.kiszka.org/ipipe-2.6 queues/2.6.32-noarch

These patches address various possible configuration errors around
ftrace that can cause hard crashes over I-pipe kernels. Moreover, one
patch enables the safe use of ftrace's PID filtering that comes for free
for the I-pipe tracer now.

The patches also apply on 2.6.33-noarch but were only tested on
2.6.32-x86.


Jan Kiszka (5):
      Use ipipe_safe_current in ftrace_pid_func
      Prevent unsafe ftrace usage over I-pipe
      Disable branch tracing/profiling under I-pipe
      Do no kill ftrace on failing function test
      Fix ipipe_safe_current definition for !CONFIG_IPIPE

 include/linux/ftrace.h        |    1 +
 include/linux/ipipe.h         |    2 +-
 kernel/ipipe/tracer.c         |    3 ++-
 kernel/trace/Kconfig          |    2 ++
 kernel/trace/ftrace.c         |    7 ++++++-
 kernel/trace/trace_selftest.c |    2 ++
 6 files changed, 14 insertions(+), 3 deletions(-)

