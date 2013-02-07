Message-ID: <5113BFD0.7050501@hilscher.com>
Date: Thu, 07 Feb 2013 15:53:04 +0100
From: =?ISO-8859-1?Q?St=E9phane_LOS?= <slos@hilscher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello Sirs,

Hilscher is offering a Linux driver based on UIO for cifX boards.

In my understanding, down to 1ms cycle time, a PREEMPT RT solution=20
should be enough.

The cifX boards can manage with bus cycle times down to 250=B5s like with=20
EtherCAT or Sercos III firmwares.

So it seems in that cases that using Xenomai would be the way to go.
I suppose that it would be needed to modify or change the existing=20
driver but I can't figure out how things (Xenomai / RTDM / UIO) fit=20
together.

UIO is the kernel module that allows the mapping of the board memory to=20
user space.

The cifX driver uses the libpciaccess to pick up the board and retrieve=20
some board information from UIO before the mapping.
Then it uses pthread and rt functions when accessing the board.

Since UIO and libpciaccess are only used during the initialization, is=20
it a problem for a Xenomai application ?

We have setup a Xenomai system and tried to compile the user land=20
library with Xenomai options and flags and it seems we have been successful.
The driver should be using the POSIX skin of Xenomai if we have been lucky.

I can't see why we would need RTDM. Any hint please ?

I am an absolute beginner in the Xenomai arena, don't throw me to the=20
lions...

--=20
Best Regards,
Cordialement,

St=E9phane LOS
slos@hilscher.com
Support technique

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Hilscher France
12, rue du 35=E8me R=E9giment d'Aviation
Miniparc du Ch=EAne
69500 BRON
France
T=E9l. : +33 (0) 4 72 37 98 40
Fax  : +33 (0) 4 78 26 83 27
http ://www.hilscher.fr
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


