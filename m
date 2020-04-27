Subject: Re: Problem with gdb
References: <e393e320-54ea-7a16-d645-3441c80cdc0c@mitrol.it>
 <23d1e027-2e62-8d52-de94-0e9d53b6aa5c@siemens.com>
 <7509227c-b773-8484-1a2d-52c716e67072@mitrol.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <73619ace-a142-ae30-cb1e-a80ab7338a48@siemens.com>
Date: Mon, 27 Apr 2020 07:39:05 +0200
MIME-Version: 1.0
In-Reply-To: <7509227c-b773-8484-1a2d-52c716e67072@mitrol.it>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paolo Minazzi <Paolo.Minazzi@mitrol.it>, xenomai@xenomai.org

On 26.04.20 14:50, Paolo Minazzi wrote:
> Il 26/04/2020 10:33, Jan Kiszka ha scritto:
>> Can you cross-check with ipipe-core-4.19.114-cip24-arm-08? 4.9 is=20
>> unmaintained regarding I-pipe.
> Hi Jan,
> I could try 4.19. But then I would have a complex task to to the porting =

> all of my system to linux-4.19.

If you aren't being a lab device, this would be better anyway in order=20
to receive bug fixes for a longer time. As I said: 4.9 is dead, already=20
lagging behind. 4.4-cip is still maintained but a bad start for a new=20
project.

>=20
> I have tried now downgrading xenomai to 3.0.9 with the same ipipe-4.9.38.
> I have seen something changed in xenomai 3.1 about debugging.

Yes, we need=20
https://gitlab.denx.de/Xenomai/ipipe-arm/-/commit/5f032ff0126222ee944e4e44e=
a0c2b49a9c66d02=20
and more.

Jan

> With xenomai-3.0.9 gdb seems working OK.
> Tomorrow I will test better and I will post results.
>=20
>> How did you build Xenomai (configure options)? How are you building=20
>> your demo?
>>
> Xenomai build
>=20
> ./scripts/bootstrap --with-core=3Dcobalt
> configure --build=3Di686-pc-linux-gnu \
> --host=3Darm-linux-gnueabihf \
> --with-core=3Dcobalt \
> --prefix=3D$HERE/../$XENOMAI-install \
> CC=3Darm-linux-gnueabihf-gcc LD=3Darm-linux-gnueabihf-ld
> make
>=20
> Application build
>=20
> CROSS=3Darm-linux-gnueabihf-
>=20
> INCLUDES=3D$(shell sh ../../xenomai-3.1-install/bin/xeno-config=20
> --skin=3Dalchemy --cflags)
> LIBS=3D$(shell sh ../../xenomai-3.1-install/bin/xeno-config --skin=3Dalch=
emy=20
> --ldflags)
>=20
> All:
>  =A0=A0=A0=A0=A0=A0=A0 $(CROSS)gcc $(INCLUDES) $(LIBS) -o demo demo.c -g
>=20
>=20
> Kind regards,
> Paolo
>=20

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

