Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1283)
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <50E5FF66.3080608@communistcode.co.uk>
Date: Fri, 4 Jan 2013 09:55:33 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <AA34B1DF-B8B8-4C44-B1C5-0FDB164862C7@mah.priv.at>
References: <CAGVaUoFsUJKCSOMrDuq3htrLzScpzjVP8oKs2ARp7k7o8KbRfQ@mail.gmail.com>
	<9480305C-20DF-4DBA-AC23-7E3E59EBCEEB@mah.priv.at>
	<50E1CC06.9050404@xenomai.org>
	<382C7691-29C9-408C-97DE-4A020138B0A4@mah.priv.at>
	<CANKLDmuU254PGkv2+ABiGitZDg1u9A5uq9Po=3gzOo8-KyANVw@mail.gmail.com>
	<20130103085312.GA8132@localhost.localdomain>
	<5C3D95AF-ADF8-4B1E-8FB6-5B9557262EC8@mah.priv.at>
	<50E5FF66.3080608@communistcode.co.uk>
Subject: Re: [Xenomai] About the timer interrupt in beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Jack,

Am 03.01.2013 um 23:00 schrieb Jack Mitchell:

> On 03/01/2013 09:18, Michael Haberler wrote:
>> Am 03.01.2013 um 09:53 schrieb Richard Cochran:
>>=20
>>> On Wed, Jan 02, 2013 at 10:40:05AM +0100, Henri Roosen wrote:
>>>> My decision to base the port on the Arago project was also that it =
looked
>>>> 'most TI official' to me. TI ships an evaluation disk with the =
AM335x-evm
>>>> board that is based on this project.
>>> The arago thing has gazillions of hacks, must of which are never =
going
>>> mainline. I would avoid it if at all possible.
>>>=20
>>> I have been pushing to get the beaglebone working "out of the box" =
in
>>> mainline Linux, and as of v3.8-rc2 it does work with a ramfs and
>>> Ethernet networking. However, I don't know which other drivers are
>>> still not working on that board.
>> Richard -
>>=20
>> fine, but my requirement is a working Xenomai kernel with - in the =
minimum - GPIO, PRU, PWM, cape support, and I dont see that combination =
of Xenomai and v.3.8 around the corner anyday soon
>>=20
>> what would you then suggest as an alternative base for getting =
Xenomai to run on the beaglebone with the above laundry list?
>=20
> OT: I would suggest now starting with [1] for any beaglebone based =
work. The only thing that I'm not sure about is PRU support.

it looks like PRU support is in fact included:

config: =
https://github.com/beagleboard/kernel/commit/fb146ec635a8a6cab3527a924a0e0=
68d382f2549

driver: =
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3Dblob;f=3D=
drivers/uio/uio_pruss.c;h=3D6e2ab007fe9c03fc7768bf84144155f73e1bd871;hb=3D=
d1c3ed669a2d452cacfb48c2d171a1f364dae2ed

thanks!

Michael

ps: OT - we have a 200kHz software stepper motor driver running on the =
PRU by now - while the main CPU is idle; there's no realistic chance of =
getting anywhere near this figure without the PRU

>=20
> Regards,
> Jack
>=20
> [1] https://github.com/beagleboard/kernel/tree/3.8
>=20
>>=20
>> - Michael
>>=20
>>=20
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai
>=20
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai


