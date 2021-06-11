From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 0/5] Update versions, add 5.10 kernel
Date: Fri, 11 Jun 2021 22:13:07 +0200
Message-Id: <cover.1623442392.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This first of all updates a number of recipes to reflect latest Xenomai
and I-pipe release.

And then, now that Dovetail support is part of the Xenomai next branch,
add CI and testing targets for this kernel. This obsoletes the
wip/dovetail branch.

Jan

Jan Kiszka (5):
  linux-xenomai: Update to latest 4.4 and 4.19 ipipe releases
  xenomai: Update to 3.1.1
  linux-xenomai: Add 5.4 recipe and make it default
  linux-xenomai: Add support for 5.10 to latest recipe
  ci: Add kernel 5.10 to xenomai_next build

 ci/kernel_5_10_xenomai_next.yml               | 88 +++++++++++++++++++
 ci/xenomai_next.yml                           |  3 +-
 conf/distro/include/xenomai-version.inc       |  2 +-
 opt-linux-latest-5.10.yml                     | 18 ++++
 recipes-kernel/linux/linux-xenomai_4.19.bb    | 12 +--
 recipes-kernel/linux/linux-xenomai_4.4.bb     |  8 +-
 ...x-xenomai_4.19.bb => linux-xenomai_5.4.bb} | 16 ++--
 recipes-kernel/linux/linux-xenomai_latest.bb  | 20 ++---
 .../{xenomai_3.1.bb => xenomai_3.1.1.bb}      |  4 +-
 9 files changed, 139 insertions(+), 32 deletions(-)
 create mode 100644 ci/kernel_5_10_xenomai_next.yml
 create mode 100644 opt-linux-latest-5.10.yml
 copy recipes-kernel/linux/{linux-xenomai_4.19.bb => linux-xenomai_5.4.bb} (58%)
 rename recipes-xenomai/xenomai/{xenomai_3.1.bb => xenomai_3.1.1.bb} (78%)

-- 
2.26.2


