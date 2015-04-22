Message-ID: <55373FBF.2000807@xenomai.org>
Date: Wed, 22 Apr 2015 08:29:19 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <9BA84827B30CBE4996725F98F7DC912342963659@SMExchange01.siebmeyer.org>
 <55363096.8070400@siemens.com>
 <9BA84827B30CBE4996725F98F7DC912364F3742C@SMExchange01.siebmeyer.org>
In-Reply-To: <9BA84827B30CBE4996725F98F7DC912364F3742C@SMExchange01.siebmeyer.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xeno3.x xeno-config --kcflags
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?windows-1252?Q?=22H=E4nel-Baas=2C_Alexander=22?= <alexander.haenel-baas@sieb-meyer.de>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/22/2015 08:14 AM, H=E4nel-Baas, Alexander wrote:
> Hi Jan
>=20
> You are right, kbuild resolve it.
>=20
> My mistake: I stored the kcflags in a variable and put this variable in t=
he EXTRA_CFLAGS from the make file.
> XENOMAI_K_CFLAGS  =3D $(shell /usr/xenomai/bin/xeno-config --rtdm --kcfla=
gs)
> EXTRA_CFLAGS +=3D $(XENOMAI_K_CFLAGS)
> The result was: EXTRA_CFLAGS=3D -Iarch/$(SRCARCH)/xenomai/include.
>=20
> So I need a second expand step from $(SRCARCH).
> My solution is the eval function:
> $(eval EXTRA_CFLAGS +=3D $(XENOMAI_K_CFLAGS))
> And now I get:  EXTRA_CFLAGS=3D -Iarch/arm/xenomai/include=20
> and now module builds are success full.
>=20
> Thank you very much for your post.
>=20

Actually, this xeno-config --kcflags I came up with is overly and
uselessly complex. Since we patch the build system for merging the
Xenomai bits into the kernel image, we could just define a plain make
variable for holding those extra flags, which depend on the file layout
of the Xenomai release patched in only, so running a script to get them
is 100% overkill.

I'll come up with something simpler in the next days, so that Makefiles
can just refer to $(RTDM_CFLAGS) or something along these lines.

--=20
Philippe.

