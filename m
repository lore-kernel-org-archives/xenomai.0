From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] debian: Add arm64 as target architecture
Message-ID: <ea1c6a1f-9982-9461-31d8-5af8b43c634b@siemens.com>
Date: Fri, 16 Nov 2018 07:27:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 debian/control | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/debian/control b/debian/control
index 3427987e15..477b16d9fd 100644
--- a/debian/control
+++ b/debian/control
@@ -8,7 +8,7 @@ Homepage: http://www.xenomai.org/
 
 Package: xenomai-runtime
 Section: devel
-Architecture: amd64 arm armeb armel armhf i386 powerpc powerpcspe
+Architecture: amd64 arm armeb armel armhf arm64 i386 powerpc powerpcspe
 Depends: ${shlibs:Depends}, ${misc:Depends}
 Suggests: xenomai-kernel-source
 Replaces: xenomai
@@ -45,7 +45,7 @@ Description: Source for Xenomai kernel-space support
 
 Package: libxenomai1
 Section: libs
-Architecture: amd64 arm armeb armel armhf i386 powerpc powerpcspe
+Architecture: amd64 arm armeb armel armhf arm64 i386 powerpc powerpcspe
 Depends: ${shlibs:Depends}, ${misc:Depends}
 Suggests: xenomai-kernel-source
 Replaces: xenomai
@@ -61,7 +61,7 @@ Description: Shared libraries for Xenomai
 
 Package: libxenomai-dev
 Section: libdevel
-Architecture: amd64 arm armeb armel armhf i386 powerpc powerpcspe
+Architecture: amd64 arm armeb armel armhf arm64 i386 powerpc powerpcspe
 Depends: libxenomai1 (= ${binary:Version}), ${misc:Depends}
 Suggests: xenomai-kernel-source
 Replaces: xenomai
-- 
2.16.4

