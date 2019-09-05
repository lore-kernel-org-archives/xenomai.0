From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 7/9] README: correct build line
Date: Thu,  5 Sep 2019 17:44:23 +0200
Message-Id: <20190905154425.10007-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20190905154425.10007-1-Quirin.Gylstorff@siemens.com>
References: <20190905154425.10007-1-Quirin.Gylstorff@siemens.com>
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

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.md b/README.md
index f65eac7..5b84983 100644
--- a/README.md
+++ b/README.md
@@ -50,7 +50,7 @@ To execute the CI build use:
 ```
 gitlab-runner exec docker --docker-privileged \
   --env "HTTP_PROXY=$HTTP_PROXY" --env "HTTPS_PROXY=$HTTPS_PROXY" \
-  --env "NO_PROXY=$NO_PROXY" build:armhf
+  --env "NO_PROXY=$NO_PROXY" build:qemu-armhf
 ```
 
 ## Community Resources
-- 
2.20.1


