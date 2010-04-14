Message-ID: <4BC570A4.1090203@domain.hid>
Date: Wed, 14 Apr 2010 09:37:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B97BA0C.9000702@domain.hid> <4B9AD0DE.4020103@domain.hid>	
	<1268472523.27899.135.camel@domain.hid>	
	<4B9BB9B1.5050003@domain.hid>	
	<1268498034.27899.167.camel@domain.hid>	
	<4B9C2100.6090806@domain.hid>	
	<1268584465.27899.197.camel@domain.hid>	
	<4BB4F857.5020906@domain.hid> <4BB50C8B.2000405@domain.hid>	
	<1270156940.2418.403.camel@domain.hid>
	<4BB50F7C.1020102@domain.hid>	
	<1270157507.2418.409.camel@domain.hid>
	<4BB511C7.1050507@domain.hid>	
	<1270158532.2418.420.camel@domain.hid>
	<4BB51631.5030609@domain.hid>	
	<1270159246.2418.432.camel@domain.hid>
	<4BB51931.3080307@domain.hid>	 <4BB523E8.705@domain.hid>
	<4BB5250F.1040409@domain.hid>	 <4BB52769.4080702@domain.hid>
	<4BB5348B.2070805@domain.hid>	 <4BB5C95E.9060502@domain.hid>
	<4BB5D0D4.40908@domain.hid>	 <4BB5D1A0.8030007@domain.hid>
	<4BB5D4FB.4010901@domain.hid>	
	<1271191271.2365.436.camel@domain.hid>
	<4BC4F8CA.4080202@domain.hid>
	<1271229750.2365.444.camel@domain.hid. org>
In-Reply-To: <1271229750.2365.444.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5330494CAF7EA50FCF432FCC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-help] Analogy cmd_write example
	explanation
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5330494CAF7EA50FCF432FCC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2010-04-14 at 01:05 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> The steps now:
>>>
>>> - we implement the automatic switchback of shadow nrt threads to
>>> secondary mode, upon return from Xenomai (primary) syscalls. I am
>>> working on this. The most significant impact is on userland, due to t=
he
>>> fastsynch support, actually. Kernel-wise, it's rather straightforward=
=2E
>>> The only exception to this would be when the caller owns an exclusive=

>>> resource (like a mutex), in which case the mode downgrade should be
>>> postponed until the syscall releasing the last resource held returns.=

>> Kernel is clear, but user space sounds indeed interesting. I guess we
>> need an out-of-band channel to tell the kernel about pending
>> user-space-only lock ownerships when calling some unrelated syscall. H=
ow
>> does your current approach look like?
>=20
> I want to keep things simple: shadow nrt will go through the syscalls
> for acquisition/release of owned resources, instead of fastsynchs.

Then I'll have to pick this up as that will very likely create unhappy
customers. In fact, the majority of our Xenomai threads are nrt (yeah,
that happens if you convert existing applications).

>=20
>>> - because of the previous fix, there would be no valid use case of
>>> forced switches to secondary mode anymore, via
>>> rt_task_set_mode/pthread_set_mode_np by clearing the T_PRIMARY bit. S=
o
>>> we may remove that particular call form, that is most often misused.
>>>
>>> - it turns out that __xn_exec_conforming is a misnomer, because it
>>> rightfully causes a Xenomai nrt thread to switch to primary mode, alb=
eit
>>> that thread is inherently a secondary mode beast most of the time (at=

>>> least it should). We want to describe a syscall that switches the cal=
ler
>>> to the highest domain it can reach instead, so we should rename this
>>> mode bit as __xn_exec_strict for instance, without changing its
>>> semantics.
>>>
>>> - we provide T_CONFORMING instead of T_PRIMARY for
>>> rt_task_set_mode()/pthread_set_mode_np(), keeping the ABI (i.e. the b=
it
>>> number) and the effect intact for existing callers, who are using thi=
s
>>> to force a Xenomai-enabled rt thread back to primary mode, which coul=
d
>>> make sense in some rare cases. However the semantics changes: invokin=
g
>>> this service from a Xenomai nrt thread would lead to a nop, because t=
he
>>> preferred mode of operation is secondary, so any switch to primary sh=
all
>>> be nucleus-controlled, and reverted upon syscall return asap. Changin=
g
>>> the macro name should also have the useful side effect of forcing a
>>> serious code inspection for apps being rebuilt over 2.5.3, so that th=
e
>>> reason to switch mode eagerly could be reconsidered, and the app fixe=
d
>>> properly.
>>>
>>> To sum up,
>>>
>>> 1) rt_task_set_mode(whatever, T_PRIMARY, &oldmode) would become:
>>> rt_task_set_mode(whatever, T_CONFORMING, &oldmode), actually forcing
>>> primary mode for SCHED_FIFO Xenomai threads only. Nop otherwise.
>>>
>>> 2) rt_task_set_mode(T_CONFORMING, whatever, &oldmode) would always be=
get
>>> -EINVAL, just because you can't ask for a thread to stop being
>>> conformant to its basic nature.
>> These two still look too complex and inconsistent to grasp.
>>
>> Let's just keep the kernel ABI, ie. let the kernel still interpret the=

>> bit (maybe now according to your conforming scheme), but drop T_PRIMAR=
Y
>> from the user-visible defines.
>=20
> This is exactly what was described: drop T_PRIMARY as a way to fully
> control the mode from userland, provide T_CONFORMING as a limited actio=
n
> to force a switch back to primary for shadow rt.

Not exactly: I'm against T_CONFORMING.

>=20
>>  For the use case of an enforced primary
>> mode switch-back, add a new service - if it is really required.
>> rt_task_set_mode is about static property switching, so adding T_PRIMA=
RY
>> here was already a bad idea from that perspective.
>>
>=20
> There is no such limitation to rt_task_set_mode(), and T_CONFORMING is
> not meant to be used blindly. So, I will stick with this interface.

T_CONFORMING is a mini-me of T_PRIMARY. If we already clean up the
latter, it is a unique chance to finally drop that misplaced interface
from rt_task_set_mode. It's asymmetric and does not really fit into the
"true" modes that this interface controls.

Jan


--------------enig5330494CAF7EA50FCF432FCC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvFcKcACgkQitSsb3rl5xQSLACgw+DF+T+L9DoqO7qnKdjdmGsJ
/8YAnjaZUcnJIpWuwZIYBxUfHzMHwlkx
=kXy/
-----END PGP SIGNATURE-----

--------------enig5330494CAF7EA50FCF432FCC--

