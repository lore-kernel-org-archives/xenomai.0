Message-ID: <4E80F2A0.9030500@domain.hid>
Date: Mon, 26 Sep 2011 23:46:08 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAAXf6LVErpVae0HVcqv4Rc6p2wnJLje7He2NJC7S1aCSVnD9NQ@mail.gmail.com>	<1316360236.2169.40.camel@domain.hid>	<8236197CA3DA864F9EF20609D9887263B4D0@domain.hid>	<CAMJ=MEeOS2K09fm0hnvSmxn6CBbMjHaC-uhDr03qNoZTaEbWVA@mail.gmail.com>
	<CAAXf6LX4gfVncvRo5UTyMrqWHhJ6K0ioksyTqvovAjpJyZWS3w@domain.hid>
In-Reply-To: <CAAXf6LX4gfVncvRo5UTyMrqWHhJ6K0ioksyTqvovAjpJyZWS3w@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] PSOS skin: mismatch in function signatures cause
 buffer overflow
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Cc: Xenomai-help@domain.hid, dietmar.schindler@domain.hid

On 09/19/2011 10:45 AM, Thomas De Schampheleire wrote:
> Hi,
> 
> On Mon, Sep 19, 2011 at 9:42 AM, Ronny Meeus <ronny.meeus@domain.hid> wrote:
>> On Mon, Sep 19, 2011 at 9:25 AM,  <dietmar.schindler@domain.hid> wrote:
>>>> From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid]
>>>> On Behalf Of Philippe Gerum
>>>> Sent: Sunday, September 18, 2011 5:37 PM
>>>> ...
>>>> Actually, we used to follow strictly the pSOS convention for this until
>>>> 2.4.x, at which point we moved to name strings precisely because
>>>> non-null terminated char[4] arrays would break the registry, the way you
>>>> described. This is one of the rare situations where mimicking a useless
>>>> limitation of the original API may be challenged by usability concerns
>>>> in the new environment, and usability won in that case. The problem
>>>> mostly comes from the fact that char[4] is automatically convertible to
>>>> const char *, so we have no warning/error leading us to check the
>>>> potentially problematic call sites.
>>>>
>>>> The concern about moving back to char[4] arrays - null-terminated if
>>>> shorter - is for people who currently assign strings longer than 4
>>>> characters to name their objects. What could be done, is providing a
>>>> build switch to select the accepted input, like
>>>> --disable-psos-long-names to turn on char[4] interpretation.
>>>
>>> While I would prefer the switch --enable-psos-long-names, this sounds okay to me, the more so as it is more than people who use the pSOS skin without obeying pSOS rules deserve.
>>> --
> [..]
>>>
>>
>> Another option would be to introduce a run-time switch.
>> The default behavior could be that long names are supported and if the
>> "enable_short_names()" function is called, all names will the cut at 4
>> characters.
>> The advantage of this dynamic switch is that different applications
>> using the same library can use the mode they prefer.
> 
> I would also be in favor of a runtime setting, rather than a
> compile-time one. One cannot assume that all PSOS applications on a
> system follow the same rules, or that there cannot be a mix of
> 'legacy' PSOS applications and 'xenomai-style' ones. According to me,
> a library should support all these uses.

Hi,

here is a patch which truncates identifiers to four characters and 
terminates them by a '\0' character, in order to avoid the issues at 
the origin of this thread. The patch also adds a variable 
"psos_long_names", 0 by default, which may be set to a non-zero value 
to enable the old behaviour (assume the identifier strings may be 
longer than 4 characters and are already null terminated).

Could someone with the issue test it?

Thanks in advance.
Regards.

