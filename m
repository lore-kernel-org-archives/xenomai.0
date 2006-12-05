Message-ID: <4575A1E9.80105@domain.hid>
Date: Tue, 05 Dec 2006 17:44:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45704CAB.5060502@domain.hid> <1164992204.4952.109.camel@domain.hid>
In-Reply-To: <1164992204.4952.109.camel@domain.hid>
Content-Type: multipart/mixed; boundary="------------010403080200080801010808"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: libnative versioning
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------010403080200080801010808
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> On Fri, 2006-12-01 at 16:39 +0100, Jan Kiszka wrote:
>> Hi,
>>
>> we just had some fun here with incompatible native libraries. A program
>> was built against some 2.2 release and was then started on a target with
>> 2.3 libs installed. The result: undefined symbol rt_mutex_lock. The
>> reason: this function was renamed to rt_mutex_acquire in trunk to
>> resolve a naming conflict in recent kernels.
>>
>> So we now have incompatible libraries and should either increment some
>> version number of libnative or export the necessary aliases for
>> lock/unlock. What is preferred?
> 
> The Xenomai ABI has been kept compatible between versions, so we want to
> provide the proper aliases for user-space; the conflict is kernel-space
> only, and there is no reason to ask user-space apps to conform to some
> obscure change that took place within the vanilla kernel API. Actually,
> I already wrappers in include/native/mutex.h, but unfortunately as
> macros, so dynamic binding could not work. I'm fixing this. Thanks.

And this fixes the fix (/wrt C++ users).

Jan

--------------010403080200080801010808
Content-Type: text/plain;
 name="fix-mutex-c++.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-mutex-c++.patch"

Index: include/native/mutex.h
===================================================================
--- include/native/mutex.h	(revision 1920)
+++ include/native/mutex.h	(working copy)
@@ -121,10 +121,6 @@ int rt_mutex_release(RT_MUTEX *mutex);
 int rt_mutex_inquire(RT_MUTEX *mutex,
 		     RT_MUTEX_INFO *info);
 
-#ifdef __cplusplus
-}
-#endif
-
 #ifdef __KERNEL__
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18)
 static inline int __deprecated_call__ rt_mutex_lock(RT_MUTEX *mutex, RTIME timeout)
@@ -146,4 +142,8 @@ int rt_mutex_unlock(RT_MUTEX *mutex);
 
 #endif /* __KERNEL__ */
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif /* !_XENO_MUTEX_H */

--------------010403080200080801010808--

