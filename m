From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Date: Mon, 03 Oct 2016 09:20:49 +0200
Message-ID: <1932067.5yzClnBBlW@soho>
In-Reply-To: <fa625591-d30d-6e14-83fc-c5a98de570b0@xenomai.org>
References: <4215540.eSPgLzVGbT@soho>
 <fa625591-d30d-6e14-83fc-c5a98de570b0@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Xenomai] Regarding Xenomai and RTNET
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

El Divendres, 30 de setembre de 2016, a les 16:06:15, Philippe Gerum va=
=20
escriure:
> On 09/30/2016 02:15 PM, Leopold Palomo-Avellaneda wrote:
> > Hi,
> >=20
> >=20
> > I'm fighting with some code to run with Xenomai 3. One of the proje=
cts is
> > soem [1].
> >=20
> > The original library uses POSIX to open a raw socket to send Etherc=
at
> > messages. Our fork, uses rtnet and some Xenomai functionalities to
> > accomplish it. It has been working with 2.6.x without any problems.=

> >=20
> > OTOH, also we have done another fork fril  [2] that, using the POSI=
X
> > compatibility and rtnet use a rt_ethX device to communicate with a =
robot.
> > We have used it without any problem too with 2.6.x
> >=20
> > Now, we try to migrate all of this code to Xenomai-3 but we are hav=
ing
> > crashes all the time.
> >=20
> > With fril, a pure POSIX code, using the compatibility mode, we have=
 a
> > crash,>=20
> > showing:
> >  BUG: unable to handle kernel paging request at 00007f47ea0ef878
> >  IP: [<ffffffffa0231580>] rt_udp_ioctl+0x50/0x74 [rtudp]
> >  PGD 458887067 PUD 4590a1067 PMD 45921f067 PTE 8000000438863867
>=20
> [snip]
>=20
> > If both the program crashes "unable to handle kernel paging request=
".
>=20
> The compat mode is not related to this issue, it is merely a source c=
ode
> wrapping trick at user level, nothing more. If a driver breaks the
> kernel, then it's the driver's fault no matter what, regardless of th=
e
> input data userland might have sent.

Ok.

> You should check the RTnet stack for this. Btw, assuming your 2.6 set=
up
> relies on the original out-of-tree RTnet, and that your 3.0
> configuration relies on the RTnet code integrated in the Xenomai tree=
,
> then you end up comparing two different RTnet implementations.

I'm investigating this issue. I have found an interesting detail. I'm u=
sing=20
rt_igb module. The first time I upload the module, it's loaded (showed =
with=20
lsmod) but no rtethX interface is found. So, if I rmmod it and I load i=
t=20
again, then the rtethX are found.

Any idea why this?

In any case, we are talking to debug rtnet modules. Right?


> > Also, I have found that using the --compat parameter in xeno-config=
, the
> > values obtained (--posix --compat --cflags) makes that the applicat=
ions
> > doesn't>=20
> > compile:
> > =20
/home/leopold.palomo/fril/fril.git/src/FastResearchInterfaceLibrary/Con=
sole.cpp:50:
> > /usr/xenomai/include/trank/posix/pthread.h: In function =E2=80=98in=
t
> > pthread_set_mode_np(int, int, int*)=E2=80=99:
> > /usr/xenomai/include/trank/posix/pthread.h:55:52: error:
> > =E2=80=98pthread_setmode_np=E2=80=99 was not declared in this scope=

> >=20
> >   return pthread_setmode_np(clrmask, setmask, mask_r);
> >=20
> > I guess that there's a missing includes hidden here.
>=20
> No, it's rather an issue in the include directory chain when --compat=
 is
> enabled. Fixed in xeno-config, in the stable maintenance tree.
>=20
> > So, any idea to find a solution?
> > Do you have some example that works with xenomai-3 and rtnet?
>=20
> No, but I'm no RTnet expert.

Jan?

Leopold

--=20
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

