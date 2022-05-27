From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [Cobalt Xenoami3.1 PATCH 0/2] notify Xenomai udpated clockfreq.
Date: Fri, 27 May 2022 02:22:01 -0400
Message-Id: <20220527062203.9498-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

When there is refined tsc clock, notify Xenomai to apply it.
Linux may schedule a delayed work to refine tsc clock and update
tsc_khz which happen after Xenomai finsih init but tsc_scale and
tsc_shift still keep the value depending on origianl tsc clock
which is outdated. The difference between two clocks may cause
timing issue.

For example:
  [ 0.001731] tsc: Detected 2899.886 MHz TSC
  [ 5.588387] tsc: Refined TSC clocksource calibration: 2903.999 MHz
  cat /sys/module/xenomai/parameters/clockfreq
  2899886000
  After patching, we like to use 2903.999 MHz.

The patchset includes IPIPE patch and cobalt-patch.

Hongzhan Chen (1):
  process: update clockfreq when receive corresponding event.
  x86/tsc: I-PIPE : notify I-PIPE about updated clockfreq.

cobalt side:
 include/cobalt/kernel/init.h                        |  2 ++
 kernel/cobalt/include/asm-generic/xenomai/machine.h |  1 +
 kernel/cobalt/init.c                                | 11 ++++++++++-
 kernel/cobalt/posix/process.c                       |  9 ++++++++-
 4 files changed, 21 insertions(+), 2 deletions(-)

ipipe-side:
 arch/x86/kernel/tsc.c | 5 +++++
 1 file changed, 5 insertions(+)


-- 
2.17.1


