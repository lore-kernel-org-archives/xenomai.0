From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images PATCH v2 7/9] ci: Make proxycommand conditional
Date: Fri, 14 Feb 2020 13:27:01 +0100
Message-Id: <20200214122703.7947-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200214122703.7947-1-Quirin.Gylstorff@siemens.com>
References: <20200214122703.7947-1-Quirin.Gylstorff@siemens.com>
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

To execute the ci in environments with and without proxy check
if https_proxy is set.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3f0dcfd..cda9f5b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -31,7 +31,7 @@ default:
 .add-lava-ssh-config:
   before_script:
     - mkdir -p -m=700 ~/.ssh
-    - echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config && chmod 600 ~/.ssh/config
+    - if [ -n "$https_proxy" ]; then echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config && chmod 600 ~/.ssh/config; fi;
     - echo "$LAVA_SSH_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/lava_id_rsa && chmod 600 ~/.ssh/lava_id_rsa
     - echo "$LAVA_SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts
 
-- 
2.20.1


