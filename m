Message-ID: <44EC8B62.8020306@domain.hid>
Date: Wed, 23 Aug 2006 19:07:46 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <DD39B5C3F4963040ADC9768BE7E430CB01081D6B@is-hdq-exchange.marel.net>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01081D6B@is-hdq-exchange.marel.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Re: [Socketcan-users] Select on a RTCAN socket
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <danielsch@domain.hid>
Cc: Haukur Hafsteinsson <haukur@domain.hid>, xenomai-help <xenomai@xenomai.org>, socketcan-users@domain.hid

Hi Daniel,

Daniel Schnell wrote:
> Hi,
>=20
> =20
>=20
> I wanted to use select() on a socket to find out how many messages are=20
> available. I have opened this socket to access the RTCAN sockets under=20
> Xenomai. According to /usr/xenomai/lib/posix.wrappers select is not=20
> =93supported=94 by the realtime kernel. Accordingly it doesn=92t work. =
If i=20
> start the according task under SCHED_FIFO, the task simply hangs when=20
> initiating select(), in SCHED_OTHER it is simply returning: bad file=20
> descriptor.

select is not supported and cannot be used, indeed.

> Any ideas ? Is there any other way to find out, how many messages are=20
> waiting ?

Select returns the sockets which have data but it does not tell you how=20
many messages are waiting. You could use separate threads to read from=20
sockets.

BTW: this mail is off-topic on the socketcan MLs.

Wolfgang.

