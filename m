From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH stable/3.1.x 0/2] Backport FPU testing cleanup to 3.1.x 
Date: Wed, 15 Jun 2022 11:51:17 +0200
Message-Id: <20220615095119.2442600-1-florian.bezdeka@siemens.com>
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

Hi all,

this is the backport of the previously published FPU testing cleanup
series to the stable/3.1.x branch.

Patch 1 has been updated to match the supported architectures in the
3.1.x stable branch, Patch 2 is unmodified.

Best regards,
Florian

Florian Bezdeka (2):
  x86: cobalt/switchtest: Fix testing issue due to uninitialized FPU
  x86: cobalt/switchtest: Enable FPU tests unconditionally

 .../arch/arm/include/asm/xenomai/fptest.h     |  4 ++++
 .../arch/arm64/include/asm/xenomai/fptest.h   |  4 ++++
 .../arch/powerpc/include/asm/xenomai/fptest.h |  4 ++++
 .../arch/x86/include/asm/xenomai/fptest.h     | 20 ++++++-------------
 kernel/drivers/testing/switchtest.c           |  4 +++-
 5 files changed, 21 insertions(+), 15 deletions(-)

-- 
2.30.2


