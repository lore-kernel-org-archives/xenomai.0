From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH Dovetail v2 0/5] Get rid of the APC interface
Date: Sun, 17 Jan 2021 16:07:58 +0100
Message-Id: <20210117150803.477767-1-rpm@xenomai.org>
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

This is v2, fixing the header install rule in the wake of the API
removal.

Philippe Gerum (5):
  cobalt/pipe: drop dependency on APCs
  cobalt/registry: drop dependency on APCs
  cobalt/select: drop dependency on APCs
  cobalt/machine: drop obsolete APC bits
  cobalt/apc: drop obsolete APC mechanism

 include/cobalt/kernel/Makefile.am             |   1 -
 include/cobalt/kernel/apc.h                   |  32 ---
 .../cobalt/kernel/ipipe/pipeline/machine.h    |   9 -
 include/cobalt/kernel/rtdm/driver.h           |   1 -
 kernel/cobalt/ipipe/Makefile                  |   2 +-
 kernel/cobalt/ipipe/apc.c                     | 202 ------------------
 kernel/cobalt/ipipe/init.c                    |  19 --
 kernel/cobalt/pipe.c                          |  26 ++-
 kernel/cobalt/procfs.c                        |  42 ----
 kernel/cobalt/registry.c                      |  30 +--
 kernel/cobalt/rtdm/core.c                     |   1 -
 kernel/cobalt/select.c                        |  23 +-
 12 files changed, 49 insertions(+), 339 deletions(-)
 delete mode 100644 include/cobalt/kernel/apc.h
 delete mode 100644 kernel/cobalt/ipipe/apc.c

-- 
2.26.2


