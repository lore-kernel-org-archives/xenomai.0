From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.0.12 released
Message-ID: <cff0e3f5-c36a-b29c-9670-9dea2e9d55b6@siemens.com>
Date: Fri, 12 Nov 2021 16:23:14 +0100
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

Changes since 3.0.11:

Florian Bezdeka (1):
      lib/boilerplate/iniparser: Allow building with GCC 10.2 2020101

Jan Kiszka (12):
      ci: Add basic support for stable 3.0.x
      testsuite/smokey: rtdm: Give delayed close more time for running in QEMU
      doc: Fix copy&paste mistake in corectl man page
      cobalt/arch/arm: fptest: Add missing SIMD register clobbering
      cobalt/posix/thread: Properly discard xnthread on registration error
      drivers/testing/switchtest: Properly clean up xnthread on error
      lib/alchemy: Fix rt_pipe_read* with timeouts
      lib/alchemy/testsuite: Fix pipe-1 test case
      lib/alchemy/testsuite: Extend pipe-1 test by timeout checks
      lib/alchemy: Fix/clarify documentation of *_timed functions regarding abs_timeout
      testsuite/latency: Use corresponding pclose for popen
      config: Bump version number

Philippe Gerum (1):
      cobalt/vfile: seq_file seek index must progress

Wolfgang Grandegger (1):
      cobalt/rtdm: fix memory leak in rtdm_irq_free()

Download available under
https://gitlab.denx.de/Xenomai/xenomai/-/archive/v3.0.12/xenomai-v3.0.12.tar.bz2

Thanks to all contributors!

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

