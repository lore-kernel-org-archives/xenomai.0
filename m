From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [xenomai-images 0/7] control applying of no-debug config
Date: Thu, 22 Jul 2021 23:18:04 -0400
Message-Id: <20210723031811.19290-1-hongzhan.chen@intel.com>
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
2. create config fragment for earch arch to switch debug off.
3. add control to apply config fragment or not.
4. add kas option to control applying config fragment.

*** BLURB HERE ***

Hongzhan Chen (7):
  recipes-kernel: arm64_config: enable IPIPE_DEBUG for arm64 by default
  recipes-kernel: armhf_config: enable IPIPE_DEBUG for armhf by default
  recipes-kernel: add config fragment file to disable debug for amd64
  recipes-kernel: add config fragment file to disable debug for arm64
  recipes-kernel: add config fragment file to disable debug for arm
  recipes-kernel/linux: control appyling of no debug config fragment
  Add kas option for swithing off debug

 opt-set-nodbg.yml                          | 20 ++++++++++++++++++++
 recipes-kernel/linux/files/amd64_nodbg.cfg |  1 +
 recipes-kernel/linux/files/arm64_defconfig |  9 +++++----
 recipes-kernel/linux/files/arm64_nodbg.cfg |  1 +
 recipes-kernel/linux/files/armhf_defconfig | 15 +++++++++++++--
 recipes-kernel/linux/files/armhf_nodbg.cfg |  1 +
 recipes-kernel/linux/linux-xenomai.inc     | 10 +++++++++-
 7 files changed, 50 insertions(+), 7 deletions(-)
 create mode 100644 opt-set-nodbg.yml
 create mode 100644 recipes-kernel/linux/files/amd64_nodbg.cfg
 create mode 100644 recipes-kernel/linux/files/arm64_nodbg.cfg
 create mode 100644 recipes-kernel/linux/files/armhf_nodbg.cfg

-- 
2.17.1


