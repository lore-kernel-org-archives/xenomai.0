From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [xenomai-image 0/3] control applying of no debug fragment
Date: Tue, 27 Jul 2021 22:21:21 -0400
Message-Id: <20210728022124.23466-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

1. disable CONFIG_XENO_OPT_DEBUG* in common nodbg fragment.
2. control applying no debug fragment. By default, nodebug switch is off.
3. Add kas option for swithing off debug.

Hongzhan Chen (3):
  recipes-kernel/linux: control appyling of no debug config fragment
  Add kas option for swithing off debug
  recipes-kernel: disable more debugs for common nodbg fragment

 README.md                                   |  5 +++++
 opt-set-nodbg.yml                           | 20 ++++++++++++++++++++
 recipes-kernel/linux/files/common_nodbg.cfg |  1 +
 recipes-kernel/linux/linux-xenomai.inc      |  2 ++
 4 files changed, 28 insertions(+)
 create mode 100644 opt-set-nodbg.yml

-- 
2.17.1


