From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 0/2] Backport: FPU testing / switchtest issue to 3.2 stable 
Date: Wed, 25 May 2022 11:56:25 +0200
Message-Id: <20220525095627.40521-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

this is the backport of the previously pulished FPU testing cleanup. As
3.2 stable branch still supports ipipe and ipipe allows us to use the
FPU in kernel space (in user task context) we have to deal with the
problem differently.

The x86 fpu test relied on getting a clean fpu state (created by
fninit), but there was no guarantee that this initialization happened
which was uncovered when stressing server grade hardware with stress-ng
and running the xenomai testsuite in parallel.

3.1 stable is also affected. I'm currently working on an additional
backport to that branch.

Best regards,
Florian

Florian Bezdeka (2):
  x86: ipipe: Fix testing issue due to uninitialized FPU
  x86: ipipe: Enable FPU tests unconditionally

 .../arm/dovetail/include/asm/xenomai/fptest.h |  4 ++++
 .../arm/ipipe/include/asm/xenomai/fptest.h    |  4 ++++
 .../dovetail/include/asm/xenomai/fptest.h     |  4 ++++
 .../arm64/ipipe/include/asm/xenomai/fptest.h  |  4 ++++
 .../ipipe/include/asm/xenomai/fptest.h        |  4 ++++
 .../x86/dovetail/include/asm/xenomai/fptest.h |  4 ++++
 .../x86/ipipe/include/asm/xenomai/fptest.h    | 20 ++++++-------------
 kernel/drivers/testing/switchtest.c           |  4 +++-
 8 files changed, 33 insertions(+), 15 deletions(-)

-- 
2.35.3


