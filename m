From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [RFC PATCH 0/2] cobalt_switch_context plugin
Date: Mon, 13 Dec 2021 22:15:35 -0500
Message-Id: <20211214031537.14914-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

1. add plugin to take correct action to show correct color for
   cobalt_switch_context in cpu plot
2. show hollow blue box underneath baseline of task plot to mark
   oob state task is runing on.

steps to show hollow blue box
1. loading trace-cmd data, please note that it would check if there
    is cobalt_switch_context event in data. If does not exist ,the
    cobalt_switch_context plugin would fail to init.
2. click menu plots-> tasks and then choose RT tasks that you want to
   show and then apply.
3. In RT tasks plot shape you may find the hollow blue box that indicating that 
   it is running on OOB underneath the baseline of plot.

Please help check if it meet our requirement and comments.


Hongzhan Chen (2):
  kernel-shark: add plugin for handling xenomai cobalt context switch
    event
  kernelshark: shape blue hollow box to show OOB state of task

 src/libkshark-tepdata.c                    |   1 +
 src/plugins/CMakeLists.txt                 |   4 +
 src/plugins/CobaltSwitchEvents.cpp         | 204 +++++++++++++++++++++
 src/plugins/xenomai_cobalt_switch_events.c | 196 ++++++++++++++++++++
 src/plugins/xenomai_cobalt_switch_events.h |  64 +++++++
 5 files changed, 469 insertions(+)
 create mode 100644 src/plugins/CobaltSwitchEvents.cpp
 create mode 100644 src/plugins/xenomai_cobalt_switch_events.c
 create mode 100644 src/plugins/xenomai_cobalt_switch_events.h

-- 
2.17.1


