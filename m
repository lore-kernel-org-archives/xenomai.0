Message-ID: <49DF3C58.2070207@domain.hid>
Date: Fri, 10 Apr 2009 14:32:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49DF102B.4030107@domain.hid> <1239359009.7007.127.camel@domain.hid>
	<49DF36CE.6020105@domain.hid>
In-Reply-To: <49DF36CE.6020105@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE98C7D0CDFD9998323DB69AD"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Git pull request.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE98C7D0CDFD9998323DB69AD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>> On Fri, 2009-04-10 at 11:23 +0200, Gilles Chanteperdrix wrote:
>>> Hi Philippe,
>>>
>>> I got some changes ready for head. What we want to include in the sta=
ble
>>> branch remains to be discussed, once we agree, I will prepare another=

>>> branch for v2.4.x patches.
>>>
>> No objection to merge back FPU fixes to 2.4.x before we close that
>> branch, when 2.5 is out. This would give us some time to make sure
>> everything is fine while running the -rc series.
>=20
> Ok. I was thinking that it may be dangerous to merge the "Optimize x86
> fpu switches" patch, since it is not strictly necessary. But from the
> point of view of getting it tested ASAP by users, you are right. The
> concern about switchtest is that the changes once again break the drive=
r
> ABI.
>=20
>>> The following changes since commit bbbaec33689d8e82b604745bb55209a83d=
79a4bc:
>>>   Philippe Gerum (1):
>>>         Test for self-deletion in a safer way
>>>
>>> are available in the git repository at:
>>>
>>>   git://git.xenomai.org/xenomai-gch.git for-upstream
>>>
>>> Gilles Chanteperdrix (4):
>>>       Improve switchtest coverage.
>>>       x86 FPU fixes
>>>       Optimize x86 fpu switches.
>>>       Fix rt_task_trampoline and rt_task_shadow error paths.
>> I'm generally ok with the patches, but the last one still leaves an
>> issue open: if the child thread dies upon -ENOMEM, the creator won't b=
e
>> unblocked from pending on the completion sync in rt_task_create(). We
>> could live with this for a while (lacking memory at that point is a
>> clear sign that things are going to turn ugly very soon anyway), but
>> would we want to fix this, we would have to either fire the
>> __rt_task_create syscall with some NULL args and let it notice them,
>> then signal the completion block with an error status, or have somethi=
ng
>> like __xn_sys_sigcompletion to unblock the waiter directly from
>> userland.
>=20
> I just reused the "fail" label of rt_task_trampoline without thinking
> about the consequences. Will try to see which idea is simpler to
> implement. In any case, I am afraid we will get yet another ABI change.=

>=20
> A question about git now: can I "git reset" or "git branch -D" a remote=

> branch ?

Just add '-f' to your push command if you have dropped or updated some
patch that is already present in the remote repos (I'm always doing this
when pushing my stgit-managed patch queues).

Deleting a branch remotely is something I haven't tried yet, but the
examples in 'man git-push' claim it works.

Jan


--------------enigE98C7D0CDFD9998323DB69AD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAknfPFwACgkQniDOoMHTA+kwvACePSLvJHKUdTPzohIlRP7y0yG1
FzAAnAmO48ex6o2uV2EPyxfN53tAT+FI
=Q9Ut
-----END PGP SIGNATURE-----

--------------enigE98C7D0CDFD9998323DB69AD--

