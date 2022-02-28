From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH 0/4] Add kernel-shark plug and libtraceevent plugin
Date: Mon, 28 Feb 2022 00:40:51 -0500
Message-Id: <20220228054055.16112-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

1. Add kernel-shark plugin to visualize OOB state of xenomai realtime
   thread.
2. Add libtraceevent plugin to parse xenomai_schedparams correctly
3. build: Add c++ build support to build kernel-shark plugin
4. Add --with-kernelshark option to build plugins in userland.


Hongzhan Chen (4):
  build: Add c++ build support
  Kernel-shark: Add xenomai_cobalt_switch_events plugin for kernel-shark
  Add --with-kernelshark option
  libtraceevent: Add Add xenomai_schedparams plugin for libtraceevent

 Makefile.am                                   |   6 +
 configure.ac                                  |  29 +++
 kernel-shark/Makefile.am                      |   8 +
 .../kernelshark/CobaltSwitchEvents.cpp        | 156 ++++++++++++++
 kernel-shark/kernelshark/Makefile.am          |  18 ++
 kernel-shark/kernelshark/README               |  75 +++++++
 .../xenomai_cobalt_switch_events.c            | 174 +++++++++++++++
 .../xenomai_cobalt_switch_events.h            |  58 +++++
 kernel-shark/libtraceevent/Makefile.am        |  10 +
 kernel-shark/libtraceevent/README             |  30 +++
 .../plugin_xenomai_schedparams.c              | 201 ++++++++++++++++++
 11 files changed, 765 insertions(+)
 create mode 100644 kernel-shark/Makefile.am
 create mode 100644 kernel-shark/kernelshark/CobaltSwitchEvents.cpp
 create mode 100644 kernel-shark/kernelshark/Makefile.am
 create mode 100644 kernel-shark/kernelshark/README
 create mode 100644 kernel-shark/kernelshark/xenomai_cobalt_switch_events.c
 create mode 100644 kernel-shark/kernelshark/xenomai_cobalt_switch_events.h
 create mode 100644 kernel-shark/libtraceevent/Makefile.am
 create mode 100644 kernel-shark/libtraceevent/README
 create mode 100644 kernel-shark/libtraceevent/plugin_xenomai_schedparams.c

-- 
2.17.1


