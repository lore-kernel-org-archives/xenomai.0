Message-ID: <43F4E2D3.4010705@domain.hid>
Date: Thu, 16 Feb 2006 21:38:43 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
References: <b647ffbd0602150939g59256b2bx@domain.hid>	
	<43F3C4EA.7050303@domain.hid>
	<b647ffbd0602160220we254aacx@domain.hid>	
	<43F47705.90309@domain.hid>
	<b647ffbd0602160558i4112313an@domain.hid>	
	<43F48832.7060804@domain.hid>
	<b647ffbd0602161128t70d1f08ax@domain.hid>
In-Reply-To: <b647ffbd0602161128t70d1f08ax@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC69392D40289EF3C87079143"
Sender: jan.kiszka@domain.hid
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
--------------enigC69392D40289EF3C87079143
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> On 16/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Dmitry Adamushko wrote:
>>> On 16/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>>> Dmitry Adamushko wrote:
>>>>> On 16/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>>>>
>>>>> Hmm, I still find XN_ISR_NOINT in the patch. Shouldn't we solve thi=
s
>>>>>> before merging (i.e. make XN_ISR_HANDLED non-zero)?
>>>>> Ok, XN_ISR_NOINT is removed in favor of XN_ISR_HANDLED which is now=

>>>>> non-zero.
>>>>> Actually, at first I wanted to make it just the other way about.
>>>>>
>>>> Hmm, thinking about this again, I would like to revert my suggestion=
 in
>>>> favour of a third approach (trying to keep you busy ;) ).
>>>
>>> Ok, you are wellcome :)
>>>
>>> I didn't get it, at least while looking briefly. To make it a bit
>> easier, at
>>> least for me, let's go another way.
>>>
>>> At the left is the list of allowed values as Philippe pointed out.
>>> At the right is another list which corresponds to the left one but wh=
en
>>> NOINT is used instead of HANDLED. Moreover, I have added another case=
 -
>> pure
>>> NOINT. The ISR says it's not mine and, well, it doesn't know whether =
it
>>> should be propagated or no
>>> (ok, so far CHAINED standed for NOINT).
>>>
>>> 1.) HANDLED                     ->  0
>>> 2.) HANDLED | ENABLE     ->  ENABLE
>>> 3.) HANDLED | CHAINED    ->  CHAINED
>>> 4.) CHAINED                      ->  CHAINED | NOINT
>>> 5.)                                    ->   NOINT
>>>
>>> Could you provide the 3-d corresponding table using your new flags?
>>>
>> Still not 3D, but hopefully clarifying: :)
>=20
>=20
>=20
> 1.) XN_ISR_HANDLED |XN_ISR_NO_ENABLE
>> 2.) XN_ISR_HANDLED
>> 3.) XN_ISR_HANDLED | XN_ISR_PROPAGATE
>>     (nucleus ignores implicit IRQ enable)
>> 4.) XN_ISR_NOINT | XN_ISR_PROPAGATE
>> 5.) XN_ISR_NOINT
>=20
>=20
> Then why do we need XN_ISR_NOINT? is it not just the same as ~HANDLED?

The idea is to have at least a define so that

a) users explicitly have to state what they mean
b) we can map the define to some other value whenever we may need this
in the future

The first property could even be used to apply some debug checks in the
user's return value.

>=20
> Moreover, I tend to think now that PROPAGATE (CHAINED) should not be
> normally used by ISRs at all. The only exception would be irq sharing
> between RT and non-RT domains, but that's of no concern for most part o=
f rt
> drivers and, as last events revealed, it's very partially supported at =
the
> moment and possible implementations are quite arguable.

Ack. But you should still export this feature for those who think they
know what they are doing. ;)

>=20
> So HANDLED means the irq line is .end-ed by xnintr_irq_handler()
> (xnarch_end_irq(irq)  is called).
>=20
> If one wants to do it on his own later, NOENABLE can be returned
> additionally.

Yep. So let's call it XN_ISR_NOENABLE.

> But then, one must use xnintr_end_irq() and not just xnintr_irq_enable(=
).
>=20

Yep, but a different (add-on) topic.

> If xnintr_end_irq() would be always the same as xnintr_irq_enable() or =
we
> would decouple ending and enabling operations on the line (don't have
> sources at hand); we could go Linux way and make use of a "nested" coun=
ter
> in xnintr_t, so that xnintr_irq_disable() could be called in a nested w=
ay.
> This said, calling xnintr_irq_disable() in ISR leads to the interrupt l=
ine
> being still disabled upon return from xnintr_irq_handler() and re-enabl=
ed
> again by the user later.
>=20
> ~HANDLED means the ISR was not concerned about this interrupt. i.e. :
>=20
> - there is ISR in another domain (down the pipeline) which is intereste=
d in
> this irq ;
>=20
>      well, the designer of the system should be aware of such cases and=

> probably avoid that on hw layer or, at least, to know what she is doing=
=2E
>=20
> - this is a spurious irq.
>=20
> So upon getting ~HANDLED, xnintr_irq_handler() does :
>=20
> success =3D xnintr_irq_chained(irq);

Only if requested via XN_ISR_PROPAGATE (or _CHAINED)! There is still a
real-time ISR registered on that IRQ you are about to forward now, and
you don't know if someone is handling it down the pipeline. Actually,
this is a fatal situation. The system is broken, bail out, and switch
this line off.

>=20
> if (success)
> {
> /* i.e. another domain is really interested and got this irq as pending=
*/
>=20
> return without .end-ing
> }
> else
> {
> /* this is a spurious irq */
>=20
> make use of some accounting of spurious interrupts (if we need it)), i.=
e.
> keep the irq line disabled if the % of unhandled requests > some limit.=

>=20
> otherwise
>=20
> xnintr_end_irq() and return
> }
>=20
> too long :) ok, it's quite similar indeed to what you have suggested,
> with the exception that
>=20
> - no need for NOINT (if it's really =3D=3D ~HANDLED);
> - nucleus provides some additional logic while handling ~HANDLED case.
> - user don't need to return ENABLE explicitly - in most cases, that's w=
hat
> he actually needs but sometimes just forgets (I recall a few questions =
on
> the mailing list about "only one interrupt".
>=20
>=20
> Jan
>>
> --
> Best regards,
> Dmitry Adamushko
>=20

Jan


--------------enigC69392D40289EF3C87079143
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD9OLTniDOoMHTA+kRAqquAJ4nGnOCdqMD6M117nGAljia1bCNngCcDotr
T6uSSRcIhB/6bM8bXvbrrpA=
=4/Sb
-----END PGP SIGNATURE-----

--------------enigC69392D40289EF3C87079143--

