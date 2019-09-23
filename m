From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH] scripts/install_lavacli: install wheel
Date: Mon, 23 Sep 2019 15:32:06 +0200
Message-Id: <20190923133206.15377-1-Quirin.Gylstorff@siemens.com>
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

Avoid unnecessary error messages during the installation of
lavacli by installing wheel.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/install-lavacli.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/install-lavacli.sh b/scripts/install-lavacli.sh
index 66600f2..f31a394 100755
--- a/scripts/install-lavacli.sh
+++ b/scripts/install-lavacli.sh
@@ -17,5 +17,6 @@ if [ "${os_version_id}" -ge "10" ]; then
     sudo apt update
     sudo apt install -y lavacli
 else
+    sudo pip3 install wheel
     sudo pip3 install lavacli
 fi
-- 
2.20.1


