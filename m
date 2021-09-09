From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 0/3] Improve consistency of kernel version
 selection
Date: Thu,  9 Sep 2021 19:44:31 +0200
Message-Id: <cover.1631209474.git.jan.kiszka@siemens.com>
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

Will also help adding a kas menu later on (prototype is working already).

Jan

Jan Kiszka (3):
  linux-xenomai: Add recipe to build 5.10 dovetail release
  Rename local_conf_header section for kernel version
  Provide consistent kas files for selecting kernels

 ci/gitlab-ci-base.yml                          |  1 -
 ci/kernel_4_19_xenomai_next.yml                |  6 ++++++
 ci/xenomai_3_0_x.yml                           |  2 ++
 ci/xenomai_3_1_x.yml                           |  6 ++++++
 opt-linux-4.19.yml                             |  4 ++--
 opt-linux-4.4.yml                              |  4 ++--
 ...linux-latest-5.10.yml => opt-linux-5.10.yml |  5 ++---
 opt-linux-latest-5.10.yml => opt-linux-5.4.yml |  5 ++---
 ...nux-latest.yml => opt-linux-latest-4.19.yml |  0
 ...latest-5.10.yml => opt-linux-latest-4.4.yml |  2 +-
 opt-linux-latest-5.10.yml                      |  2 +-
 opt-linux-latest-5.4.yml                       |  2 +-
 recipes-kernel/linux/linux-xenomai_5.10.bb     | 18 ++++++++++++++++++
 13 files changed, 43 insertions(+), 14 deletions(-)
 copy opt-linux-latest-5.10.yml => opt-linux-5.10.yml (65%)
 copy opt-linux-latest-5.10.yml => opt-linux-5.4.yml (65%)
 rename opt-linux-latest.yml => opt-linux-latest-4.19.yml (100%)
 copy opt-linux-latest-5.10.yml => opt-linux-latest-4.4.yml (89%)
 create mode 100644 recipes-kernel/linux/linux-xenomai_5.10.bb

-- 
2.31.1


