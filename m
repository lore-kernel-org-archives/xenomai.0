From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 0/4] Incorporate Comments and fix AWS upload
Date: Tue, 13 Jul 2021 16:51:38 +0200
Message-Id: <20210713145142.16025-1-Quirin.Gylstorff@siemens.com>
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
To: xenomai@xenomai.org, jan.kiszka@siemens.com

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

 Incorporate the comments from patchset[1] set by uploading a test-report.xml
 to gitlab artifacts[2] and replace sed commands with envsubst[3].

[1]: https://xenomai.org/pipermail/xenomai/2021-July/045823.html
[2]: https://xenomai.org/pipermail/xenomai/2021-July/045833.html
[3]: https://xenomai.org/pipermail/xenomai/2021-July/045830.html

Quirin Gylstorff (4):
  scripts/deploy_to_aws: Correct upload of dtb
  scripts/run-lava-tests: upload lava test report
  scripts/run-lava-tests: replace sed with envsubst
  scripts/run-lava-tests: parse test-report for errors

 ci/gitlab-ci-base.yml     |  5 +++++
 scripts/deploy_to_aws.sh  |  4 ++--
 scripts/run-lava-tests.sh | 26 ++++++++++++++++++--------
 3 files changed, 25 insertions(+), 10 deletions(-)

-- 
2.20.1


