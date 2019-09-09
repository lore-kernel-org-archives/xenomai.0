From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [PATCH 1/2] debian/control: Add dependencies for xenomai-testsuite
Date: Mon,  9 Sep 2019 17:28:41 +0200
Message-Id: <20190909152842.1326-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20190909152842.1326-1-Quirin.Gylstorff@siemens.com>
References: <20190909152842.1326-1-Quirin.Gylstorff@siemens.com>
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

xeno-test is using killall(from package psmisc) and nc(from package netcat).
Add the packages as dependencies to the control file.

hackbench is also used, but as it is part of rt-tests it cannot be included.
rt-tests conflicts with xenomai-runtime due to [1].

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=529783

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 debian/control | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/debian/control b/debian/control
index 477b16d9f..2fda4e961 100644
--- a/debian/control
+++ b/debian/control
@@ -9,7 +9,7 @@ Homepage: http://www.xenomai.org/
 Package: xenomai-runtime
 Section: devel
 Architecture: amd64 arm armeb armel armhf arm64 i386 powerpc powerpcspe
-Depends: ${shlibs:Depends}, ${misc:Depends}
+Depends: ${shlibs:Depends}, ${misc:Depends}, psmisc, netcat
 Suggests: xenomai-kernel-source
 Replaces: xenomai
 Conflicts: xenomai
-- 
2.20.1


