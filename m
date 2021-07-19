From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 3/3] ci/gitlab-ci-base: use rules
Date: Mon, 19 Jul 2021 16:29:47 +0200
Message-Id: <20210719142947.3034-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210719142947.3034-1-Quirin.Gylstorff@siemens.com>
References: <20210719142947.3034-1-Quirin.Gylstorff@siemens.com>
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

Replace `only` and `except` with rules as
'`only` and `except` are no longer actively developed. `rules`
is the preferred keyword to control ...'[1]

[1]: https://docs.gitlab.com/ee/ci/yaml/#only--except

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ci/gitlab-ci-base.yml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 84bbdd4..535b972 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -61,9 +61,8 @@ default:
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


