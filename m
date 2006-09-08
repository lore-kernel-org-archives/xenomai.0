Message-ID: <4501691E.9010704@domain.hid>
Date: Fri, 08 Sep 2006 14:59:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: (WARNING!!! PGP with incorrect signature) Re: [Xenomai-help] Res
References: <45015AF8.6070004@domain.hid> <45015E28.7080405@domain.hid>
In-Reply-To: <45015E28.7080405@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig04C16EAE46E488123ED08DE8"
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
To: Dirk Eibach <eibach@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig04C16EAE46E488123ED08DE8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dirk Eibach wrote:
> jan.kiszka@domain.hid wrote:
>> Dirk Eibach wrote:
>>> Hello,
>>>
>>> we have lots of tasks, semaphores and mutexes in our complex
>>> application. Stopping and restarting seems to leak some resources,
>>> because we get ENOMEM when a thread is created after restarting the
>>> application, first time everything goes well.
>>>
>>> Probably we do something wrong, maybe somebody can tell us what.
>>
>> What skin do you use? Native? Only the POSIX skin currently does
>> auto-cleanup, the others require explicit care.
>=20
> We are using native skin, so that explains the problem we are facing.
> Thanks.
>=20
>>> What do we have to do in order to clean up all resources properly,
>>> especially if our application is ended by SIGKILL?
>>
>> Install a signal handler and do cleanup of all allocated objects (task=
s
>> get deleted when they terminate). Either keep track of your allocated
>> resources in some list(s) or signal the owners (tasks) that they shoul=
d
>> terminate and cleanup their locally allocated resources. There are
>> dozens of ways to do this, depending on your application design.
>>
>> But if you think that you are cleaning up correctly and still face
>> leaks, try to derive a simple test that demonstrates the issue.
>=20
> Hmmm, wouldn't it be clever to have a syscall that would allow us to
> free all xenomai resources at once, so we could call it on application
> startup? Otherwise SIGKILL will still be a problem.

Actually, the per-process cleanup is what we should head for also under
the other skins. It will also address SIGKILL (which cannot be caught by
a handler, of course). As most of us only have one brain to think and
two hands to hack, and those are also shared resources ;), support is
always welcome.

Jan


--------------enig04C16EAE46E488123ED08DE8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFAWkeniDOoMHTA+kRAiy6AJwKWDsS31uvV13WuXhIg5pVjgtwPACfX4r1
EugeB7DNl1PW/Roujt1AiZ4=
=H5Lr
-----END PGP SIGNATURE-----

--------------enig04C16EAE46E488123ED08DE8--

