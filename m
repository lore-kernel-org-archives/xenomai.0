Message-ID: <4919D065.3040304@domain.hid>
Date: Tue, 11 Nov 2008 19:35:17 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <491955B7.4080805@domain.hid>
In-Reply-To: <491955B7.4080805@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [BUG] boot failure with
	adeos-ipipe-2.6.27-x86-2.1-01.patch
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <smolorz@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

Sebastian Smolorz wrote:
> Hello Philippe,
> 
> here comes a more serious bug than the one from yesterday. When I try to
>  boot a system patched with the latest ipipe on a PIII the attached boot
> log will show up. config also attached.
>

This bug affects all UP configurations that do not enable any spinlock debugging
option. Fixed in 2.6.27-x86-2.1-02. Given the severity of this bug, 2.4.6.1 is
due soon, with the fixed patch.

http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.27-x86-2.1-02.patch

Thanks,

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index daa90f8..2044388 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -255,6 +255,14 @@ do {									\
 		flags = _spin_lock_irqsave((spinlock_t *)(lock));	\
 	else __bad_spinlock_type();					\
 } while (0)
+#define PICK_SPINLOCK_IRQSAVE_NESTED(lock, flags, subclass)		\
+do {									\
+	if (TYPE_EQUAL((lock), __ipipe_spinlock_t)) {			\
+		(flags) = __ipipe_spin_lock_irqsave(&((__ipipe_spinlock_t
*)(lock))->__raw_lock); \
+	} else if (TYPE_EQUAL(lock, spinlock_t))			\
+		flags = _spin_lock_irqsave_nested((spinlock_t *)(lock), subclass); \
+	else __bad_spinlock_type();					\
+} while (0)
 #else
 #define PICK_SPINLOCK_IRQSAVE(lock, flags)				\
 do {									\
@@ -312,13 +320,13 @@ do {									\
 #define spin_lock_irqsave_nested(lock, flags, subclass)			\
 	do {								\
 		typecheck(unsigned long, flags);			\
-		flags = _spin_lock_irqsave_nested(lock, subclass);	\
+		PICK_SPINLOCK_IRQSAVE_NESTED(lock, flags, subclass);	\
 	} while (0)
 #else
 #define spin_lock_irqsave_nested(lock, flags, subclass)			\
 	do {								\
 		typecheck(unsigned long, flags);			\
-		flags = _spin_lock_irqsave(lock);			\
+		PICK_SPINLOCK_IRQSAVE(lock, flags);			\
 	} while (0)
 #endif

@@ -327,7 +335,7 @@ do {									\
 #define spin_lock_irqsave(lock, flags)			\
 	do {						\
 		typecheck(unsigned long, flags);	\
-		_spin_lock_irqsave(lock, flags);	\
+		PICK_SPINLOCK_IRQSAVE(lock, flags);	\
 	} while (0)
 #define read_lock_irqsave(lock, flags)			\
 	do {						\


-- 
Philippe.

