From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [xenomai-image 0/2] control applying of no debug config
Date: Wed, 28 Jul 2021 04:20:59 -0400
Message-Id: <20210728082101.5561-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

1. We apply no debug fragment by default.
2. User may want to switch on xenomai debug explicitly.

Hongzhan Chen (2):
  recipes-kernel/linux: control appyling of no debug config fragment
  Add kas option for swithing on xenomai debug

 README.md                              |  5 +++++
 opt-debug.yml                          | 19 +++++++++++++++++++
 recipes-kernel/linux/linux-xenomai.inc |  2 ++
 3 files changed, 26 insertions(+)
 create mode 100644 opt-debug.yml

-- 
2.17.1


