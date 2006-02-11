Message-ID: <43EDDF9E.4030309@domain.hid>
Date: Sat, 11 Feb 2006 13:59:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <43ECD570.5000704@domain.hid>
	<b647ffbd0602110331i400d7ff5k@domain.hid>
In-Reply-To: <b647ffbd0602110331i400d7ff5k@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig528DF61C7B1E64B061C3B062"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [shirq] first test results
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig528DF61C7B1E64B061C3B062
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> Hi Jan,
>=20
>> some news from the testing front: It works fairly well - and it doesn'=
t
>> crash =3D:).
>=20
> Good news indeed :)
>=20
>> We set up a quite demanding test scenario which consists of
>> two Sick Laser scanners feeding two UART ports at 500 Kbit/s. The UART=
s
>> are on a special PC104 card, sharing the same edge-triggered IRQ line.=

>> We were able to get data from both devices running at the same time. B=
ut
>> we noticed some overruns of MAX_EDGEIRQ_COUNTER (a few per second). Th=
e
>> next step on Monday will be to generate a back-trace with the
>> ipipe-tracer to see if the system is "just" overloaded or if we are
>> still facing problems with the driver and/or IRQ layer. Will be very
>> interesting to see on that radar what's happing.
>=20
> Yes.
>=20
> And as an additional option,
> it could be interesting to print out to the log if not all "counter" va=
lues
> then min,max,average (the same like for the latency :) per second or pe=
r
> 1000 interrupts; so to see whether tweaking the MAX_EDGEIRQ_COUNTER may=
 make
> the things better.

Yes, maybe it's too small. But this also depends on the absolute time
required for so many loops, something we should see in the traces then.
I'm afraid that we will finally have to move the UART's read-from-fifo
to task context to reduce the time spent in IRQ context.

>=20
>=20
>> I attached two patches. One enables xeno_16550A to use the new feature=
s,
>> and the other improves the /proc output of your patch slightly.
>>
>> Furthermore, we noticed that virtual IRQs (namely the printk forwarder=
)
>> get displayed under /proc/xenomai/irq too. Is this useful? We wondered=

>> what IRQ 34 might be until code analysis of Xenomai and Ipipe revealed=

>> it (__ipipe_printk_virq). If it is considered useful, we should at lea=
st
>> mark those irqs virtual in the output or even give them names as well.=

>=20
> It's a virq but it can not be __ipipe_printk_virq :)
> The latter one is registered in the linux domain while we are
> printing out the irqs of the primary one in /proc/xenomai/irq.
>=20
> It should be xnarch_escalation_virq.
>=20
> Probably, BASE_VIRQ =3D=3D 32 (if NR_IRQS =3D=3D 16).
>=20
> So,
>=20
> 32 -    __ipipe_printk_virq (Linux domain)
> 33 -    rthal_apc_virq (Linux domain)
> 34 -    xnarch_escalation_virq (Xeno domain)

Ok, I stopped digging deeper after noticing the first VIRQ being
registered to the dumped IRQ list.

>=20
> They are ordered (that's why they have such irq numbers) as
> ipipe_alloc_virq()
> is called for them.
>=20
> That can be confirmed by :
>=20
> # cat /proc/ipipe/Xenomai
>=20
> ...
> irq 32-33: passed, virtual
> irq 34: grabbed, virtual    <--- 1 virq is in the primary domain
> ...
>=20
> # cat /proc/ipipe/Linux
>=20
> irq 32-33: grabbed, virtual    <--- 2 virqs are in the linux domain
> irq 34: passed, virtual

Oh, yes. The information was so close and yet I didn't see it. :)

>=20
>=20
> Yep, the output is confusing. At least, we may :
>=20
> 1) add "virq" or "virtual" quilification, smth like 34 (virtual);
>=20
> 2) not print them out at all.
>=20
> Maybe we'd better go for 1, just in case somebody would like to know
> the actual number of virq occuried. Although, I can imagine that only
> for debugging reasons and of no avail for the normal users, so maybe 2 =
:)

I have no final opinion yet. Having some names also behind the virtual
IRQs would be really nice for debugging, but it would also break another
bulk of API calls. Just marking those IRQs virtual would render the
related output of /proc/xenomai/irq not very useful in my eye - as long
as you do not know what's behind it. Just dropping this information is
then likely better.

>=20
>=20
>> Then I stumbled over the xnintr structure. Why do you keep a copy of t=
he
>> device name?
>> A "const char *" should be enough, we just have to demand
>> that it will remain valid as long as the xnintr structure itself (i.e.=

>> during the IRQ being attached). Saves a few bytes. :)
>=20
> Could be if all the users of it are initially kernel-mode entities.
>=20
> But e.g. there is a version of rt_intr_create() that may be called by
> user-space
> apps and I extended it to support the "name" parameter too :
>=20
> int rt_intr_create(RT_INTR *intr, const char *name, unsigned irq, int m=
ode);
>=20
> In such a case, the kernel-side rt_intr_create() is called with the "na=
me"
> allocated on the stack in skins/native/syscall.c : __rt_intr_create())
> so the initial copy of the name can not remain valid.

But you could create buffer space for a copy of the name in the same
block already allocated for RT_INTR. Should be straightforward.

Moreover, but that's a different topic, I would vote for

config XENO_OPT_NATIVE_INTR
        default n

That feature is not needed when following the (preferred) RTDM path, and
is therefore only ballast to xeno_native on most systems. Guess I have
to prepare a patch...

Jan


--------------enig528DF61C7B1E64B061C3B062
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD7d+eniDOoMHTA+kRAuCIAJ40MfgnytJgZZV1H6U4oyqwxjBTVgCfTwIS
dhJxiebgMcAOOxE+7xTlvg4=
=Vc7E
-----END PGP SIGNATURE-----

--------------enig528DF61C7B1E64B061C3B062--

