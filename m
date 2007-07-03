Message-ID: <468A9EE0.8050409@domain.hid>
Date: Tue, 03 Jul 2007 21:09:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4687F466.2020901@domain.hid>	
	<b647ffbd0707020435oc733ee2m2facf281ee0c5cbb@domain.hid>	
	<4688E373.5020205@domain.hid>
	<b647ffbd0707030713x7eec10d2j5355e6257445f970@domain.hid>
	<468A60C8.4050203@domain.hid>
In-Reply-To: <468A60C8.4050203@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD4C5AA3F6341F74F880C2750"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH-STACK] Missing bits for -rc1
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
--------------enigD4C5AA3F6341F74F880C2750
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Dmitry Adamushko wrote:
>> On 02/07/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>> Dmitry Adamushko wrote:
>>>> On 01/07/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>>>> Hi all,
>>>>>
>>>>> I've just uploaded my rebased patch stack, including specifically t=
he
>>>>> last bits that should go in before -rc1,
>> a few comments:
>>
>> (1) in xnintr_irq_handler()
>>
>> +    xnlock_get(&xnirqs[irq].lock);
>> +
>> +#ifdef CONFIG_SMP
>> +    /* In SMP case, we have to reload the cookie under the per-IRQ lo=
ck
>> +       to avoid racing with xnintr_detach. */
>> +    intr =3D rthal_irq_cookie(&rthal_domain, irq);
>> +    if (unlikely(!intr)) {
>> +        s =3D 0;
>> +        goto unlock_and_exit;
>> +    }
>> +#else
>> +    intr =3D cookie;
>> +#endif
>>
>> I think, it would be better to check 'intr' for NULL at this point so
>> to cover 'cookie =3D=3D NULL' (who knows.. and it's better not to rely=
 on
>> the lower layer here), I guess.
>=20
> The lower layer just passes what we hand over - and when we do so. Keep=

> in mind: this is the non-SMP case, thus we can rely on the atomicity of=

> this handler like the one of registering a handler + its cookie (like w=
e
> always did -- unfortunately also for SMP...). For me, checking for NULL=

> on UP is redundant code in a hotpath. Should I spread some comment
> regarding this assumption?
>=20
>> (2) use cases of xnintr_sync_stat_references() in xnintr_irq_detach()
>>
>> +
>> +    xnlock_get(&xnirqs[irq].lock);
>> +
>> +    err =3D xnarch_release_irq(intr->irq);
>> +    xnintr_sync_stat_references(intr);
>> +    xnlock_put(&xnirqs[irq].lock);
>>
>> Why do you call xnintr_sync_stat_references() inside the locked sectio=
n
>> here?
>> Does xnintr_sync_stat_references() really need to be protected by
>> 'intr->lock' (it's been already detached) ?
>=20
> That's now my own overcautiousness :). I think we can move it out.
> Someone must sync on some xnintr object while someone else tries to
> re-register an object with very same address -- classical user error,
> nothing we need to catch here.

Modified version just went online, see

http://www.rts.uni-hannover.de/rtaddon/patches/xenomai/fix-intr-locking-p=
art-ii-v3.patch

whitespace-damaged interdiff:

--- xenomai/ksrc/nucleus/intr.c
+++ xenomai/ksrc/nucleus/intr.c
@@ -124,6 +124,7 @@
                goto unlock_and_exit;
        }
 #else
+       /* cookie always valid, attach/detach happens with IRQs disabled =
*/
        intr =3D cookie;
 #endif
        s =3D intr->isr(intr);
@@ -438,9 +439,10 @@
                        /* Remove the given interrupt object from the lis=
t. */
                        xnlock_get(&shirq->lock);
                        *p =3D e->next;
-                       xnintr_sync_stat_references(intr);
                        xnlock_put(&shirq->lock);
=20
+                       xnintr_sync_stat_references(intr);
+
                        /* Release the IRQ line if this was the last user=
 */
                        if (shirq->handlers =3D=3D NULL)
                                err =3D xnarch_release_irq(intr->irq);
@@ -468,12 +470,11 @@
        int err;
=20
        xnlock_get(&xnirqs[irq].lock);
-
        err =3D xnarch_release_irq(intr->irq);
-       xnintr_sync_stat_references(intr);
-
        xnlock_put(&xnirqs[irq].lock);
=20
+       xnintr_sync_stat_references(intr);
+
        return err;
 }
=20

Jan


--------------enigD4C5AA3F6341F74F880C2750
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGip7kniDOoMHTA+kRAglDAJ416uyK75zfNP+oBXFAllXiwSyKUQCdHycC
G+4oNU/JZ3+JzMVyw+HpcNo=
=i4xH
-----END PGP SIGNATURE-----

--------------enigD4C5AA3F6341F74F880C2750--

