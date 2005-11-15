Message-ID: <4379E194.2050202@domain.hid>
Date: Tue, 15 Nov 2005 14:24:36 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] More on rt pipes usage
References: <OFBDFF2ABC.D4775297-ONC12570B9.004E7A08-C12570B9.00517F6A@datacon.at>	<4378B391.5030306@domain.hid>
	<4378B824.5050708@domain.hid>
In-Reply-To: <4378B824.5050708@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

Ignacio Garc=EDa P=E9rez wrote:
> Hi,
>=20
> Suppose I have a kernel rt task that samples data at a certain rate and
> writes it as messages into a rt pipe, from which it is read by a user
> space non rt program.
>=20
> I want to limit the number of messages that are put into the pipe,
> because otherwise if the user space program dies, it will grow endlessl=
y
> till it exausts the rt heap.
>=20
> What I want to do is to have a pipe that can hold a limited number of
> messages such that rt_pipe_write will fail if it is full.
>=20
> Is there a way to know how many messages are there in the pipe?
>=20
> Even if there is a way, to prevent a (harmless) race condition, I would
> need to lock the pipe between checking the number of messages and
> calling rt_pipe_write. As far as I know, pipe locking belongs to the
> nucleus and I'd like to stay in the native skin as much as possible.
>=20
> Another method would be to count how many messages I write, but then I'=
d
> need some hook that notifies me when the user space program reads a
> message so I can decrement the count.
>=20
> Any ideas?

The plan is to be able to tell the pipe manager to use a user-provided he=
ap=20
instead of the system one; this way, exhausting the local heap (*) in RT =
space=20
would be a clear sign that non-RT must be allowed to consume the pending =
data=20
first. A simple interface to do that is missing, but the pipe manager alr=
eady=20
works with a variable heap pointer.

(*) Using the overall available memory seems a better metric than the num=
ber of=20
pending messages, since it may often happen that messages have different =
sizes.

--=20

Philippe.

