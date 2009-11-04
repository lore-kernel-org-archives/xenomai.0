Message-ID: <4AF1474C.7000701@domain.hid>
Date: Wed, 04 Nov 2009 10:20:12 +0100
From: Alexandre Coffignal <alexandre.coffignal@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090506060407060002010607"
Subject: [Xenomai-help] How to fix t_delete call in psos skin?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------090506060407060002010607
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I'm trying to use t_delete routine in psos skin (xenomai-2.4.7) from a=20
user space application .
I'm encountring two different behaviors:
-1- Calling t_delete(0) from a psos task seems to work perfectly (e.g.=20
task self deletes).
-2- Calling t_delete(task_id) with another task id (e.g. current task=20
tries to delete another task) doesn't result in task deletion but=20
returns 0 (success).

I've been through both psos skin (ksrc/psos+/task.c) and nucleus=20
(ksrc/nucleus/pod.c) source code.

xnpod_delete_thread() behaves differently depending on previously=20
described t_delete calls:

-1- First case (t_delete(0)):

Execution skip condition in ksrc/nucleus/pod.c at line 1173:

  if (xnthread_user_task(thread) !=3D NULL &&
      !xnthread_test_state(thread, XNDORMANT) &&
      !xnpod_current_p(thread)) {
      if (!xnpod_userspace_p())
          xnshadow_send_sig(thread, SIGKILL, 1);
      /*
       * Otherwise, assume the interface library has issued
       * pthread_cancel on the target thread, which should
       * cause the current service to be called for
       * self-deletion of that thread.
       */
      goto unlock_and_exit;
  }
#endif /* CONFIG_XENO_OPT_PERVASIVE */

and continues to run after it. This results in a successful deletion.


-2- Second case:

Execution enters one of the first conditions (if=20
(xnthread_user_task(thread))...)  but skip the second one :=20
xnshadow_send_sig(thread, SIGKILL, 1) is not executed;
goto unlock_and_exit; instruction is then executed.
->Our thread is never deleted.

-3-
Modifing actual source code by commenting goto intruction or moving it=20
into second condition (if (!xnpod_userspace_p()) mentioned above)=20
results in a working t_delete (task_id).

- I'm not sure of the possible side effects of such a modification?
- Is it correct to do so?


As mentioned in the source code comment, it is assumed "the interface=20
library has issued pthread_cancel" ...
I assume it might be missing somewhere?

Please can you help on this topic?

Thanks in advance.

Please find a patch regarding this modification.

diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 9348ce1..ee362df 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -1177,14 +1177,16 @@ void xnpod_delete_thread(xnthread_t *thread)
            !xnthread_test_state(thread, XNDORMANT) &&
            !xnpod_current_p(thread)) {
                if (!xnpod_userspace_p())
+               {
                        xnshadow_send_sig(thread, SIGKILL, 1);
+                       goto unlock_and_exit;
+               }
                /*
                 * Otherwise, assume the interface library has issued
                 * pthread_cancel on the target thread, which should
                 * cause the current service to be called for
                 * self-deletion of that thread.
                 */
-               goto unlock_and_exit;
        }
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
=20


Fabrice.


--------------------------------
C=E9noSYS <http://www.cenosys.com>
10, Rue Xavier Bichat
F-72000 Le MANS
--------------------------------



--------------090506060407060002010607
Content-Type: text/x-patch;
 name="pod.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pod.patch"

diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
index 9348ce1..ee362df 100644
--- a/ksrc/nucleus/pod.c
+++ b/ksrc/nucleus/pod.c
@@ -1177,14 +1177,16 @@ void xnpod_delete_thread(xnthread_t *thread)
 	    !xnthread_test_state(thread, XNDORMANT) &&
 	    !xnpod_current_p(thread)) {
 		if (!xnpod_userspace_p())
+		{
 			xnshadow_send_sig(thread, SIGKILL, 1);
+			goto unlock_and_exit;
+		}
 		/*
 		 * Otherwise, assume the interface library has issued
 		 * pthread_cancel on the target thread, which should
 		 * cause the current service to be called for
 		 * self-deletion of that thread.
 		 */
-		goto unlock_and_exit;
 	}
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 

--------------090506060407060002010607--

