Message-ID: <451A8BEF.6060305@domain.hid>
Date: Wed, 27 Sep 2006 16:34:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20060927135543.26891.qmail@domain.hid>
In-Reply-To: <20060927135543.26891.qmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFF71C8715D14ED1A5A76FD86"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: [Xenomai-core] aperiodic xenomai tasks
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: mani bhatti <imranbashirbhatti@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFF71C8715D14ED1A5A76FD86
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Two requests:
- please use "reply to all" in order to include everyone in this thread,
  specifically the list itself
- cut quotes you do not comment on in your reply (helps to grab quickly
  what you are referring to - and what not)

mani bhatti wrote:
> Hi Jan Kiszka
> Thanks a lot for your kind reply.Actually my motivation behind this
> question was that i wanted to have two tasks one of the task i want
> to make pariodic and schedule it after 1second and the second task i
> wanted to singnal only after my first task has completed its work so
> that second task completes its work  and  first task is scheduled
> again and second task signalled and so on.Because second task is
> signalled only when first task completes thats why i wanted to make
> it aperiodic and comment out that rt_task_set_periodic stuff but i am
> not still able to do it because in my case only task no 1 is
> scheduled and task 2 is not signalled at all.Actually i am a new bee
> to xenomai and have experience mostly with programming in C++ thats
> why i have only idea about threading in C++ and java which havent got
> functions like set periodic.If you please tell me how to realize
> above idea in Xenomai i would br very thankful to you.Thanks a lot
> again.
>=20

Your problem is actually independent of Xenomai. I think you should
first read some basics on interprocess communication. Quick hint
regarding your scenario:

    http://en.wikipedia.org/wiki/Semaphore_%28programming%29

You will find related services in Xenomai as well. Also browsing through
the Xenomai doc what's available and then reading up what it is good for
can help to broaden the understanding, and this is essential for writing
real-time software.

Jan


--------------enigFF71C8715D14ED1A5A76FD86
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFGovvniDOoMHTA+kRAtT7AJ9yooxhbefddGxxkpHcML6+pcX9SQCfVCoT
FG2rZpDFLdBf08yFCRymbPU=
=qAi+
-----END PGP SIGNATURE-----

--------------enigFF71C8715D14ED1A5A76FD86--

