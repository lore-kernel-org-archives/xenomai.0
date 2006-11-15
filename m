Message-ID: <455B8016.2020605@domain.hid>
Date: Wed, 15 Nov 2006 22:01:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Kernel crash during queue create/destroy
References: <200611151121.51836.s.zimmermann@domain.hid>	<b647ffbd0611150519w1a510582n40782bdccaa7562d@domain.hid>
	<200611151544.00429.s.zimmermann@domain.hid>
In-Reply-To: <200611151544.00429.s.zimmermann@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF267B95F88EF88FFC03B05AD"
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
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF267B95F88EF88FFC03B05AD
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: quoted-printable

Stephan Zimmermann wrote:
> Am Mittwoch, 15. November 2006 14:19 schrieb Dmitry Adamushko:
>> Hello,
>>
>> I got some trouble with the native skin and queues, when creating /
>> deleting
>>
>>> queues, my Kernel sometimes (actually very often...) crashes, leading=
 to
>>> a frozen system, with my Xenomai program continuing until it returns.=
 I
>>> tried
>>> to isolate / reproduce the problem, which lead me to the following
>>> demo-code.
>> it looks like there is some "misunderstanding" between
>>
>> (1) rt_queue_delete() -> xnregistry_remove()
>>
>> and
>>
>> (2) registry_proc_callback() which crushes in remove_proc_entry().
>>
>> You may follow the logic in ksrc/nucleus/registry.c.
>>
>> rt_queue_create() -> xnregistry_enter() -> ... -> registry_proc_callba=
ck()
>>
>> rt_queue_delete() -> xnregistry_remove() -> ... registry_proc_unexport=
()
>>
>> I don't have enough time to investigate further right now, but
>> nevertheless, could you apply the following patch and let us know of t=
he
>> outcome?
>=20
> Thanks for your fast response. I just applied (and recompiled everythin=
g...)=20
> the patch you attached to your last Post. It doesn't seem to change  an=
ything=20
> for me. I attached the entries from syslog the test produced.
>=20

/me unfortunately failed to reproduce your problem here. Instead, I
found a regression in SVN head - different story for a different thread.

I have another debugging suggestion:

Enable CONFIG_IPIPE_TRACE_MCOUNT (under Kernel Hacking) and patch the
kernel as follows:

--- arch/i386/mm/fault.c.orig
+++ arch/i386/mm/fault.c
@@ -515,6 +515,8 @@ no_context:

 	bust_spinlocks(1);

+	ipipe_trace_freeze(0);
+
 	if (oops_may_print()) {
 	#ifdef CONFIG_X86_PAE
 		if (error_code & 16) {

Then recompile it and let your test run. After (and if...) it crashed,
you should look at /proc/ipipe/trace/frozen. This will contain a
back-trace around the crash. Tune the output via, e.g.,

	echo 1000 > /proc/ipipe/trace/back_trace_points
	(see also our wiki on more information about the tracer)

so that at least the path from the previous rt_queue_create up to the
crash is visible. This will give a call history (not just a stack
back-trace), as the tracer records all function calls in the kernel. May
help us to understand if we hit an unexpected function schedule here. It
all sounds like some rare race to me. I hope the trace will not make it
vanish...

Jan


--------------enigF267B95F88EF88FFC03B05AD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFW4AWniDOoMHTA+kRAjoRAJ4hDiJK3RET1P+bTb6MMc2mL5l7oACfVfcA
a6gd027bLwometfq84PDvYg=
=CJHj
-----END PGP SIGNATURE-----

--------------enigF267B95F88EF88FFC03B05AD--

