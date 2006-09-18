Subject: Re: [Xenomai-core] 	[PATCH, RFC] Make ioremap'ed memory available
	through	rtdm_mmap_to_user()
From: Stelian Pop <stelian.pop@domain.hid>
In-Reply-To: <450AD766.3000307@domain.hid>
References: <1158337583.13530.20.camel@domain.hid>
	<450AD766.3000307@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 18 Sep 2006 23:13:07 +0200
Message-Id: <1158613987.31164.9.camel@domain.hid>
Mime-Version: 1.0
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
Cc: xenomai@xenomai.org

Le vendredi 15 septembre 2006 =E0 18:40 +0200, Jan Kiszka a =E9crit :

> In case no one comes up with an easy, portable way to detect remapped
> memory as well: What about some flags the caller of rtdm_mmap_to_user
> has to pass, telling what kind of memory it is? Would simplify the RTDM
> part, and the user normally knows quite well where the memory came from=
.
> And I love to break APIs. :)

This would be perfect. We could even reuse the prot field for that
(PROT_READ | PROT_WRITE | PROT_VMALLOC | PROT_IOREMAP). Not the cleanest
solution, but it won't break the API this way.

Or maybe we should lower the API level a little bit, and let the user
specify the physical address of the mapping instead of the virtual
one....

Stelian.
--=20
Stelian Pop <stelian.pop@domain.hid>


