From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <82fab6da-0060-ac2e-027f-bce15bbe1c84@siemens.com>
Date: Mon, 2 Oct 2017 19:28:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] Tracing improvements and a build fix
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

The following changes since commit f17a60bac447adb35ebae1afeadc046abf80d780:

  cobalt: Fix conditional build by avoiding #if XENO_DEBUG() (2017-07-27 18:26:48 +0200)

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git e5cff1b9da854fb9e061ce8d8e4377984b855943

for you to fetch changes up to e5cff1b9da854fb9e061ce8d8e4377984b855943:

  cobalt/tracing: Primarily identify threads via pid (2017-10-01 11:33:58 +0200)

The xnftrace_printf patch has been proposed before, the others are new
and mostly deal with cleaning up and enhancing our tracepoints for ftrace.

I've also played with a patched trace-cmd/kernelshark that is now able
to detect Xenomai context switches and wakeups as well. It's a patch so
far, future versions of kernelshark are supposed to contain better
plugin interfaces to hook up more cleanly.

http://git.kiszka.org/?p=trace-cmd.git;a=shortlog;h=refs/heads/xenomai

Jan

----------------------------------------------------------------
Jan Kiszka (10):
      cobalt: Introduce xnftrace_printf
      cobalt: Never crash on reading host task pid
      cobalt/wrappers: Fix version level for cobalt_gpiochip_dev
      cobalt/tracing: Do not print numerical policy in trace
      cobalt/tracing: Convert cobalt_print_sched_params into proper function
      cobalt/tracing: Enhance cobalt_switch_context tracepoint
      cobalt/tracing: Trace changes of the current thread priority
      cobalt/tracing: Print syscalls by name
      cobalt/tracing: Don't report current thread in tracepoints
      cobalt/tracing: Primarily identify threads via pid

 include/cobalt/kernel/thread.h                     |  10 +-
 include/cobalt/trace.h                             |   5 +
 include/cobalt/uapi/syscall.h                      |   1 +
 .../cobalt/include/asm-generic/xenomai/wrappers.h  |   2 +-
 kernel/cobalt/posix/process.c                      |   4 +-
 kernel/cobalt/posix/syscall.c                      |  25 ++-
 kernel/cobalt/posix/thread.c                       |  43 ++++
 kernel/cobalt/sched.c                              |   6 +
 kernel/cobalt/synch.c                              |   6 +-
 kernel/cobalt/thread.c                             |  18 +-
 kernel/cobalt/trace/cobalt-core.h                  | 215 +++++++++++---------
 kernel/cobalt/trace/cobalt-posix.h                 | 219 ++++++++++++++-------
 lib/cobalt/trace.c                                 |  29 +++
 13 files changed, 400 insertions(+), 183 deletions(-)

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

