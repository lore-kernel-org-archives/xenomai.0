Message-ID: <479A5D78.6040701@domain.hid>
Date: Fri, 25 Jan 2008 23:06:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4788C279.1020607@domain.hid>
In-Reply-To: <4788C279.1020607@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2DA1909D2C23D2A37789175D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [BUG] evsync is not SMP-safe
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2DA1909D2C23D2A37789175D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe,
>=20
> this
>=20
> int fastcall __ipipe_dispatch_event (unsigned event, void *data)
> ...
> 	ipipe_cpudom_var(next_domain, evsync) |=3D (1LL << event);
> 	local_irq_restore_hw(flags);
> 	propagate =3D !evhand(event, start_domain, data);
> 	local_irq_save_hw(flags);
> 	ipipe_cpudom_var(next_domain, evsync) &=3D ~(1LL << event);
>=20
> doesn't fly on SMP. While the invoked event handler is running, it may
> happen that the caller gets migrated to another CPU. The result is an
> inconsistent evsync state that causes ipipe_catch_event to stall (test
> case: invoke Jerome's system() test a few times, them try to unload
> Xenomai skins and nucleus).
>=20
> First idea (I've nothing implemented to far, would happily leave it to
> someone else's hand): Track event handler entry/exit with an, say, 8 bi=
t
> per-cpu counter. On event deregistration, just summarize over the
> per-cpu counters and wait for the sum to become 0. This has just the
> drawback that it may cause livelocks on large SMP boxes when trying to
> wait for a busy event. I've no perfect idea so far.

Second approach to solve this (currently) last known ipipe issue cleanly:=


As long as some task in the system has __ipipe_dispatch_event (and thus
some of the registered event handlers) on its stack, it is not safe to
unregister some handler. For simplicity reasons, I don't think we should
make any difference which handlers are precisely busy. So, how to find
out if there are such tasks?

I checked the code and derived three classes of preconditions for the
invocation of __ipipe_dispatch_event:

 1) ipipe_init_notify and ipipe_cleanup_notify -> no preconditions

 2) ipipe_trap_notify -> some Linux task has PF_EVNOTIFY set or
                         there are tasks with custom stacks present

 3) all other invocations -> some Linux task has PF_EVNOTIFY set

This means by walking the full Linux task list and checking that are no
more PF_EVNOTIFY-tasks present, we can easily exclude 3). In fact, 2)
can also be excluded this way because we can reasonably demand that any
I-pipe user fiddling with event handlers has killed all non-Linux tasks
beforehand. This leaves us with 1) which should be handled via classic
RCU as Linux offers it. Viable? It would even shorten the fast path a bit=
!

Still no code, I would like to collect feedback on this new idea first.

Jan

PS: IPIPE_EVENT_INIT is not used by Xenomai (and I found no trace that
it ever was). Can we deprecate this event and then remove it later,
Philippe?


--------------enig2DA1909D2C23D2A37789175D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHml17niDOoMHTA+kRAm+/AJ0baRalXid22nRoUzK47GkaWf0FQgCfXKQk
wV7DsvZzMCknkqD/0jEKinU=
=NpPE
-----END PGP SIGNATURE-----

--------------enig2DA1909D2C23D2A37789175D--

