From: hongzha1 <hongzhan.chen@intel.com>
Subject: [for-upstream/dovetail 0/2] Add support for Cherryview GPIO
Date: Wed, 12 May 2021 21:02:36 -0400
Message-Id: <20210513010238.32466-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

1. introduce helper to find array of gpiochips
2. Add support for Cherryview GPIO controller based on helper 1.

I already validated them on Rock PI X board.

hongzha1 (2):
  drivers/gpio: core: introduce helper to find array of gpiochips
  driver/gpio: cherryview: introduce gpio driver for pinctl Cherryview

 include/cobalt/kernel/rtdm/gpio.h     |  4 +++
 kernel/drivers/gpio/Kconfig           |  7 +++++
 kernel/drivers/gpio/Makefile          |  2 ++
 kernel/drivers/gpio/gpio-cherryview.c | 43 +++++++++++++++++++++++++++
 kernel/drivers/gpio/gpio-core.c       | 19 ++++++++++++
 5 files changed, 75 insertions(+)
 create mode 100644 kernel/drivers/gpio/gpio-cherryview.c

-- 
2.17.1


