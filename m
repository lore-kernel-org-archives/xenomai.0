From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [xenomai-image PATCH v2 0/5] control applying of no-debug config
Date: Mon, 26 Jul 2021 20:42:12 -0400
Message-Id: <20210727004217.10892-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

1. enable IPIPE_DEBUG uniformly for all arch by default in order to use
uniform method to control it via applying config fragment or not.
2. create common config fragment to switch debug off.
3. add control to apply config fragment or not.
4. add kas option to control applying config fragment.

Hongzhan Chen (5):
  recipes-kernel: arm64_config: enable IPIPE_DEBUG for arm64 by default
  recipes-kernel: armhf_config: enable IPIPE_DEBUG for armhf by default
  recipes-kernel: add common config fragment file to disable debug
  recipes-kernel/linux: control appyling of no debug config fragment
  Add kas option for swithing off debug

 opt-set-nodbg.yml                           | 20 ++++++++++++++++++++
 recipes-kernel/linux/files/arm64_defconfig  |  9 +++++----
 recipes-kernel/linux/files/armhf_defconfig  | 15 +++++++++++++--
 recipes-kernel/linux/files/common_nodbg.cfg |  1 +
 recipes-kernel/linux/linux-xenomai.inc      | 10 +++++++++-
 5 files changed, 48 insertions(+), 7 deletions(-)
 create mode 100644 opt-set-nodbg.yml
 create mode 100644 recipes-kernel/linux/files/common_nodbg.cfg

-- 
2.17.1


