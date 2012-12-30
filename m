From: Paul <paul_c@tuxcnc.org>
Date: Sun, 30 Dec 2012 15:34:06 +0000
References: <CABi95VNaL3VuLq-qBEGgG1Fnwtpi2eQsDCMyEqPqvh9yNuZ-Eg@mail.gmail.com>
	<50E03E2E.9000803@xenomai.org>
In-Reply-To: <50E03E2E.9000803@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201212301534.06581.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] Can not run test on Raspberry Pi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

On Sunday 30 December 2012, Gilles Chanteperdrix wrote:
> On 12/30/2012 04:32 AM, =E6=B2=88=E6=B6=9B wrote:
> > Hello all!
> >
> > I'm not familiar with either Xenomai or Raspberry Pi.So please do
> > not be mad at me if my question seems silly.
> >
> > Anyway,I followed the instructions on
> > http://powet.eu/2012/07/25/raspberry-pi-xenomai/<http://translate.g
> >oogleusercontent.com/translate_c?depth=3D1&hl=3Den&ie=3DUTF8&prev=3D_t&r=
url=3D
> >translate.google.com&sl=3Dfr&tl=3Den&twu=3D1&u=3Dhttp://powet.eu/2012/07=
/25/
> >raspberry-pi-xenomai/&usg=3DALkJrhh8sBPbInHso_27CJ73Qprh-F7cxA> and
> > cross compiled a kernel patched with Xenomai with tools from
> > https://github.com/raspberrypi/tools.It seems work fine.
> >
> > Then I cross compile Xenomai(the user-space sport),and copied all
> > the results to my Raspberry Pi.When I try to run the
> > /usr/xenomai/bin/latency,I get the ERROR: error while loading
> > shared libraries:libnative.so.3:cannot open shared object file: No
> > such file or directory.
> >
> > pi@raspberrypi ~ $ ls /usr/xenomai/lib
> > ...... libnative.so.3 ......
> >
> > So the object file is there.
> >
> > The I tried to ldconfig with /usr/xenomai/lib in my
> > /etc/ld.so.conf,and confirm the result.
> >
> > pi@raspberrypi ~ $ ldconfig - p | grep native
> >    libnative.so.3(libc6)=3D>/usr/xenomai/lib/libnative.so.3
> >    ......
> >
> > I also tried to export LD_LIBRARY_PATH,still get the same error.
> >
> > I know the problem may seems familiar to you.I have already googled
> > it and keep trying to solve it.I also read the
> > Program-Library-HOWTO from
> > http://www.tldp.org/HOWTO/Program-Library-HOWTO/introduction.html
> > and try to learn more about shared libraries.But I still can not
> > solve my problem,need some help.
>
> Hi Shen,
>
> The most common reason for such issues is if you are not compiling
> xenomai with the same toolchain or same toolchain options (regarding
> for instance the EABI setting) as the one used to compile the target
> libc.

If you are using a Raspian install, then try using:
 configure --host=3Darm-bcm2708hardfp-linux-gnueabi
The alternative is to compile Xenomai on the PI which doesn't take too=20
long. Both options work fine for me.

The kernel should have also been compiled with  the bcm2708hardfp=20
toolchain so as to avoid problems further down the line.

>
> Regards.



