Message-ID: <457977E7.40606@domain.hid>
Date: Fri, 08 Dec 2006 15:34:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] I/O privilege losted and killed message
References: <s577092a.032@domain.hid> <457820AF.4070403@domain.hid>
In-Reply-To: <457820AF.4070403@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig37140DE4CAC9E7A8C34B59B0"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nicolas BLANCHARD <n.blanchard@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig37140DE4CAC9E7A8C34B59B0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Nicolas BLANCHARD wrote:
>> Hello,
>>
>> Sometime i lose my i/o privilege put with the system call ioperm (in
>> the main function of my program).
>>
>> My application stop with a "killed" message in the console and  in
>> /proc/xenomai/fault i've an "general fault".
>> To ignore this problem, i use the call system iopl (with full
>> privilege) or recall ioperm before each inb or outb.
>> But there is a problem, why i/o privilege are losted ?
>>
>> In attachment you can find an archive with an example (application and=

>> source) witch show the problem.
>> This program has 2 task :
>> - task_1 priority 23 period 100 ms, lock a mutex, access to /dev/rtc,
>> unlock the mutex, outb on hardware.
>> - task 2 priority 25 period 1 ms, do nothing !
>>
>> I put a 1 ms period to task_2 because it's near the speedest period on=

>> my cpu (166 MHz).
>> With this period it stop immediatly.
>> If i put 10 ms it's need 1 or 2 minutes.
>>
>> On my Pentium 4 (Ubuntu on VmWare worstation under WindowsXP), i put 3=
0
>> ms (the more speed before overrun).
>>
>> If i use iopl (and not ioperm), no problem.
>> If i just have task_1, no problem.
>> If i don't use mutex (lock for Rtc access) on task_2, no problem.
>>
>> I use Xenomai Xenomai 2.3-rc2 (adeos 1.5-02), same probleme with
>> 2.2.3.
>>
>> If you have an idea.
>=20
> No idea yet and no time to dig out the reason. But I can confirm the
> sporadic lost of ioperms of a Xenomai task that enters secondary mode
> (QEMU UP with CONFIG_XENO_OPT_RPIDISABLE and CONFIG_PREEMPT_NONE).
>=20

This should be the explanation for this effect:

A shadow thread with an I/O-permission map enters secondary mode and
gets switched away. A Linux process without such a map happens to become
active. Later Linux switches the relaxed shadow in again, but due to
lazy permission map restoring, the previous map without any permission
remains active. Now we harden the thread again, but this special path
doesn't take us along wrap_switch_iobitmap() in xnarch_switch_to().
Therefore the next I/O access causes a fault.

This ugly hack made the test case succeed for me:

--- ../../ksrc/nucleus/shadow.c (revision 1930)
+++ ../../ksrc/nucleus/shadow.c (working copy)
@@ -648,6 +648,8 @@ int xnshadow_harden(void)
 	xnpod_switch_fpu(xnpod_current_sched());
 #endif /* CONFIG_XENO_HW_FPU */

+	wrap_switch_iobitmap(current, rthal_processor_id());
+
 	if (xnthread_signaled_p(thread))
 		xnpod_dispatch_signals();


This hack is lacking IRQ protection, and it must be put in some
xnarch_switch_iobitmap abstraction as this affair is x86-only. Philippe,
do you agree and would you accept such an approach?

Jan



--------------enig37140DE4CAC9E7A8C34B59B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFeXfnncNeS9Q0k+IRAplPAJ9dd7xldzvSxOdjbxVJ9wBiWE6siwCeN+Zy
arngksIcyI2PmJZZkNH5sgc=
=LN1s
-----END PGP SIGNATURE-----

--------------enig37140DE4CAC9E7A8C34B59B0--

