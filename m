Message-ID: <2ff1a98a0708100811r47df5608jbb2b4866ec8206fc@domain.hid>
Date: Fri, 10 Aug 2007 17:11:31 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <46BC7A0A.1060309@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
References: <000c01c7db59$181f8680$c124a986@domain.hid>
	<46BC7A0A.1060309@domain.hid>
Subject: Re: [Xenomai-help] POSIX Skin: Changing scheduling parameters of
	threads in other processes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, =?ISO-8859-1?Q?Torsten_Kr=F6ger?= <t.kroeger@domain.hid>

On 8/10/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Torsten Kr=F6ger wrote:
> > 3. Is there a possibility of using the native skin and the posix skin a=
t
> > the same time?
>
> Yes: Write your message passing protocol as an RTDM protocol device.
> That way you would have the socket API as interface (for all skins!) and
> could even fiddle with priority as you like. We went this way for our
> TiMS (Tiny Message Passing Service) in the RACK framework [1]. It's
> fairly specialised due to its roots and its applications domain, but the
> general idea is surely transferable.

It is even possible to use the native skin and the posix skin at the
same time without resorting to RTDM. We try as much as possible to
allow one skin services to be called by a thread belonging to the
other skin. You have to look at each service documentation to know
from what context it can be called.
Posix message queues services, for example, may be called from thread
created by any skin.

--=20
                                               Gilles Chanteperdrix

