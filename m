Message-ID: <44CB4A1D.1090109@domain.hid>
Date: Sat, 29 Jul 2006 13:44:29 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] cpu_set_t and friends undefined
References: <44CB312E.8090409@domain.hid> <44CB3685.6090006@domain.hid>
In-Reply-To: <44CB3685.6090006@domain.hid>
Content-Type: multipart/mixed; boundary="------------040006020902010401060409"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------040006020902010401060409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Hello,
>>
>> with todays SVN version of Xenomai, the testsuite program
>> switchtest/switch.c does not compile because cpu_set_t and friends
>> (CPU_SET, ...) are not undefined. I'm using kernel version 2.4.25.
>>
>> Any idea what goes wrong. I haven't found where cpu_set_t is declared,
>> not even in Linux 2.4.17.7.
> 
> That's user-space stuff, in /usr/include/bits/sched.h on my box. Maybe
> some #ifndef __cpu_set_t_defined + local definition is required here.
> What glibc version do you use?

Ah, OK. The problem is with gcc version 3.3.3 (DENX ELDK 3.1.1 3.3.3-9),
which does not have cpu_set_t, indeed. The configure script already 
deals with different implementations of setaffinity. The attached patch 
fixes the problem. It removes CONFIG_SMP, which is not known to user 
space applications anyhow. Well, it might get defined in 
"src/include/xeno_config.h" somehow but I don't know how this could work 
properly without knowing the configured kernel tree.

Wolfgang,


--------------040006020902010401060409
Content-Type: text/x-patch;
 name="xenomai-switch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-switch.patch"

+ diff -u xenomai/src/testsuite/switchtest/switch.c.SMP xenomai/src/testsuite/switchtest/switch.c
--- xenomai/src/testsuite/switchtest/switch.c.SMP	2006-07-29 13:31:06.000000000 +0200
+++ xenomai/src/testsuite/switchtest/switch.c	2006-07-29 13:32:18.000000000 +0200
@@ -15,7 +15,6 @@
 #include <asm/xenomai/fptest.h>
 #include <rtdm/rttesting.h>
 
-#if CONFIG_SMP
 #ifdef HAVE_RECENT_SETAFFINITY
 #define smp_sched_setaffinity(pid,len,mask) sched_setaffinity(pid,len,mask)
 #else /* !HAVE_RECENT_SETAFFINITY */
@@ -28,9 +27,6 @@
 #define	 CPU_SET(n,set) 	do { *(set) |= (1 << n); } while(0)
 #endif /* HAVE_OLD_SETAFFINITY */
 #endif /* HAVE_RECENT_SETAFFINITY */
-#else /* !CONFIG_SMP */
-#define smp_sched_setaffinity(pid,len,mask) 0
-#endif /* !CONFIG_SMP */
 
 struct cpu_tasks;
 

--------------040006020902010401060409--

