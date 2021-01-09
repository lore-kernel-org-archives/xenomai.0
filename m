From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH Dovetail 0/4] Get rid of the APC interface
Date: Sat,  9 Jan 2021 17:02:29 +0100
Message-Id: <20210109160233.921972-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

This patch starts a series aiming at dropping the (functionally
redundant) APC interface entirely.

APCs are a relic from the Dark Ages, with no upside compared to open
coded requests triggering virtual/synthetic IRQs to be handled by the
root domain. As a matter of fact, an APC does run as a client handler
of a synthetic IRQ under the hood. In other words, the APC
encapsulation adds nothing but useless overhead.

Philippe Gerum (4):
  cobalt/pipe: drop dependency on APCs
  cobalt/registry: drop dependency on APCs
  cobalt/select: drop dependency on APCs
  cobalt/apc: drop obsolete APC mechanism

 include/cobalt/kernel/apc.h                   |  32 ---
 .../cobalt/kernel/ipipe/pipeline/machine.h    |   2 -
 include/cobalt/kernel/rtdm/driver.h           |   1 -
 kernel/cobalt/ipipe/Makefile                  |   2 +-
 kernel/cobalt/ipipe/apc.c                     | 202 ------------------
 kernel/cobalt/ipipe/init.c                    |  19 --
 kernel/cobalt/pipe.c                          |  26 ++-
 kernel/cobalt/procfs.c                        |  42 ----
 kernel/cobalt/registry.c                      |  30 +--
 kernel/cobalt/rtdm/core.c                     |   1 -
 kernel/cobalt/select.c                        |  23 +-
 11 files changed, 49 insertions(+), 331 deletions(-)
 delete mode 100644 include/cobalt/kernel/apc.h
 delete mode 100644 kernel/cobalt/ipipe/apc.c

-- 
2.26.2


