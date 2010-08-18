MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Content-class: urn:content-classes:message
Date: Wed, 18 Aug 2010 12:03:25 -0400
Message-ID: <6FCCA913376DD7488F4139A4D11B8F4801465AC9@domain.hid>
From: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Subject: [Xenomai-help] RTDM task blocks when connecting gdb to realtime task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello:

I am using Xenomai 2.4.10 on PPC. An RTDM driver creates an RTDM task
using rtdm_task_init() and goes to sleep periodically via function
rtdm_task_sleep().

When driver is loaded, RTDM task executes as expected. Then a realtime
application is started via gdbserver on target board and on a linux host
a gdb client is connected to that board. As soon as gdb breakpoints the
realtime application the RTDM task never returns from rtdm_task_sleep().
The application does not open the RTMD driver so at this point there is
no interaction with the driver.

The RTDM task is intr_sim and the timer is no longer firing
# cat /proc/xenomai/timerstat/master
CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME
0    29198042    9132085     3724750    -          NULL
[host-timer]
0    1340        1340        -          -          xnthread_ti  intr_sim

The realtime application is ancvbirt.
# cat /proc/xenomai/sched
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT
  0  0       90      0          0          master    D          intr_sim
  0  1869     0      0          0          master    XT         ancvbirt

Any ideas on the cause of the problem and fix?

Thanks,
Luis G. Herrera-Bendezu


