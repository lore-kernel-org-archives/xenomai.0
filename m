From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.0.8 released
Message-ID: <17a9dbe5-59c5-04b9-e4fa-5fbc7bacd108@siemens.com>
Date: Mon, 14 Jan 2019 16:12:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

An overdue stable release has just been completed. The git repo is
already filled and also provide source download tarballs:

https://gitlab.denx.de/Xenomai/xenomai/tags/v3.0.8

Just those downloads at the usual places () will follow later.

Changes since 3.0.7:

Christophe BLAESS (1):
      Add the xsc field when rtps reads the sched/acct file.

Giulio Moro (1):
      Rename __clz to xenomai_count_leading_zeros

Henning Schild (5):
      cobalt/x86: add support for eager fpu handling
      cobalt/x86: add ipipe-4.4 eager fpu support
      cobalt: fixup for kernel 4.14+
      cobalt/x86: add ipipe-4.14 eager fpu support
      cobalt/x86: fix condition in eager fpu code for kernels < 4.14

Jan Kiszka (10):
      can: Fix compiler warning about missing braces
      cobalt/posix/signal: Plug leak of pending signal struct on thread deletion
      drivers/analogy: Fix improper memset in Intel 8255
      cobalt/posix/mqueue: Fix crash after failing registration
      cobalt/sched-quota: Account for already consumed time on limit update
      rtnet: Fix lifecycle management of mapped rtskbs
      Remove version name
      Add release generator script
      Remove last version naming fragment
      config: Bump version number

Philippe Gerum (9):
      cobalt/kernel: always use explicit preprocessor conditionals
      cobalt: use generic linux/uaccess.h header
      demo/cyclictest: turn on FIFO mode by default, detecting spurious relaxes
      cobalt/thread: handle case of invalid domain migration over non-rt CPU
      cobalt/intr: IRQ affinity depends on xnsched_realtime_cpus
      cobalt/sched: fix mismatches between supported CPUs and affinity set
      demo/cyclictest: fix time delta calculation
      boilerplate/setup: cobalt: do not advertise non-RT CPUs to applications
      vxworks/mempart: fix error status upon failure to create partition

Sebastian Smolorz (2):
      net: Split internal rtnet.h and install rtdm/net.h and rtdm/uapi/net.h
      drivers/can: Add PCAN-PCI Express OEM ID.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

