From: Jerry Huang <jerry.huang@nxp.com>
Date: Tue, 7 Feb 2017 11:01:01 +0000
Message-ID: <DB5PR0401MB18132D3823CCD73291A935C9FE430@DB5PR0401MB1813.eurprd04.prod.outlook.com>
References: <DB5PR0401MB1813333E8ACE184B87CFD047FE610@DB5PR0401MB1813.eurprd04.prod.outlook.com>
 <978e8199-bc2e-2241-1321-6d94b9c611e4@xenomai.org>
 <DB5PR0401MB18133712C3E024CD9B8CD907FE600@DB5PR0401MB1813.eurprd04.prod.outlook.com>
 <057c11d6-1b14-f6a1-f8a3-ddb17e24fc58@xenomai.org>
 <DB5PR0401MB1813914291F050C338CECB00FE790@DB5PR0401MB1813.eurprd04.prod.outlook.com>
 <f0c553f1-694f-2c46-2225-7adf0f7f2eb3@xenomai.org>
 <DB5PR0401MB18131434CBF68E3283535F4DFE7D0@DB5PR0401MB1813.eurprd04.prod.outlook.com>
 <e54b3df3-eebd-156c-0470-963d18b19316@xenomai.org>
In-Reply-To: <e54b3df3-eebd-156c-0470-963d18b19316@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] arm64 support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Jorge Ramirez <jro@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

> >>
> >> All arm64 patches present in the DL area are broken, some critical
> >> changes are missing due to a bug in some obscure code extraction
> >> script for this architecture, do not use them.
> >>
> >> Please pull the code from the I-pipe git tree instead (branch ipipe-4.=
1.y).
> > I clone the ipipe repos (git://git.xenomai.org/ipipe.git) and checkout =
to
> branch origin/ipipe-4.1.y.
> > And using the script ./scripts/ipipe/genpatches.sh to generate the
> > patch "ipipe-core-4.1.18-arm64-6.patch",
> > Then applied it to my kernel Linux-4.1.35 with a litter modification (a=
bout
> file kernel/trace/ring_buffer.c).
> > After building the kernel and booting my board, then I got the kernel p=
anic
> as the result of patch (ipipe-core-4.1.18-arm64-6.patch) from websit
> (http://xenomai.org/downloads/ipipe/).
> > Any comment for this issue?
>=20
> That script is precisely the one that fails pulling the changes required =
to fixup
> the gic(-v3) driver for dealing with interrupt pipelining, so this is goi=
ng to fail
> the same way. The panic message in your kernel log is a manifestation of =
this.
>=20
> You should just use the ipipe.git tree contents unmodified which is corre=
ct,
> because genpatches.sh is currently broken for extracting patches for arm6=
4.
>=20
> --
> Philippe.
Thanks a lot.=20
I used ipipe.git tree and pull all patches for arm and arm64 from branch ip=
ipe-4.1.y and applied all these patches to Linux kernel, and built the kern=
el.
Then, I boot up the Linux kernel (Linux-4.1.35) successfully.
However, when I compile the Xenomai3 lib with command " make install ", I e=
ncountered another issue during compiling:
...
make[3]: Entering directory '/home/huangcm/xenomai-3/lib/cobalt'
  CC       libcobalt_la-assert_context.lo
assert_context.c:27:33: fatal error: asm/xenomai/syscall.h: No such file or=
 directory

I enter "./include" directory, I don't find this file. How to do this issue=
?

below is my steps (on my native ls1043a board):
1> clone  git://git.xenomai.org/xenomai-3.git and checkout to branch "next"
2> ./scripts/bootstrap --with-core=3Dcobalt -enable-debug=3Dpartial
3> ./configure CFLAGS=3D"-march=3Darmv8-a" LDFLAGS=3D"-march=3Darmv8-a" --w=
ith-core=3Dcobalt --enable-smp
4> sudo make install

