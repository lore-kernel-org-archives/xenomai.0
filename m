From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4AEA590E.9070701@domain.hid>
References: <4AEA590E.9070701@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Nov 2009 22:13:01 +0100
Message-ID: <1257455581.2210.205.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] unable to load nucleus module: unknown symbol
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jweber@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2009-10-29 at 22:10 -0500, Jeff Weber wrote:
> I've built the xeno_nucleus as a module.  Neither depmod, nor modprobe
> can resolve the symbol "find_task_by_pid_ns":
>=20
> depmod:
> WARNING:
> /lib/modules/2.6.31.5-xenomai-2.4.10/kernel/kernel/xenomai/nucleus/xeno=
_nucleus.ko
> needs unknown symbol find_task_by_pid_ns
>=20
> modprobe [dmesg]:
> [  426.728630] xeno_nucleus: Unknown symbol find_task_by_pid_ns
>=20
> Curiously, this symbol is in both my build System.map, and the kernel
>=20
> bash # grep find_task_by_pid_ns System.map
> c102ecf6 T find_task_by_pid_ns
>=20
> bash # cat /proc/kallsyms | grep find_task_by_pid_ns
> c102ecf6 T find_task_by_pid_ns
>=20
> so this symbol should be publicly available.  I also noticed there is n=
o
> EXPORT_SYMBOL() for find_task_by_pid_ns in the kernel code.
>=20
> Any ideas what's keeping my xeno_nucleus.ko module from loading?
>=20
> My config:
> linux-2.6.31.5 (current stable)
> xenomai-2.4.10
> adeos-ipipe-2.6.31.1-x86-2.4-06.patch

Please note that 2.6.31 is not officially supported by 2.4.x; at least,
not for all architectures. 2.5.x supports 2.6.31 and beyond.

Aside of this, the missing symbol is no more exported by 2.6.31 albeit
it used to be in 2.6.30. I guess that most people compile the nucleus
statically inside the kernel, so this has not been noticed before.

diff --git a/include/asm-generic/wrappers.h b/include/asm-generic/wrapper=
s.h
index 18af70b..62f1d6e 100644
--- a/include/asm-generic/wrappers.h
+++ b/include/asm-generic/wrappers.h
@@ -480,8 +480,16 @@ unsigned long find_next_bit(const unsigned long *add=
r,
 #include <linux/semaphore.h>
 #include <linux/pid.h>
=20
-#define find_task_by_pid(nr)		\
-  find_task_by_pid_ns(nr, &init_pid_ns)
+#if LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,6,31)
+static inline struct task_struct *wrap_find_task_by_pid(pid_t nr)
+{
+	return pid_task(find_pid_ns(nr, &init_pid_ns), PIDTYPE_PID);
+}
+#else /* LINUX_VERSION_CODE < 2.6.31 */
+#define wrap_find_task_by_pid(nr)	\
+	find_task_by_pid_ns(nr, &init_pid_ns)
+#endif /* LINUX_VERSION_CODE < 2.6.31 */
+
 #define kill_proc(pid, sig, priv)	\
   kill_proc_info(sig, (priv) ? SEND_SIG_PRIV : SEND_SIG_NOINFO, pid)
=20
diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index d6d1203..1eae0a1 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -1687,7 +1687,7 @@ void xnshadow_signal_completion(xncompletion_t __us=
er *u_completion, int err)
=20
 	read_lock(&tasklist_lock);
=20
-	p =3D find_task_by_pid(completion.pid);
+	p =3D wrap_find_task_by_pid(completion.pid);
=20
 	if (p)
 		wake_up_process(p);

>=20
> thanks,
> Jeff
> =C2=93This e-mail message and any attachments are confidential and may =
be privileged.=20
> If you are not the intended recipient please notify American Supercondu=
ctor Corporation=20
> immediately by replying to this message or by sending a message to post=
master@domain.hid
> and destroy all copies of this message and any attachments.=20
> Thank you.=C2=94
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20
Philippe.



