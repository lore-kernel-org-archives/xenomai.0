Message-ID: <4BD1E55E.2080604@domain.hid>
Date: Fri, 23 Apr 2010 20:22:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B9A5CDA.7080704@domain.hid>	<1272020668.9515.763.camel@domain.hid>	<4BD18F79.6080708@domain.hid>	<1272032336.28983.21.camel@domain.hid>
	<1272033034.28983.28.camel@domain.hid>
In-Reply-To: <1272033034.28983.28.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6A89BE7219F4F2E9E7C68458"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Adeos-main]  [RFC] KVM over Xenomai and I-pipe
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6A89BE7219F4F2E9E7C68458
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Fri, 2010-04-23 at 16:18 +0200, Philippe Gerum wrote:
>> On Fri, 2010-04-23 at 14:15 +0200, Jan Kiszka wrote:
>>> [ dropping xenomai-help before going into details ]
>>>
>>> Philippe Gerum wrote:
>>>> On Fri, 2010-03-12 at 16:25 +0100, Jan Kiszka wrote:
>>>>> Hi,
>>>>>
>>>>> this is still in the state "study", but it is working fairly nicely=
 so far:
>>>>>
>>>>> These two patches harden latest KVM for use over I-pipe kernels and=
 make
>>>>> Xenomai aware of the lazy host state restoring that KVM uses for
>>>>> performance reasons. The latter basically means calling the sched-o=
ut
>>>>> notifier that KVM registers with the kernel when switching from a L=
inux
>>>>> task to some shadow. This is safe in all recent versions of KVM and=

>>>>> still gives nice KVM performance (that of KVM before 2.6.32) withou=
t
>>>>> significant impact on the RT latency (Note: if you have an old VT-x=
 CPU,
>>>>> guest-issued wbinvd will ruin RT as it is not intercepted by the ha=
rdware!).
>>>>>
>>>>> To test it, you need to apply the kernel patch on top of current kv=
m.git
>>>>> master [1], obtain kvm-kmod.git [2], run configure on it (assuming =
your
>>>>> host kernel is a Xenomai one, otherwise use --kerneldir) and then "=
make
>>>>> sync-kmod LINUX=3D/path/to/kvm.git". After a final make && make ins=
tall,
>>>>> you will have recent kvm modules that are I-pipe aware. The Xenomai=

>>>>> patch simply appies to the 2.5 tree. This has been tested with
>>>>> ipipe-2.6.32-x86-2.6-01 + [3] and Xenomai-2.5 git.
>>>>>
>>>>> Feedback welcome, specifically if you think it's worth integrating =
both
>>>>> patches into upstream. The kernel bits would make sense over some
>>>>> 2.6.33-x86, but additional work will be required to account for the=

>>>>> user-return notifiers introduced with that release (kvm-kmod curren=
tly
>>>>> wraps them away for older kernels).
>>>> No concern on the final goal, running a Xenomai-enabled kernel
>>>> rock-solid over KVM is a must.
>>>>
>>>> The KVM code ironing from the 1st patch looks fine to me, no big dea=
l to
>>>> maintain AFAICS. I would be only concerned by the 2nd patch,
>>>> specifically how the KVM callout is invoked from the Xenomai context=

>>>> switching code:
>>>>
>>>> - depending on CONFIG_PREEMPT_NOTIFIERS is much broader than require=
d; I
>>>> guess that CONFIG_KVM would be enough.
>>> So far, only CONFIG_KVM enables CONFIG_PREEMPT_NOTIFIERS. Granted, th=
is
>>> could change in the future. But letting our invocation depend on
>>> CONFIG_KVM would not automatically remove the need to review those ne=
w
>>> notifiers (BTW, there would be a fairly high probability that those w=
ill
>>> be of some use for Xenomai as well).
>>>
>>>> - calling the KVM callout directly instead of going through the noti=
fier
>>>> list would be more acceptable, so that we don't assume anything from=
 the
>>>> non-KVM hooks (whether they exist or not), albeit we may assume that=
 we
>>>> have complete information about which KVM callout has to be run for =
a
>>>> particular kernel version.
>>> Possible, but hacky. We would have to
>>>
>>> - export the callback from the KVM module
>>>   (this will also mean the nucleus will depend on CONFIG_KVM if the
>>>   latter is on)
>> Which is already the case for a number of knobs anyway (particularly o=
n
>> x86*).

The difference is that kvm can be configured as _module_. Simply
exporting won't be enough.

>>
>>> - somehow get hold of the notifier entry (I have no clue how as they =
are
>>>   per-vcpu)
>>> - invoke the callback directly, passing that notifier entry
>>>
>> This is what I had in mind in my post.
>=20
> Sorry, wrong read: what I had in mind, was simply to identify the KVM
> hook within the code, and forge a correct call interface, whatever this=

> means (i.e. with the original notifier entry, or by providing a second
> hook entry point which would not require such notifier entry).

As KVM registers dynamically with the notifier chain (when the
corresponding VCPU is scheduled in an out), getting the right context is
tricky unless you reuse the notifier chain or let I-pipe provide another
callback interface.

>=20
>>> or
>>>
>>> - identify the KVM callback in the notifier chain and only call that =
one
>>>   when walking the list
>> I don't see any upside to this yet. If this is about context preparati=
on
>> that would be done by the notification system, then we'd better off
>> mimicking it, instead of introducing kludges to reuse it.

Mimicking will mean (almost) 1:1 copying.

>>
>>> The latter could be achieved by somehow tagging KVM notifiers in orde=
r
>>> to find them when walking the chain. Still quite some patching, and I=
'm
>>> not yet sure it's worth the safety gain.
>> The point is that we shall check whether our coupling to the KVM syste=
m
>> is correct, for each kernel version we want to support anyway. This
>> means that some preparation work has to be done, whether it is by
>> inspecting the possibly NMI-unsafe notifier hooks or the interface rul=
es
>> to the KVM hook is not the most important thing here.
>>
>> If you definition of "hacky" here means "ad hoc", in any case, any
>> implementation you could find would be hacky, because Xenomai introduc=
es
>> a context switching spot in a kernel that does not expect it, and as
>> such, we do bypass the normal paths for this. Therefore, I see no way =
to
>> do this without exactly knowing the kernel/KVM context, on a per-relea=
se
>> basis.

Right, that's what we already have to know in order to reuse e.g.
switch_mm safely. The preempt notifier plays in the same league as they
are there to inform subsystems about such kind of switches.

So we have two basic options:
 - patch KVM to additionally register callbacks with I-pipe
   (ipipe_preempt_notifiers)
 - reuse the existing sched_out notifier, keeping an eye on potential
   new users (they exist since 2.6.23 - without anyone else showing
   interest so far)

In both case, we will pull some tricky parts of KVM on our review list,
that's unavoidable. But as long as we reuse well-established interfaces
for this, I'm not too concerned about this.

Jan


--------------enig6A89BE7219F4F2E9E7C68458
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvR5WEACgkQitSsb3rl5xSX9gCeN8DQh+tCYK4OI4L0vv4simY8
kSEAniXbAaVAY43BeqYfaRkp2CJAPqMV
=iyee
-----END PGP SIGNATURE-----

--------------enig6A89BE7219F4F2E9E7C68458--

