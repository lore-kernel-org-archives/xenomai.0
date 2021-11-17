From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 0/4] Version updates, kas menu support
Date: Wed, 17 Nov 2021 19:34:15 +0100
Message-Id: <cover.1637174059.git.jan.kiszka@siemens.com>
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

Heading towards a release as well...

Jan

Jan Kiszka (4):
  xenomai: Add 3.2.1 and update other stable versions
  xenomai-version.inc: Add stable-head versions as well
  linux-xenomai: Update to latest releases
  Add kas menu support

 .gitignore                                    |   1 +
 Kconfig                                       | 148 ++++++++++++++++++
 README.md                                     |  20 ++-
 conf/distro/include/xenomai-version.inc       |  21 ++-
 conf/distro/xenomai-demo.conf                 |   4 +-
 opt-xenomai-3.2.x.yml                         |  17 ++
 recipes-kernel/linux/linux-xenomai_4.19.bb    |  14 +-
 recipes-kernel/linux/linux-xenomai_4.4.bb     |  10 +-
 recipes-kernel/linux/linux-xenomai_5.10.bb    |   4 +-
 recipes-kernel/linux/linux-xenomai_5.4.bb     |  12 +-
 .../{xenomai_3.0.11.bb => xenomai_3.0.12.bb}  |   2 +
 .../{xenomai_3.1.1.bb => xenomai_3.1.2.bb}    |   2 +
 .../{xenomai_3.1.1.bb => xenomai_3.2.1.bb}    |   4 +-
 13 files changed, 220 insertions(+), 39 deletions(-)
 create mode 100644 Kconfig
 create mode 100644 opt-xenomai-3.2.x.yml
 rename recipes-xenomai/xenomai/{xenomai_3.0.11.bb => xenomai_3.0.12.bb} (79%)
 copy recipes-xenomai/xenomai/{xenomai_3.1.1.bb => xenomai_3.1.2.bb} (79%)
 rename recipes-xenomai/xenomai/{xenomai_3.1.1.bb => xenomai_3.2.1.bb} (73%)

-- 
2.31.1


