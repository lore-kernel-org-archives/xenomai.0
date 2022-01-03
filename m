Message-ID: <b0ccf79e-3198-d9ba-28b5-3904c7f2cec0@siemens.com>
Date: Mon, 3 Jan 2022 19:51:58 +0100
MIME-Version: 1.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] cobalt/debug: Detect DSOs via presence of vm_file
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
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

From: Jan Kiszka <jan.kiszka@siemens.com>

VM_DENYWRITE was removed in 5.15, so we need a different criteria.
Presence of a file-backing seems to be a good one.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - fixed inverted logic
 - adjusted description

 kernel/cobalt/debug.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
index e8458855a6..cde0c17abe 100644
--- a/kernel/cobalt/debug.c
+++ b/kernel/cobalt/debug.c
@@ -250,13 +250,12 @@ void xndebug_trace_relax(int nr, unsigned long *backtrace,
 			continue;
 
 		/*
-		 * Hack. Unlike DSOs, executables and interpreters
-		 * (e.g. dynamic linkers) are protected against write
-		 * attempts. Use this to determine when $pc should be
-		 * fixed up by subtracting the mapping base address in
-		 * the DSO case.
+		 * Interpreter-generated executable mappings are not
+		 * file-backed. Use this to determine when $pc should be fixed
+		 * up by subtracting the mapping base address in the DSO case.
 		 */
-		if (!(vma->vm_flags & VM_DENYWRITE))
+		file = vma->vm_file;
+		if (file != NULL)
 			pc -= vma->vm_start;
 
 		spot.backtrace[depth].pc = pc;
@@ -266,7 +265,6 @@ void xndebug_trace_relax(int nr, unsigned long *backtrace,
 		 * record the PC value, which may still give some hint
 		 * downstream.
 		 */
-		file = vma->vm_file;
 		if (file == NULL)
 			goto next_frame;
 
-- 
2.31.1

