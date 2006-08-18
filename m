Message-ID: <44E5AF32.3020102@domain.hid>
Date: Fri, 18 Aug 2006 14:14:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Towards periodic mode over aperiodic timers
References: <44E46EDC.1000707@domain.hid> <1155899619.4326.56.camel@domain.hid>
In-Reply-To: <1155899619.4326.56.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig60D7899F8B2D4281FFCBC335"
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig60D7899F8B2D4281FFCBC335
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2006-08-17 at 15:27 +0200, Jan Kiszka wrote:
>> Hi,
>>
>> the conflict between skins preferring aperiodic timing vs. skin
>> requiring periodic mode popped up once again on xenomai-help. One way
>> out of this, likely THE way, is to map such tick-driven skins on a
>> periodic timer over aperiodic mode (and drop periodic low-level suppor=
t
>> completely at the same time).
>>
>> Let's start some discussion how this can be done, specifically as Gill=
es
>> and I are already turning the xntimer subsystem upside down (almost). =
If
>> we want co-existence of high-res timing of, say, the posix skin while
>> the vxworks skin runs over a tick-timer, we need some kind of "context=
"
>> for timing related functions.
>>
>> Simple example: xnpod_suspend_thread() expects a timeout as "xnticks",=

>> i.e. either in nanoseconds or in ticks of the underlying periodic time=
r.
>> This depends on the global timer mode of the pod, and that's a no-go f=
or
>> concurrent modes as sketched above. Rather, the thread should encode
>> which kind of timing mode to use, even better the threads timers.
>>
>> We currently dispatch xntimer_start globally to the different timer
>> subsystems (if periodic mode is enabled). What about deriving the star=
t
>> function from the timer itself in the future? If a timer was created a=
s
>> aperiodic, things happen as usual in aperiodic mode, and the timeout a=
re
>> interpreted as nanoseconds. If the timer is periodic, we interpret the=

>> timeout in ticks and map them on a second-level timing subsystem
>> (probably a wheel) that itself is driven by a single periodic timer in=

>> the first-level system (just like the host tick).
>>
>> Am I heading in the right direction? Is it feasible? Any other ideas?
>=20
> I like this idea; it's simple and elegant, having only a low impact on
> the existing interfaces.
>=20
> The two-level timer handling moving the BSD wheel on top of the
> aperiodic shot is definitely a clean approach, which adds no overhead t=
o
> the existing periodic timer management. This would also allow to get ri=
d
> of the specific Adeos support for periodic hw management.
>=20

One could then even think about making the support switch for periodic
mode a per-skin option for those that support both modes.

That all sounds thrilling, but will certainly require some noticeable
refactoring. Maybe we can start with adding the required bits to the
existing aperiodic timer subsystem while keeping the periodic
infrastructure. Oh my dear, I'm already regretting having made that
suggestion... ;)

Jan


--------------enig60D7899F8B2D4281FFCBC335
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE5a8yniDOoMHTA+kRAkDmAJ9FC//jT7ku+JEAYOOnnWZLucP1+ACghJZw
iIjWg7FI6VJf0GgK6AP3XJU=
=hjxz
-----END PGP SIGNATURE-----

--------------enig60D7899F8B2D4281FFCBC335--

