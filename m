Message-ID: <4577546A.7040208@domain.hid>
Date: Thu, 07 Dec 2006 00:38:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCHES] cleanup minor quirks for 1.6-01
References: <4572DB9F.7040505@domain.hid> <1165157023.4952.361.camel@domain.hid>	
	<4572E7D1.5020103@domain.hid> <1165160855.4952.415.camel@domain.hid>	
	<457310FA.90706@domain.hid> <1165177332.4952.450.camel@domain.hid>
In-Reply-To: <1165177332.4952.450.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCB869945852B778B5AFA5E19"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCB869945852B778B5AFA5E19
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sun, 2006-12-03 at 19:01 +0100, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Sun, 2006-12-03 at 16:05 +0100, Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> On Sun, 2006-12-03 at 15:13 +0100, Jan Kiszka wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I came across a few things in latest 2.6.19-i386-1.6-01 patch:
>>>>>>
>>>>>> The usage of __ipipe_pipelock in __ipipe_common_info_proc is broke=
n (raw lock used as
>>>>>> Linux lock here), and I do not see any volatile data it could prot=
ect anyway. So let's
>>>>>> remove it.
>>>>> The interrupt status word, and whether any virtual interrupt is
>>>>> allocated or not, are the volatile data protected by this lock on a=
 SMP
>>>>> system. Since this is a common spinlock with no interrupt control
>>>>> required which is only used over the Linux domain (/proc handler), =
you
>>>>> don't need to go for the _hw() form of it.
>>>> As far as I see, nothing prevents the other users of __ipipe_pipeloc=
k to
>>>> be executed over non-root domain (IRQ registration in Xenomai contex=
t is
>>>> allowed, no?).
>>>>
>>> Indeed, this is also the sense of my second reply:
>>> https://mail.gna.org/public/adeos-main/2006-12/msg00004.html
>>>
>>> Which means that our problem is more an issue regarding preemption by=

>>> interrupts.
>>>
>>>> But I have to re-check what data for __ipipe_common_info_proc actual=
ly
>>>> can be released (I'm not considering inconsistency a problem here). =
I
>>>> didn't see anything on first review.
>>>>
>>>> Still, this kind of merging of _hw with non-_hw spinlock operations =
is
>>>> fishy in my eyes.
>>>>
>>> It's not without interrupt control, provided you accept the possible
>>> side-effects regarding kernel preemption, which /proc handlers do. Wh=
at
>>> would have been really problematic is a mismatch between
>>> spin_lock_irqsave_hw and spinlock_irqsave forms, and what is really a=

>>> bug is the current lack of protection wrt interrupt.
>> I re-checked the code, and I can only repeat that I see ZERO need for
>> this lock here. All we are reading is the control mask from static IRQ=

>> arrays + some bits from the related I-pipe domain.
>=20
> We do want the IRQ descriptors to be in a stable state while dumping
> their contents, wrt ipipe_virtualize_irq() and ipipe_control_irq(). It
> could be seen as a conservative measure, but it's saner than assuming
> that fields from the IRQ arrays will never relate to each other wrt wha=
t
> is dumped by the /proc handler. However, this global spinlock should be=

> moved as per-domain lock, there is no need for global contention here.

/me still not convinced. Neither ipipe_virtualize_irq() nor
ipipe_control_irq() are used at a relevant rate so that user will see
inconsistent dumps here. But if you really see a need, let us please use
a sequence lock-like mechanism. It's not worth to stall anyone just for
the sake of debug /proc output.

>=20
>> If there is actually something to protect, than it should be calling
>> this proc handler vs. unregistering the domain (and it's proc entry) -=

>> but that is only feasible with something like synchronize_sched, i.e.
>> waiting a grace period after unregistering so that all handlers are
>> through. A really uncritical race which exists with a lot of /proc cod=
e.
>>
>=20
> This race could crash the box, would the descriptor from the
> unregistered domain belong to a module being unloaded. Since
> ipipe_register_domain() grabs the critical lock, masking IRQs in
> the /proc handler would do the trick, but this is a fairly high price t=
o
> pay for running such a routine.=20
>=20

Better no IRQ lock for this.

Well, also my synchronize_sched idea is not truly safe (unless the proce
handler would be called under rcu_read_lock - don't think this is the
case). I really can't tell how to safely cleanup proc entries that have
volatile data structures attached. I once asked on LKML for a correct
pattern but got no reply.

Jan


--------------enigCB869945852B778B5AFA5E19
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFd1RqniDOoMHTA+kRArX4AJ41flgzASos9FKkYz9vkrRdaew/swCeKTq/
c787dZPyhUIeTjWboLqEkys=
=kLL7
-----END PGP SIGNATURE-----

--------------enigCB869945852B778B5AFA5E19--

