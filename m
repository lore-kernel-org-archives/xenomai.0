From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH 0/2] to remove TODO
Date: Tue, 23 Nov 2021 20:40:56 -0500
Message-Id: <20211124014058.12195-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

As discussed in https://xenomai.org/pipermail/xenomai/2021-November/046803.html
1. improve xntrace_user_stop 
2. remove TODO and return -ENOSYS directly for unportable features

Hongzhan Chen (2):
  cobalt/trace: dovetail: improve xntrace_user_stop to replace TODO
  cobalt/trace: dovetail: remove TODO and return -ENOSYS for unportable
    features

 .../cobalt/kernel/dovetail/pipeline/trace.h   | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

-- 
2.17.1


