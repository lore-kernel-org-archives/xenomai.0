Date: Mon, 15 Feb 2016 13:59:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160215125941.GD9903@hermes.click-hack.org>
References: <CAMgLWPm3z5h-aLw5X5LdU+6ULQoqHTN2ebwR0Y4=z1F+qFVsKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMgLWPm3z5h-aLw5X5LdU+6ULQoqHTN2ebwR0Y4=z1F+qFVsKA@mail.gmail.com>
Subject: Re: [Xenomai] Problem with rt_igb driver for I210 card
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "GEORGE, Laurent" <laurent.george@esiee.fr>
Cc: xenomai@xenomai.org

On Mon, Feb 15, 2016 at 01:48:57PM +0100, GEORGE, Laurent wrote:
> Hi,
>=20
> I have dowloaded and tested the stable version of Xenoma=EF 3 including a
> support for the I210 (Intel) card, available at the following git:
>=20
> https://git.xenomai.org/xenomai-3.git/commit/?h=3Dnext&id=3D8268c5e87cf0a=
c5223d98a86918b9420a0e94382
>=20
> I have the following problem:
>=20
> The Installation of Xenomai went well. When I load rt_igb.ko module, the
> rteth0 interface for Intel i210 NIC goes up well but there are following 2
> issues:
>=20
> a) when I try the rtsolicit command to add devices in network, it doesn't
> work

"It does not work" is a bit vague. Do you wait for the link to be up
before sending the solicit? Does it return an error? Does it
send a packet but receive no answer? Some other case?

> b) When I try to remove rt_igb module after taking down rteth0 interface =
it
> hangs and the only way to get back is a hard restart by pressing the
> restart button on PC.

Maybe the kernel crashed and capturing the console ideally via
serial port, failing that via netconsole would help?

Regards.

--=20
					    Gilles.
https://click-hack.org

