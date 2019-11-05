From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images PATCH 0/2] Add hikey test support
Date: Tue,  5 Nov 2019 17:22:37 +0100
Message-Id: <20191105162239.18949-1-Quirin.Gylstorff@siemens.com>
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

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add hikey as platform for xenomai arm64 tests on LAVA.

Quirin Gylstorff (2):
  tests: hikey xenomai-tests
  ci: add hikey test

 .gitlab-ci.yml                             | 13 +++-
 conf/machine/hikey.conf                    |  3 +
 recipes-kernel/linux/files/arm64_defconfig |  6 +-
 tests/jobs/xenomai-hikey.yml               | 72 ++++++++++++++++++++++
 4 files changed, 90 insertions(+), 4 deletions(-)
 create mode 100644 tests/jobs/xenomai-hikey.yml

-- 
2.20.1


