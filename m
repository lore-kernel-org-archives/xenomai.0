From: Zqiang <qiang1.zhang@intel.com>
Subject: [linux-dovetail][PATCH 0/3] Add TSC function supports and MFD driver
 for TGPIO
Date: Tue, 17 May 2022 09:53:15 +0800
Message-Id: <20220517015318.697955-1-qiang1.zhang@intel.com>
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
To: rpm@xenomai.org, jan.kiszka@siemens.com
Cc: hongzhan.chen@intel.com, xenomai@xenomai.org

The following modifications are mainly to add TSC function for TGPIO
and add intel-ehl-gpio driver divides and initializes the PSE TGPIO
resources.

Christopher Hall (1):
  x86/tsc: Add TSC support functions to support ART driven Time-Aware
    GPIO

D, Lakshmi Sowjanya (1):
  ptp: tgpio: PSE TGPIO crosststamp, counttstamp

Raymond Tan (1):
  mfd: intel-ehl-gpio: Introduce MFD framework to PSE GPIO/TGPIO

 arch/x86/include/asm/tsc.h   |   8 ++
 arch/x86/kernel/tsc.c        | 168 +++++++++++++++++++++++-
 drivers/mfd/Kconfig          |  12 ++
 drivers/mfd/Makefile         |   1 +
 drivers/mfd/intel-ehl-gpio.c | 248 +++++++++++++++++++++++++++++++++++
 5 files changed, 435 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mfd/intel-ehl-gpio.c

-- 
2.25.1


