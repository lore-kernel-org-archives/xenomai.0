Message-ID: <50E03E2E.9000803@xenomai.org>
Date: Sun, 30 Dec 2012 14:14:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CABi95VNaL3VuLq-qBEGgG1Fnwtpi2eQsDCMyEqPqvh9yNuZ-Eg@mail.gmail.com>
In-Reply-To: <CABi95VNaL3VuLq-qBEGgG1Fnwtpi2eQsDCMyEqPqvh9yNuZ-Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Can not run test on Raspberry Pi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5rKI5rab?= <xst0001@gmail.com>
Cc: Xenomai@xenomai.org

On 12/30/2012 04:32 AM, =E6=B2=88=E6=B6=9B wrote:

> Hello all!
>=20
> I'm not familiar with either Xenomai or Raspberry Pi.So please do not b=
e
> mad at me if my question seems silly.
>=20
> Anyway,I followed the instructions on
> http://powet.eu/2012/07/25/raspberry-pi-xenomai/<http://translate.googl=
eusercontent.com/translate_c?depth=3D1&hl=3Den&ie=3DUTF8&prev=3D_t&rurl=3D=
translate.google.com&sl=3Dfr&tl=3Den&twu=3D1&u=3Dhttp://powet.eu/2012/07/=
25/raspberry-pi-xenomai/&usg=3DALkJrhh8sBPbInHso_27CJ73Qprh-F7cxA>
> and
> cross compiled a kernel patched with Xenomai with tools from
> https://github.com/raspberrypi/tools.It seems work fine.
>=20
> Then I cross compile Xenomai(the user-space sport),and copied all the
> results to my Raspberry Pi.When I try to run the /usr/xenomai/bin/laten=
cy,I
> get the ERROR: error while loading shared libraries:libnative.so.3:cann=
ot
> open shared object file: No such file or directory.
>=20
> pi@raspberrypi ~ $ ls /usr/xenomai/lib
> ...... libnative.so.3 ......
>=20
> So the object file is there.
>=20
> The I tried to ldconfig with /usr/xenomai/lib in my /etc/ld.so.conf,and=

> confirm the result.
>=20
> pi@raspberrypi ~ $ ldconfig - p | grep native
>    libnative.so.3(libc6)=3D>/usr/xenomai/lib/libnative.so.3
>    ......
>=20
> I also tried to export LD_LIBRARY_PATH,still get the same error.
>=20
> I know the problem may seems familiar to you.I have already googled it =
and
> keep trying to solve it.I also read the Program-Library-HOWTO from
> http://www.tldp.org/HOWTO/Program-Library-HOWTO/introduction.html and t=
ry
> to learn more about shared libraries.But I still can not solve my
> problem,need some help.


Hi Shen,

The most common reason for such issues is if you are not compiling
xenomai with the same toolchain or same toolchain options (regarding for
instance the EABI setting) as the one used to compile the target libc.

Regards.


--=20
                                                                Gilles.


