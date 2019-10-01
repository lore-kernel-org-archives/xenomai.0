From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 0/4] ci improvements
Date: Tue,  1 Oct 2019 14:51:59 +0200
Message-Id: <20191001125203.10757-1-Quirin.Gylstorff@siemens.com>
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

Improve the ci by:

- Adding  option --vm to successfully execute qemu tests.
- Fixing beaglebone tests after lava update.
- Compress rootfs to speed up the deployment
- use pipeline id to differ between test runs.

Changes:
V2:
- cleanup

Quirin Gylstorff (4):
  ci: Use unique test ids
  ci: Use compression for rootfs
  ci: Run qemu tests with --vm option
  xenomai-beaglebone: remove context after update

 scripts/deploy_for_testing.sh     |  7 ++++++-
 scripts/run-lava-tests.sh         | 13 ++++++++++++-
 tests/jobs/xenomai-beaglebone.yml |  9 +++------
 tests/jobs/xenomai-minnow.yml     |  6 +++---
 tests/jobs/xenomai-qemu-amd64.yml | 12 +++++++-----
 tests/jobs/xenomai-qemu-arm64.yml | 12 +++++++-----
 tests/jobs/xenomai-qemu-armhf.yml | 12 +++++++-----
 tests/jobs/xenomai-x86-64.yml     |  6 +++---
 8 files changed, 48 insertions(+), 29 deletions(-)

-- 
2.20.1


