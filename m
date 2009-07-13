Message-ID: <4A5B254B.4020505@domain.hid>
Date: Mon, 13 Jul 2009 14:15:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Subject: [Adeos-main] [PATCH 1/3] 2.6.30-noarch: Add generic mm_switch
	protection
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Add helpers around mm_switch and updates of current->[active_]mm so that
archs can implement the proper protections.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 fs/aio.c      |    5 ++++-
 fs/exec.c     |    3 +++
 kernel/fork.c |    3 +++
 3 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 76da125..21d717c 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -618,13 +618,16 @@ static void use_mm(struct mm_struct *mm)
 {
 	struct mm_struct *active_mm;
 	struct task_struct *tsk = current;
+	unsigned long flags;
 
 	task_lock(tsk);
 	active_mm = tsk->active_mm;
 	atomic_inc(&mm->mm_count);
 	tsk->mm = mm;
+	ipipe_mm_switch_protect(flags);
 	tsk->active_mm = mm;
-	switch_mm(active_mm, mm, tsk);
+	__switch_mm(active_mm, mm, tsk);
+	ipipe_mm_switch_unprotect(flags);
 	task_unlock(tsk);
 
 	mmdrop(active_mm);
diff --git a/fs/exec.c b/fs/exec.c
index 895823d..ec10cab 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -698,6 +698,7 @@ static int exec_mmap(struct mm_struct *mm)
 {
 	struct task_struct *tsk;
 	struct mm_struct * old_mm, *active_mm;
+	unsigned long flags;
 
 	/* Notify parent that we're no longer interested in the old VM */
 	tsk = current;
@@ -720,8 +721,10 @@ static int exec_mmap(struct mm_struct *mm)
 	task_lock(tsk);
 	active_mm = tsk->active_mm;
 	tsk->mm = mm;
+	ipipe_mm_switch_protect(flags);
 	tsk->active_mm = mm;
 	activate_mm(active_mm, mm);
+	ipipe_mm_switch_unprotect(flags);
 	task_unlock(tsk);
 	arch_pick_mmap_layout(mm);
 	if (old_mm) {
diff --git a/kernel/fork.c b/kernel/fork.c
index 0000b1a..899defb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1670,11 +1670,14 @@ SYSCALL_DEFINE1(unshare, unsigned long, unshare_flags)
 		}
 
 		if (new_mm) {
+			unsigned long flags;
 			mm = current->mm;
 			active_mm = current->active_mm;
 			current->mm = new_mm;
+			ipipe_mm_switch_protect(flags);
 			current->active_mm = new_mm;
 			activate_mm(active_mm, new_mm);
+			ipipe_mm_switch_unprotect(flags);
 			new_mm = mm;
 		}
 


