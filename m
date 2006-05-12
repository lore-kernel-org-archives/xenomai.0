Message-ID: <44646BEB.5030708@domain.hid>
Date: Fri, 12 May 2006 13:05:15 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <44646131.9090600@domain.hid>
In-Reply-To: <44646131.9090600@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] Re: [BUG] kernel oops on registry duplicate names
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Ignacio Garc=EDa P=E9rez wrote:
> The subject pretty much explains it all.
>=20
> Just try to create a task named "foo" and a queue also named "foo".
>=20
> Tested in 2.1.1 and svn HEAD.
>=20

Ok, that's the other way around, you first create the queue, then the=20
task, and the error path of the task creation routine seems to go wild=20
afterwards when it detects the registry error.

--=20

Philippe.

