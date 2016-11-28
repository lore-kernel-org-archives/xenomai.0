From: Jorge Ramirez <jro@xenomai.org>
Message-ID: <982f12b3-8171-c307-cbd8-f629bf2ac91e@xenomai.org>
Date: Mon, 28 Nov 2016 13:11:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] gpiopwm
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Philippe,

Please could you pull from

Hi Philippe

This pull request implements a number of PWM generators using gpio lines.

One nice feature of the demo code is that it shows how to configure a 
udp server to receive the duty cycles over the net and submit them to 
the driver.

That way the user can control the motors with a simple remote 
application like this one.
https://github.com/ldts/servo-udp

thanks
jorge

----------------------------------------------------


The following changes since commit bb7cb06bf80aa193d68906f30131b50d4b8f27a7:

   lib/cobalt: Provide RT-capable usleep (2016-11-28 17:02:52 +0100)

are available in the git repository at:

   http://git.xenomai.org/xenomai-jro.git next

for you to fetch changes up to 61051214ba8834f0289acef8bd7757a3afd1e0e0:

   gpiopwm: display udp server information (2016-11-28 12:32:16 -0500)

----------------------------------------------------------------
Jorge Ramirez-Ortiz (2):
       gpiopwm: pwm signal generator and servo motor control demo code
       gpiopwm: display udp server information

  demo/posix/cobalt/Makefile.am        |   6 ++
  demo/posix/cobalt/gpiopwm.c          | 504 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  include/cobalt/kernel/rtdm/gpiopwm.h |  24 +++++++
  include/rtdm/uapi/gpiopwm.h          |  56 +++++++++++++++
  include/rtdm/uapi/rtdm.h             |   1 +
  kernel/drivers/Kconfig               |   1 +
  kernel/drivers/Makefile              |   3 +-
  kernel/drivers/gpiopwm/Kconfig       |   9 +++
  kernel/drivers/gpiopwm/Makefile      |   5 ++
  kernel/drivers/gpiopwm/gpiopwm.c     | 301 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  10 files changed, 909 insertions(+), 1 deletion(-)
  create mode 100644 demo/posix/cobalt/gpiopwm.c
  create mode 100644 include/cobalt/kernel/rtdm/gpiopwm.h
  create mode 100644 include/rtdm/uapi/gpiopwm.h
  create mode 100644 kernel/drivers/gpiopwm/Kconfig
  create mode 100644 kernel/drivers/gpiopwm/Makefile
  create mode 100644 kernel/drivers/gpiopwm/gpiopwm.c



