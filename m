From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH V3 0/3] introduce latmus
Date: Wed, 21 Apr 2021 01:05:06 -0400
Message-Id: <20210421050509.31420-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Latmus is a backport from EVL to Cobalt, the procedure is fully
described here: https://evlproject.org/core/benchmarks/

I verified all functions of latmus on hardware environment under which 
Rock PI X board connect GPIOs with FRDM K64F.But actually Rock PI X V1.4
board's GPIO I/O voltage is 1.8V does not match 3.3V of FRDM K64F board.
Even though I tried to set up IO shifter board to bridge two boards,
still can not get correct latecny data because of bad IO signal. So I
have to work around to loopback Input/Output GPIOs on both boards to do
verify functions.

Hardware setup:

---------------------------------------------------
     eth|                                     |eth
        +                                     +
      FRDM K64F board                   Rock PI X board                  
      |         |                       |           |
      +_________+                       +___________+  
     GPIO Loopback                      GPIO Loopback

hongzha1 (3):
  rtdm/testing: latmus: introduce latmus driver
  drivers/gpio: core: introduce helper to find gpiochip
  testsuite/latmus: introduce latmus benchmark

 configure.ac                      |    1 +
 doc/asciidoc/Makefile.am          |    2 +
 doc/asciidoc/man1/latmus.adoc     |  112 +++
 include/cobalt/kernel/rtdm/gpio.h |    3 +
 include/rtdm/uapi/testing.h       |   79 ++
 kernel/drivers/gpio/gpio-core.c   |   23 +
 kernel/drivers/testing/Kconfig    |   10 +
 kernel/drivers/testing/Makefile   |    3 +
 kernel/drivers/testing/latmus.c   | 1237 ++++++++++++++++++++++++
 testsuite/Makefile.am             |    4 +-
 testsuite/latmus/Makefile.am      |   18 +
 testsuite/latmus/latmus.c         | 1446 +++++++++++++++++++++++++++++
 12 files changed, 2937 insertions(+), 1 deletion(-)
 create mode 100644 doc/asciidoc/man1/latmus.adoc
 create mode 100644 kernel/drivers/testing/latmus.c
 create mode 100644 testsuite/latmus/Makefile.am
 create mode 100644 testsuite/latmus/latmus.c

-- 
2.17.1


