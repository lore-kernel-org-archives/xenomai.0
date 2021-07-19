From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 3/3] ci/gitlab-ci-base: use rules
Date: Mon, 19 Jul 2021 18:29:49 +0200
Message-Id: <20210719162949.4342-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210719162949.4342-1-Quirin.Gylstorff@siemens.com>
References: <20210719162949.4342-1-Quirin.Gylstorff@siemens.com>
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

Replace `only` and `except` with rules as
'`only` and `except` are no longer actively developed. `rules`
is the preferred keyword to control ...'[1]

[1]: https://docs.gitlab.com/ee/ci/yaml/#only--except

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ci/gitlab-ci-base.yml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index d80efa1..e23849d 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -57,9 +57,8 @@ default:
       junit:
         - report.xml
     expire_in: 1 week
-  only:
-    variables:
-      - $LAVA_TESTS_ENABLED == "true"
+  rules:
+    - if: '$LAVA_TESTS_ENABLED == "true"'
 
 .build:qemu-amd64:
   extends: .build
-- 
2.20.1


