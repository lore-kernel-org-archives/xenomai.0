From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 0/3] Allow GPIO timestamps also via real-time clock
Date: Tue, 31 Aug 2021 09:15:05 +0200
Message-Id: <cover.1630394108.git.jan.kiszka@siemens.com>
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

Changes in v2:
 - respect selected mode also in gpio_pin_interrupt
 - select timestamp mode explicitly in gpiobench

As discussed, we need to add a separate control to manage whether the
monotonic or the real-time clock should be used for GPIO timestamping.

Patch 1 adds this, keeping the default to monotonic. This can be added
to 3.1.x stable as well. Patch 3 aligns the default to the rest of
Xenomai, using real-time from now on. That's 3.2 material.

Jan

Jan Kiszka (3):
  drivers/gpio: Add support for selecting real-time clock timestamps
  testsuite/gpiobench: Explicitly request monotonic timestamps
  drivers/gpio: Flip default for GPIO_RTIOC_TS to real-time clock

 include/cobalt/kernel/rtdm/gpio.h |  1 +
 include/rtdm/uapi/gpio.h          |  4 +++-
 kernel/drivers/gpio/gpio-core.c   | 19 +++++++++++++++----
 testsuite/gpiobench/gpiobench.c   |  2 +-
 4 files changed, 20 insertions(+), 6 deletions(-)

-- 
2.31.1


