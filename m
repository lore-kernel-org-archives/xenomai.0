From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 0/4] Prepare xenomai-images for public LAVA
 Server
Date: Thu,  8 Jul 2021 17:02:57 +0200
Message-Id: <20210708150301.24083-1-Quirin.Gylstorff@siemens.com>
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
To: jan.kiszka@siemens.com, xenomai@xenomai.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add option to upload the image under test to AWS.
Add option to use AWS as image download source and use
[1] as default LAVA server.

After this patchset is merged the private lava lab
can be migrated.

[1]: https://lava.xenomai.org

Quirin Gylstorff (4):
  ci: Add option to upload artifacts to aws bucket
  ci: adapt to public lava-server
  scripts/run_lava_tests.sh: cleanup shellcheck warnings
  README: Add information about LAVA Lab

 README.md                 | 14 ++++++
 ci/gitlab-ci-base.yml     |  6 ++-
 scripts/deploy_to_aws.sh  | 46 ++++++++++++++++++++
 scripts/run-lava-tests.sh | 90 +++++++++++++++++++++++----------------
 4 files changed, 117 insertions(+), 39 deletions(-)
 create mode 100755 scripts/deploy_to_aws.sh

- '- 
2.20.1


