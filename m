From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 4/4] README: Add information about LAVA Lab
Date: Thu,  8 Jul 2021 17:03:01 +0200
Message-Id: <20210708150301.24083-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210708150301.24083-1-Quirin.Gylstorff@siemens.com>
References: <20210708150301.24083-1-Quirin.Gylstorff@siemens.com>
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

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 README.md | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/README.md b/README.md
index 69b3e13..c195c0c 100644
--- a/README.md
+++ b/README.md
@@ -53,6 +53,20 @@ gitlab-runner exec docker --docker-privileged \
   --env "NO_PROXY=$NO_PROXY" build:qemu-armhf
 ```
 
+## LAVA Lab
+
+The [Xenomai project](https://www.xenomai.org/) maintains a
+[LAVA lab](https://lava.xenomai.org) for integration testing.
+
+A LAVA lab can be created by following the
+[installation instructions](https://docs.lavasoftware.org/lava/first-installation.html)
+or use
+[lava docker](https://github.com/kernelci/lava-docker) for a faster setup.
+
+It is also possible to connect a lab to lava.xenomai.org. Please get in
+touch with the maintainers via mailing list to join a new lab with
+lava.xenomai.org.
+
 ## Community Resources
 
 See [Xenomai project](https://www.xenomai.org/).
-- 
2.20.1


