From: Paul <paul_c@domain.hid>
Date: Sun, 2 Dec 2007 13:03:27 +0000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_f0qUHkqr1ywH1j8"
Message-Id: <200712021303.27815.paul_c@domain.hid>
Subject: [Xenomai-core] [PATCH] trivial native mutex doc tweak.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--Boundary-00=_f0qUHkqr1ywH1j8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Attached, trivial patch for native rt_mutex_acquire function documentation. 
The reference to deprecated (and undocumented) rt_mutex_lock() & 
rt_mutex_release() is a little confusing.

 Also updated the code snippets to match.


Regards, Paul.



--Boundary-00=_f0qUHkqr1ywH1j8
Content-Type: text/x-diff;
  charset="us-ascii";
  name="native-mutex-doc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="native-mutex-doc.diff"

Index: ksrc/skins/native/mutex.c
===================================================================
--- ksrc/skins/native/mutex.c	(revision 3229)
+++ ksrc/skins/native/mutex.c	(working copy)
@@ -297,7 +297,7 @@ int rt_mutex_delete(RT_MUTEX *mutex)
  * recursive and implement the priority inheritance protocol.
  *
  * Since a nested locking count is maintained for the current owner,
- * rt_mutex_lock() and rt_mutex_unlock() must be used in pairs.
+ * rt_mutex_acquire() and rt_mutex_release() must be used in pairs.
  *
  * Tasks pend on mutexes by priority order.
  *
Index: ksrc/skins/native/snippets/mutex.c
===================================================================
--- ksrc/skins/native/snippets/mutex.c	(revision 3229)
+++ ksrc/skins/native/snippets/mutex.c	(working copy)
@@ -17,11 +17,11 @@ int main (int argc, char *argv[])
     /* Now, grab the mutex lock, run the critical section, then
        release the lock: */
 
-    rt_mutex_lock(&mutex_desc,TM_INFINITE);
+    rt_mutex_acquire(&mutex_desc,TM_INFINITE);
 
     /* ... Critical section ... */
     
-    rt_mutex_unlock(&mutex_desc);
+    rt_mutex_release(&mutex_desc);
 
     /* ... */
 }
Index: ksrc/skins/native/snippets/cond_var.c
===================================================================
--- ksrc/skins/native/snippets/cond_var.c	(revision 3229)
+++ ksrc/skins/native/snippets/cond_var.c	(working copy)
@@ -21,12 +21,12 @@ void foo (void)
 
     /* Now, wait for some task to post the shared event... */
 
-    rt_mutex_lock(&mutex_desc,TM_INFINITE);
+    rt_mutex_acquire(&mutex_desc,TM_INFINITE);
 
     while (!shared_event && !err)
 	err = rt_cond_wait(&cond_desc,&mutex_desc,TM_INFINITE);
     
-    rt_mutex_unlock(&mutex_desc);
+    rt_mutex_release(&mutex_desc);
 
     /* ... */
 }
@@ -38,12 +38,12 @@ void bar (void)
 
     /* Post the shared event. */
 
-    rt_mutex_lock(&mutex_desc,TM_INFINITE);
+    rt_mutex_acquire(&mutex_desc,TM_INFINITE);
 
     shared_event = 1;
     rt_cond_signal(&cond_desc);
 
-    rt_mutex_unlock(&mutex_desc);
+    rt_mutex_release(&mutex_desc);
 
     /* ... */
 }

--Boundary-00=_f0qUHkqr1ywH1j8--

