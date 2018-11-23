From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 3/3] Improve README, add COPYING
Date: Fri, 23 Nov 2018 14:54:30 +0100
Message-Id: <c7b7c2682cae5e17860049e79727291ce7c38fdb.1542981269.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1542981269.git.jan.kiszka@siemens.com>
References: <cover.1542981269.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1542981269.git.jan.kiszka@siemens.com>
References: <cover.1542981269.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Refer to Xenomai upstream for community and contribution. Add a
top-level COPYING with the MIT license and explain the licensing scheme
also in the README.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 COPYING   | 17 +++++++++++++++++
 README.md | 21 +++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)
 create mode 100644 COPYING

diff --git a/COPYING b/COPYING
new file mode 100644
index 0000000..89de354
--- /dev/null
+++ b/COPYING
@@ -0,0 +1,17 @@
+Permission is hereby granted, free of charge, to any person obtaining a copy
+of this software and associated documentation files (the "Software"), to deal
+in the Software without restriction, including without limitation the rights
+to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+copies of the Software, and to permit persons to whom the Software is
+furnished to do so, subject to the following conditions:
+
+The above copyright notice and this permission notice shall be included in
+all copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+THE SOFTWARE.
diff --git a/README.md b/README.md
index ae07de9..44d056d 100644
--- a/README.md
+++ b/README.md
@@ -1,8 +1,9 @@
 # Xenomai Demonstration and Test Images
 
 This generates a number of bootable image for virtual and real targets in order
-to run the Xenomai real-time system, for evaluation or testing purposes. The
-layer may also be used to build real applications on top.
+to run the [Xenomai](https://www.xenomai.org) real-time system, for evaluation
+or testing purposes. The layer may also be used to build real applications on
+top.
 
 The build system used for this is [Isar](https://github.com/ilbers/isar), an
 image generator that assembles Debian binaries or builds individual packages
@@ -34,3 +35,19 @@ Physical targets will generate read-to-boot images under
 
     dd if=build/tmp/deploy/images/ebsy-image-base-long-life-ebsy-simatic-ipc227e.wic.img \
        of=/dev/<medium-device> bs=1M status=progress
+
+## Community Resources
+
+See [Xenomai project](https://www.xenomai.org/).
+
+Contributions are always welcome. They follow the same
+[process](https://gitlab.denx.de/Xenomai/xenomai/blob/master/CONTRIBUTING.md)
+that Xenomai is using as well. Please tag you patches additional with
+"[xenomai-images]" to indicate which repository they are targeting.
+
+## License
+
+Unless otherwise stated in the respective file, files in this layer are
+provided under the MIT license, see COPYING file. Patches (files ending with
+.patch) are licensed according to their target project and file, typically
+GPLv2.
-- 
2.16.4


