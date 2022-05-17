From: Zqiang <qiang1.zhang@intel.com>
Subject: [PATCH 0/4] TGPIO: Introduce tgpio driver and testcase
Date: Tue, 17 May 2022 09:51:48 +0800
Message-Id: <20220517015152.697886-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

General-Purpose I/O (GPIO) is a digital signal pin on an electronic device
without a specified purpose. A GPIO pin can work as output (by switching to
the high or low state) or as input (by reading whether a pin is in the high
or low state).

The control of GPIOs on a system with Linux* or other OS may be less precise
and produce more jitter compared to a bare-metal solution because of the OS
scheduler.

Certain Intel processors(Intel Atom x6000E or 11th generation Intel Core
processors) have a hardware feature called Time-Aware GPIO (TGPIO). These
processors have one or more TGPIO pins, which you can control using timestamps.
You can program a specific timestamp to toggle a TGPIO pin, or capture the
current timestamp when a pin is toggled. This is done by hardware, so the OS
or other software do not affect the precision.

In this patchset, we add tgpio driver and tgpiotest smokey testcase.

TGPIO RTDM driver:

The TGPIO interface is represented as a RT PTP device(/dev/rtdm/pmc-tgpio and
pse-tgpio). It is controlled using ioctl() syscalls and provides the following
features:

1. Getting TGPIO capabilities: number of pins, number of channels.
2. Generating signals with a given period, which starts at a specific timestamp.
3. Reading the timestamp when the input pin’s state changes.
4. Cross-timestamping the TGPIO clock with the system clock.

TGPIO smokey testcase:

The tgpiotest smokey testcase demonstrate how to start working with Time-Aware
GPIO (TGPIO):

The info sample (tgpio_info) is a self-contained example program
demonstrating how to get a report of available TGPIO capabilities for
a specified device.

for example:
./tgpiotest --run=3 --verbose=4 --main-prio=90 device=/dev/rtdm/pmc-tgpio (or
pse-tgpio)

The basic oneshot output sample (tgpio_oneshot_output) is a self-contained
example program demonstrating a TGPIO single-shot output scenario. The sample
demonstrates how to trigger a TGPIO pin at the specific timestamp. In this
sample, this timestamp is specified as an offset from the Base time.

for example:
./tgpiotest --run=0 --verbose=4 --main-prio=90 device=/dev/rtdm/pmc-tgpio (or
pse-tgpio) pin=1 channel=1 start=10000000(ns)

The basic periodic output sample (tgpio_periodic_output) is a self-contained
example program demonstrating how to set a TGPIO pin to periodic output mode.
The sample generates a signal based on the specified period (1 second, for
example). The sample generates a voltage change on the output pin at the
specific timestamp.

for example:
./tgpiotest --run=1 --verbose=4 --main-prio=90 device=/dev/rtdm/pmc-tgpio (or
pse-tgpio) pin=1 channel=1 period=10000000(ns)

The basic input sample (tgpio_input) is a self-contained example program that
prints a timestamp when an edge is detected, indicating a change in the TGPIO
input pin state.

for example:
./tgpiotest --run=1 --verbose=4 --main-prio=90 device=/dev/rtdm/pse-tgpio (or
pmc-tgpio) pin=17 channel=17 mode=1

BIOS configuration:

To enable PMC Time-Aware GPIO, configure the following BIOS options:

Intel Advanced Menu > PCH IO Configuration > Enabled Timed GPIO0 [Enable]
Intel Advanced Menu > PCH IO Configuration > Enabled Timed GPIO1 [Enable]

To enable pins to be controlled as PSE-TGPIO from OS for Intel
Atom x6000E Series Processors, configure the following BIOS options:

Intel Advanced Menu > PCH IO Configuration > Security Configuration >
Force unlock on all GPIO pads > [Enabled]
Intel Advanced Menu > PCH IO Configuration > SerialIo Configuration >
SPI2 Controller > [Disabled]
Intel Advanced Menu > PCH IO Configuration > PSE configuration > SPI0 >
[Host owned with pin muxed]
Intel Advanced Menu > PCH IO Configuration > PSE configuration > Eclite >
[Disabled]
Intel Advanced Menu > PCH IO Configuration > PSE configuration > GPIO/TGPIO 0 >
[Host owned with pin muxed]
Intel Advanced Menu > PCH IO Configuration > PSE configuration >
GPIO/TGPIO 0 MUX SELECTION > MID
Intel Advanced Menu > PCH IO Configuration > PSE configuration >
GPIO/TGPIO 0 Pin Selection > Check pins 28 and 27
Intel Advanced Menu > PCH IO Configuration > PinCntrl Driver GPIO scheme >
[Enabled]
(Note: PSE-TGPIO only support for Atom x6000E)

Zqiang (4):
  driver/ptp: introduce real-time PTP driver support
  ptp/pmc-tgpio: introduce PMC Time-Aware GPIO driver for Intel
    Processors
  ptp/pse-tgpio: introduce PSE Time-Aware GPIO driver for Intel
    Processors
  testsuite/tgpiotest: introduce TGPIO smokey testcase

 configure.ac                     |   1 +
 include/rtdm/rt_ptp_clock.h      |  24 +
 include/rtdm/uapi/rt_ptp_clock.h | 258 ++++++++++
 include/rtdm/uapi/rtdm.h         |   1 +
 include/smokey/smokey.h          |  10 +
 kernel/drivers/Kconfig           |   2 +-
 kernel/drivers/Makefile          |   2 +-
 kernel/drivers/ptp/Kconfig       |  44 ++
 kernel/drivers/ptp/Makefile      |   8 +
 kernel/drivers/ptp/pmc-tgpio.c   | 827 +++++++++++++++++++++++++++++++
 kernel/drivers/ptp/pse-tgpio.c   | 568 +++++++++++++++++++++
 kernel/drivers/ptp/ptp.c         | 537 ++++++++++++++++++++
 kernel/drivers/ptp/ptp.h         | 106 ++++
 lib/smokey/helpers.c             |  19 +
 testsuite/Makefile.am            |   2 +
 testsuite/tgpiotest/Makefile.am  |  19 +
 testsuite/tgpiotest/tgpiotest.c  | 591 ++++++++++++++++++++++
 17 files changed, 3017 insertions(+), 2 deletions(-)
 create mode 100644 include/rtdm/rt_ptp_clock.h
 create mode 100644 include/rtdm/uapi/rt_ptp_clock.h
 create mode 100644 kernel/drivers/ptp/Kconfig
 create mode 100644 kernel/drivers/ptp/Makefile
 create mode 100644 kernel/drivers/ptp/pmc-tgpio.c
 create mode 100644 kernel/drivers/ptp/pse-tgpio.c
 create mode 100644 kernel/drivers/ptp/ptp.c
 create mode 100644 kernel/drivers/ptp/ptp.h
 create mode 100644 testsuite/tgpiotest/Makefile.am
 create mode 100644 testsuite/tgpiotest/tgpiotest.c

-- 
2.25.1


