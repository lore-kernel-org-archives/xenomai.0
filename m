Message-ID: <4811D596.8070109@domain.hid>
Date: Fri, 25 Apr 2008 14:59:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040508000908080202090902"
Subject: [Xenomai-core] [2.4.x PATCH] POSIX: Remove mutex/cond_init locking,
	fix NULL attribute
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This is a multi-part message in MIME format.
--------------040508000908080202090902
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

trunk check-in #3369 did not just remove some "questionable critical
sections", it also happen to fix two ugly bugs in the POSIX skin: The
user was not able to pass NULL attributes down to mutex_init and
cond_init. Find a backport of that patch for 2.4.x attached.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------040508000908080202090902
Content-Type: text/x-patch;
 name="cond-mutex-init-fix-NULL-attr-and-remove-critical-sections.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="cond-mutex-init-fix-NULL-attr-and-remove-critical-sections.p";
 filename*1="atch"

Index: xenomai-2.4.x/ksrc/skins/posix/syscall.c
===================================================================
--- xenomai-2.4.x/ksrc/skins/posix/syscall.c	(Revision 3722)
+++ xenomai-2.4.x/ksrc/skins/posix/syscall.c	(Arbeitskopie)
@@ -420,7 +420,6 @@ static int __sem_init(struct task_struct
 	union __xeno_sem sm, *usm;
 	unsigned value;
 	int pshared;
-	spl_t s;
 
 	usm = (union __xeno_sem *)__xn_reg_arg1(regs);
 
@@ -431,24 +430,18 @@ static int __sem_init(struct task_struct
 	pshared = (int)__xn_reg_arg2(regs);
 	value = (unsigned)__xn_reg_arg3(regs);
 
-	xnlock_get_irqsave(&nklock, s);
-	
 	__xn_copy_from_user(curr,
 			    &sm.shadow_sem,
 			    (void __user *)&usm->shadow_sem,
 			    sizeof(sm.shadow_sem));
 
-	if (sem_init(&sm.native_sem, pshared, value) == -1) {
-		xnlock_put_irqrestore(&nklock, s);
+	if (sem_init(&sm.native_sem, pshared, value) == -1)
 		return -thread_get_errno();
-	}
 
 	__xn_copy_to_user(curr,
 			  (void __user *)&usm->shadow_sem,
 			  &sm.shadow_sem, sizeof(usm->shadow_sem));
 
-	xnlock_put_irqrestore(&nklock, s);
-
 	return 0;
 }
 
@@ -1080,7 +1073,6 @@ static int __pthread_mutex_init(struct t
 {
 	pthread_mutexattr_t locattr, *attr, *uattrp;
 	union __xeno_mutex mx, *umx;
-	spl_t s;
 	int err;
 
 	umx = (union __xeno_mutex *)__xn_reg_arg1(regs);
@@ -1091,19 +1083,16 @@ static int __pthread_mutex_init(struct t
 	    (curr, VERIFY_WRITE, (void __user *)umx, sizeof(*umx)))
 		return -EFAULT;
 
-	if (!__xn_access_ok
-	    (curr, VERIFY_READ, (void __user *)uattrp, sizeof(*uattrp)))
-		return -EFAULT;
-
-	/* We want the initialization to be atomic. */
-	xnlock_get_irqsave(&nklock, s);
-
 	__xn_copy_from_user(curr,
 			    &mx.shadow_mutex,
 			    (void __user *)&umx->shadow_mutex,
 			    sizeof(mx.shadow_mutex));
 
 	if (uattrp) {
+		if (!__xn_access_ok
+		    (curr, VERIFY_READ, (void __user *)uattrp, sizeof(*uattrp)))
+			return -EFAULT;
+
 		__xn_copy_from_user(curr,
 				    &locattr,(void __user *)
 				    uattrp,
@@ -1115,17 +1104,13 @@ static int __pthread_mutex_init(struct t
 
 	err = pthread_mutex_init(&mx.native_mutex, attr);
 	
-	if (err) {
-		xnlock_put_irqrestore(&nklock, s);
+	if (err)
 		return -err;
-	}
 
 	__xn_copy_to_user(curr,
 			  (void __user *)&umx->shadow_mutex,
 			  &mx.shadow_mutex, sizeof(umx->shadow_mutex));
 
-	xnlock_put_irqrestore(&nklock, s);
-
 	return 0;
 }
 
@@ -1134,7 +1119,6 @@ static int __pthread_mutex_destroy(struc
 {
 	union __xeno_mutex mx, *umx;
 	int err;
-	spl_t s;
 
 	umx = (union __xeno_mutex *)__xn_reg_arg1(regs);
 
@@ -1142,8 +1126,6 @@ static int __pthread_mutex_destroy(struc
 	    (curr, VERIFY_READ, (void __user *)umx, sizeof(*umx)))
 		return -EFAULT;
 
-	xnlock_get_irqsave(&nklock, s);
-
 	__xn_copy_from_user(curr,
 			    &mx.shadow_mutex,
 			    (void __user *)&umx->shadow_mutex,
@@ -1151,17 +1133,13 @@ static int __pthread_mutex_destroy(struc
 
 	err = pthread_mutex_destroy(&mx.native_mutex);
 
-	if (err) {
-		xnlock_put_irqrestore(&nklock, s);
+	if (err)
 		return -err;
-	}
 	
 	__xn_copy_to_user(curr,
 			  (void __user *)&umx->shadow_mutex,
 			  &mx.shadow_mutex, sizeof(umx->shadow_mutex));
 
-	xnlock_put_irqrestore(&nklock, s);
-
 	return 0;
 }
 
@@ -1410,7 +1388,6 @@ static int __pthread_cond_init(struct ta
 {
 	pthread_condattr_t locattr, *attr, *uattrp;
 	union __xeno_cond cnd, *ucnd;
-	spl_t s;
 	int err;
 
 	ucnd = (union __xeno_cond *)__xn_reg_arg1(regs);
@@ -1421,19 +1398,16 @@ static int __pthread_cond_init(struct ta
 	    (curr, VERIFY_WRITE, (void __user *)ucnd, sizeof(*ucnd)))
 		return -EFAULT;
 
-	if (!__xn_access_ok
-	    (curr, VERIFY_READ, (void __user *)uattrp, sizeof(*uattrp)))
-		return -EFAULT;
-
-	/* We want the initialization to be atomic. */
-	xnlock_get_irqsave(&nklock, s);
-	
 	__xn_copy_from_user(curr,
 			    &cnd.shadow_cond,
 			    (void __user *)&ucnd->shadow_cond,
 			    sizeof(cnd.shadow_cond));
 
 	if (uattrp) {
+		if (!__xn_access_ok
+		    (curr, VERIFY_READ, (void __user *)uattrp, sizeof(*uattrp)))
+			return -EFAULT;
+
 		__xn_copy_from_user(curr,
 				    &locattr,
 				    (void __user *)uattrp,
@@ -1443,20 +1417,15 @@ static int __pthread_cond_init(struct ta
 	} else
 		attr = NULL;
 
-	/* Always use default attribute. */
 	err = pthread_cond_init(&cnd.native_cond, attr);
 
-	if (err) {
-		xnlock_put_irqrestore(&nklock, s);
+	if (err)
 		return -err;
-	}
 
 	__xn_copy_to_user(curr,
 			  (void __user *)&ucnd->shadow_cond,
 			  &cnd.shadow_cond, sizeof(ucnd->shadow_cond));
 
-	xnlock_put_irqrestore(&nklock, s);
-
 	return 0;
 }
 
@@ -1465,7 +1434,6 @@ static int __pthread_cond_destroy(struct
 {
 	union __xeno_cond cnd, *ucnd;
 	int err;
-	spl_t s;
 
 	ucnd = (union __xeno_cond *)__xn_reg_arg1(regs);
 
@@ -1473,8 +1441,6 @@ static int __pthread_cond_destroy(struct
 	    (curr, VERIFY_READ, (void __user *)ucnd, sizeof(*ucnd)))
 		return -EFAULT;
 
-	xnlock_get_irqsave(&nklock, s);
-
 	__xn_copy_from_user(curr,
 			    &cnd.shadow_cond,
 			    (void __user *)&ucnd->shadow_cond,
@@ -1482,17 +1448,13 @@ static int __pthread_cond_destroy(struct
 
 	err = pthread_cond_destroy(&cnd.native_cond);
 
-	if (err) {
-		xnlock_put_irqrestore(&nklock, s);
+	if (err)
 		return -err;
-	}
 
 	__xn_copy_to_user(curr,
 			  (void __user *)&ucnd->shadow_cond,
 			  &cnd.shadow_cond, sizeof(ucnd->shadow_cond));
 
-	xnlock_put_irqrestore(&nklock, s);
-
 	return 0;
 }
 

--------------040508000908080202090902--

