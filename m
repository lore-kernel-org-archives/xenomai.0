Message-ID: <44716DC0.7080709@domain.hid>
Date: Mon, 22 May 2006 09:52:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] non-RT-safe rtdm_event_*wait
References: <446C264A.7040206@domain.hid> <446F09B8.6000609@domain.hid>
In-Reply-To: <446F09B8.6000609@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAB6830BFEFD36CF9ABACEBB6"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: grugh@domain.hid, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAB6830BFEFD36CF9ABACEBB6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> attached is an experimental patch to allow blocking from non-RT contex=
t
>> on RTDM events. Petr Cervenka made me think about this extension which=

>> could partially open RTDM drivers also for non-shadowed, i.e. standard=

>> Linux tasks.
>>
>> Why not simply shadowing non-RT waiters? Because this kind of sync
>> support should be cheaper than adding yet another (though low-prio) ta=
sk
>> to the real-time domain ("should" =3D=3D I didn't benchmark my believe=
). And
>=20
> I would rather move the logic to the sync object at nucleus level since=

> it's a useful feature for all skins, but doing so, we would also drag a=

> fair amount of complexity just for the sake of not having to shadow a
> Linux task. IMHO, leaving this at the skin level forks the
> implementation of the synchronization management, which raises the issu=
e
> of duplicating functionalities only depending on the calling context.
>=20
> Looking at the issue differently, we already know that we could shadow
> SCHED_NORMAL/SCHED_OTHER threads without promoting them to the
> SCHED_FIFO class - you actually submitted this patch, and it's waiting
> for -rc2 to be released before I merge it into mainline.
>=20
> Given that, a shadow thread which remains in secondary mode is seen as
> suspended by the Xenomai scheduler, which means that the additional
> overhead is close to nil (aside of an additional shadow tcb), until it
> tries to grab the resource and thus moves to the primary domain, just
> for going to sleep.

I'm not concerned about a passive shadow, my aim is to reduce the impact
of active shadow threads without strict timing requirements. When there
is a larger number of them, they should not influence RT scheduling
significantly for just being woken up.

The other point might be the code path length of both non-RT wakeup
suspend/wakeup mechanisms. It's only an assessment, but I think this way
would be shorter. Anyway, numbers would speak clearer, and I guess this
should be done first before any further design decision.

>=20
> IOW, I would rather use the allow-non-SCHED_FIFO-shadow patch to allow
> regular Linux tasks to pend seamlessly on Xenomai sync objects as true
> shadows, and add to the rtdm blocking syscall handler some code that
> would transparently promote any calling regular task as a Xenomai shado=
w
> on the fly, before undergoing the request. The other advantage of such
> approach is that the non-RT pending task is still known from the Xenoma=
i
> sub-system (/proc/xenomai/ interface and so on), which may be useful
> given that it interacts with it. You could still apply a FIFO pending
> order with mixed RT and non-RT tasks the same way.

Hmm, on-demand shadowing might be an option. Ok, once non-SCHED_FIFO is
merged, we should have a look at both approaches from the performance
POV and compare potential differences with the required additional code.

>=20
> Moving RTDM to native preemption would also be simpler, since RTDM woul=
d
> expect the issue to be handled at core level directly, and in the
> preempt-rt case, the issue of the caller's domain is actually a non-iss=
ue.
>=20

Well, this is already the case for my proposal: no special handling of
rtdm_event_* depending on the caller's context anymore.

Jan


--------------enigAB6830BFEFD36CF9ABACEBB6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEcW3AniDOoMHTA+kRAt/jAKCBMmGT0W3xP1c9gDaq5Ri5bAECpQCfa1tV
gvH3iJ4ayF1TWTlYWhOgpsI=
=mXWI
-----END PGP SIGNATURE-----

--------------enigAB6830BFEFD36CF9ABACEBB6--

