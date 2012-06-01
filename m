MIME-Version: 1.0
Date: Fri, 1 Jun 2012 11:24:50 +0530
Message-ID: <CAM1yFZ9tDsgAYo1dJOc7CxoAEnLLkFqnQBL8QbO8Wb=K2yY4wg@mail.gmail.com>
From: Anisha Kaul <born.rebel.83@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] CONFIG_CPU_FREQ, CONFIG_APM. kernel - 2.6.38.8
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Greetings,

W.r.t kernel - 2.6.38.8

This page http://www.xenomai.org/documentation/xenomai-2.6/TROUBLESHOOTING
asks us to disable "CONFIG_CPU_FREQ".

Power management and ACPI options
-->CPU Frequency scaling
-->-->CPU_FREQ_GOV_CONSERVATIVE
-->-->CPU_FREQ_GOV_ONDEMAND
-->-->CPU_FREQ_PMAC64
-->-->CPU_FREQ_DEFAULT_GOV_PERFORMANCE
-->-->CPU_FREQ_GOV_PERFORMANCE
-->-->CPU_FREQ_GOV_USERSPACE

There isn't any particular option named "CONFIG_CPU_FREQ".
Does this mean that we have to disable whole bunch of all these above optio=
ns?


Same is the case with "CONFIG_APM". It also has various variants as follows=
:
APM_CPU_IDLE
APM_IGNORE_USER_SUSPEND
APM_DO_ENABLE

Location is said to be in:
--> Power management and ACPI options
-->--> APM (Advanced Power Management) BIOS support (APM [=3Dn])

But in kernel 2.6.38.8 there isn't any option called "APM (Advanced
Power Management) BIOS support" anywhere.
"Power management and ACPI options" results in the following menu.

  [*] Power Management support
  [*]   Power Management Debug Support
  [*]     Extra PM attributes in sysfs for low-level debugging/testing
  [ ]     Verbose Power Management debugging
  [*] Suspend/resume event tracing
  [*] Suspend to RAM and standby
  [ ]   Test suspend/resume and wakealarm during bootup
  [*] Hibernation (aka 'suspend to disk')
  ()    Default resume partition
  [*] Run-time PM core functionality
  [*] ACPI (Advanced Configuration and Power Interface) Support  --->
  [*] SFI (Simple Firmware Interface) Support  --->
  CPU Frequency scaling  --->
  -*- CPU idle PM support
  [ ]   Cpuidle Driver for Intel Processors (NEW)
  Memory power savings  --->


  "ACPI (Advanced Configuration and Power Interface) Support"  results
in the following menu:

  --- ACPI (Advanced Configuration and Power Interface) Support
                                                  =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                [*]   =
Deprecated
/proc/acpi files
                               =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                [*]   =
Deprecated
power /proc/acpi directories
                               =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                <M>   =
ACPI 4.0
power meter
                                 =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                < >   =
EC
read/write access through /sys/kernel/debug/ec (NEW)
                                       =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                [*]   =
Deprecated
/proc/acpi/event support
                               =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                <M>   =
AC Adapter

                              =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                <M>   =
Battery

                              =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                {M}   =
Button

                              =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                {M}   =
Video

                              =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                <M>   =
Fan

                              =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                [*]   =
Dock

                              =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                <M>   =
Processor

                              =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                < >   =
IPMI (NEW)

                              =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                <M>   =
Processor
Aggregator
                                =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                <M>   =
Thermal
Zone
                                  =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                -*-   =
NUMA
support
                                     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                ()    =
Custom DSDT
Table file to include
                              =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                [*]   =
Debug
Statements
                                    =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                [ ]
Additionally enable ACPI function tracing
                                        =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                <M>   =
PCI slot
detection driver
                                 =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                {M}   =
Container
and Module Devices (EXPERIMENTAL)
                                =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                <M>   =
Memory
Hotplug
                                   =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                <M>   =
Smart
Battery System
                                    =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                < >   =
Hardware
Error Device (NEW)
                                 =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82                                                [ ]   =
ACPI
Platform Error Interface (APEI) (NEW)
                                     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82

  Has some names been changed or I am simply missing some point?
  Please guide.

Regards,
-Anisha

