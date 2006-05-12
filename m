Message-ID: <4464976B.30309@domain.hid>
Date: Fri, 12 May 2006 16:10:51 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [BUG] kernel oops on registry duplicate names
References: <44646131.9090600@domain.hid> <44646BEB.5030708@domain.hid>
	<44646CB9.9070906@domain.hid>
In-Reply-To: <44646CB9.9070906@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>=20
>>Ignacio Garc=EDa P=E9rez wrote:
>>
>>>The subject pretty much explains it all.
>>>
>>>Just try to create a task named "foo" and a queue also named "foo".
>>>
>>>Tested in 2.1.1 and svn HEAD.
>>>
>>
>>Ok, that's the other way around, you first create the queue, then the
>>task, and the error path of the task creation routine seems to go wild
>>afterwards when it detects the registry error.
>>
>=20
>=20
> That's obviously the same issue I reported a few days ago about creatin=
g
> two tasks with identical names.
>=20

Fixed by commits #1084 and #1085 in both branches.

--=20

Philippe.

