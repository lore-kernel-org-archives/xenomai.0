Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1283)
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <20130103085312.GA8132@localhost.localdomain>
Date: Thu, 3 Jan 2013 10:18:15 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C3D95AF-ADF8-4B1E-8FB6-5B9557262EC8@mah.priv.at>
References: <CAGVaUoFsUJKCSOMrDuq3htrLzScpzjVP8oKs2ARp7k7o8KbRfQ@mail.gmail.com>
	<9480305C-20DF-4DBA-AC23-7E3E59EBCEEB@mah.priv.at>
	<50E1CC06.9050404@xenomai.org>
	<382C7691-29C9-408C-97DE-4A020138B0A4@mah.priv.at>
	<CANKLDmuU254PGkv2+ABiGitZDg1u9A5uq9Po=3gzOo8-KyANVw@mail.gmail.com>
	<20130103085312.GA8132@localhost.localdomain>
Subject: Re: [Xenomai] About the timer interrupt in beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Cochran <richardcochran@gmail.com>, xenomai@xenomai.org


Am 03.01.2013 um 09:53 schrieb Richard Cochran:

> On Wed, Jan 02, 2013 at 10:40:05AM +0100, Henri Roosen wrote:
>>=20
>> My decision to base the port on the Arago project was also that it =
looked
>> 'most TI official' to me. TI ships an evaluation disk with the =
AM335x-evm
>> board that is based on this project.
>=20
> The arago thing has gazillions of hacks, must of which are never going
> mainline. I would avoid it if at all possible.
>=20
> I have been pushing to get the beaglebone working "out of the box" in
> mainline Linux, and as of v3.8-rc2 it does work with a ramfs and
> Ethernet networking. However, I don't know which other drivers are
> still not working on that board.

Richard -

fine, but my requirement is a working Xenomai kernel with - in the =
minimum - GPIO, PRU, PWM, cape support, and I dont see that combination =
of Xenomai and v.3.8 around the corner anyday soon

what would you then suggest as an alternative base for getting Xenomai =
to run on the beaglebone with the above laundry list?

- Michael