diff --git a/include/psos+/psos.h b/include/psos+/psos.h
index 32281bc..4a3921a 100644
--- a/include/psos+/psos.h
+++ b/include/psos+/psos.h
@@ -197,6 +197,8 @@ u_long t_restart(u_long tid,
 
 #include <psos+/syscall.h>
 
+extern unsigned psos_long_names;
+
 #endif /* __KERNEL__ || __XENO_SIM__ */
 
 /*
diff --git a/src/skins/psos+/init.c b/src/skins/psos+/init.c
index 978a4f1..e53967b 100644
--- a/src/skins/psos+/init.c
+++ b/src/skins/psos+/init.c
@@ -26,6 +26,8 @@ int __psos_muxid = -1;
 
 xnsysinfo_t __psos_sysinfo;
 
+unsigned psos_long_names;
+
 static __attribute__ ((constructor))
 void __init_xeno_interface(void)
 {
@@ -68,3 +70,14 @@ void k_fatal(u_long err_code, u_long flags)
 {
 	exit(1);
 }
+
+const char *__psos_maybe_short_name(char shrt[5], const char *lng)
+{
+	if (psos_long_names)
+		return lng;
+
+	strncpy(shrt, lng, sizeof(shrt) - 1);
+	shrt[4] = '\0';
+
+	return (const char *)shrt;
+}
diff --git a/src/skins/psos+/queue.c b/src/skins/psos+/queue.c
index c54f966..c8c1933 100644
--- a/src/skins/psos+/queue.c
+++ b/src/skins/psos+/queue.c
@@ -17,11 +17,14 @@
  */
 
 #include <psos+/psos.h>
+#include <psos+/long_names.h>
 
 extern int __psos_muxid;
 
 u_long q_create(const char *name, u_long maxnum, u_long flags, u_long *qid_r)
 {
+	char short_name[5];
+	name = __psos_maybe_short_name(short_name, name);
 	return XENOMAI_SKINCALL4(__psos_muxid, __psos_q_create,
 				 name, maxnum, flags, qid_r);
 }
diff --git a/src/skins/psos+/rn.c b/src/skins/psos+/rn.c
index f254e37..2219f36 100644
--- a/src/skins/psos+/rn.c
+++ b/src/skins/psos+/rn.c
@@ -24,6 +24,7 @@
 #include <stdio.h>
 #include <nucleus/heap.h>
 #include <psos+/psos.h>
+#include <psos+/long_names.h>
 
 extern int __psos_muxid;
 
@@ -59,6 +60,7 @@ u_long rn_create(const char name[4],
 		 u_long usize, u_long flags, u_long *rnid, u_long *allocsz)
 {
 	struct rninfo rninfo;
+	char short_name[5];
 	struct {
 		u_long rnsize;
 		u_long usize;
@@ -66,6 +68,8 @@ u_long rn_create(const char name[4],
 	} sizeopt;
 	u_long err;
 
+	name = __psos_maybe_short_name(short_name, name);
+
 	if (rnaddr)
 		fprintf(stderr,
 			"rn_create() - rnaddr parameter ignored from user-space context\n");
diff --git a/src/skins/psos+/sem.c b/src/skins/psos+/sem.c
index 5020274..2bea943 100644
--- a/src/skins/psos+/sem.c
+++ b/src/skins/psos+/sem.c
@@ -17,11 +17,14 @@
  */
 
 #include <psos+/psos.h>
+#include <psos+/long_names.h>
 
 extern int __psos_muxid;
 
 u_long sm_create(const char name[4], u_long icount, u_long flags, u_long *smid_r)
 {
+	char short_name[5];
+	name = __psos_maybe_short_name(short_name, name);
 	return XENOMAI_SKINCALL4(__psos_muxid, __psos_sm_create,
 				 name, icount, flags, smid_r);
 }
diff --git a/src/skins/psos+/task.c b/src/skins/psos+/task.c
index a43f7fb..ab04ed8 100644
--- a/src/skins/psos+/task.c
+++ b/src/skins/psos+/task.c
@@ -26,6 +26,7 @@
 #include <memory.h>
 #include <string.h>
 #include <psos+/psos.h>
+#include <psos+/long_names.h>
 #include <asm-generic/bits/sigshadow.h>
 #include <asm-generic/bits/current.h>
 #include <asm-generic/stack.h>
@@ -128,6 +129,9 @@ u_long t_create(const char *name,
 	int policy;
 	long err;
 
+	char short_name[5];
+	name = __psos_maybe_short_name(short_name, name);
+
 	/* Migrate this thread to the Linux domain since we are about
 	   to issue a series of regular kernel syscalls in order to
 	   create the new Linux thread, which in turn will be mapped


-- 
                                                                Gilles.

