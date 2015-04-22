From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Wed, 22 Apr 2015 06:46:39 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC912364F3B490@SMExchange01.siebmeyer.org>
References: <9BA84827B30CBE4996725F98F7DC912342963659@SMExchange01.siebmeyer.org>
 <55363096.8070400@siemens.com>
 <9BA84827B30CBE4996725F98F7DC912364F3742C@SMExchange01.siebmeyer.org>
 <55373FBF.2000807@xenomai.org>
In-Reply-To: <55373FBF.2000807@xenomai.org>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Xeno3.x xeno-config --kcflags
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Philippe

Good idea, I'm still waiting.

---
Alexander


-----Urspr=FCngliche Nachricht-----
Von: Philippe Gerum [mailto:rpm@xenomai.org]=20
Gesendet: Mittwoch, 22. April 2015 08:29
An: H=E4nel-Baas, Alexander; Jan Kiszka
Cc: xenomai@xenomai.org
Betreff: Re: [Xenomai] Xeno3.x xeno-config --kcflags

On 04/22/2015 08:14 AM, H=E4nel-Baas, Alexander wrote:
> Hi Jan
>=20
> You are right, kbuild resolve it.
>=20
> My mistake: I stored the kcflags in a variable and put this variable in t=
he EXTRA_CFLAGS from the make file.
> XENOMAI_K_CFLAGS  =3D $(shell /usr/xenomai/bin/xeno-config --rtdm=20
> --kcflags) EXTRA_CFLAGS +=3D $(XENOMAI_K_CFLAGS) The result was:=20
> EXTRA_CFLAGS=3D -Iarch/$(SRCARCH)/xenomai/include.
>=20
> So I need a second expand step from $(SRCARCH).
> My solution is the eval function:
> $(eval EXTRA_CFLAGS +=3D $(XENOMAI_K_CFLAGS)) And now I get: =20
> EXTRA_CFLAGS=3D -Iarch/arm/xenomai/include and now module builds are=20
> success full.
>=20
> Thank you very much for your post.
>=20

Actually, this xeno-config --kcflags I came up with is overly and uselessly=
 complex. Since we patch the build system for merging the Xenomai bits into=
 the kernel image, we could just define a plain make variable for holding t=
hose extra flags, which depend on the file layout of the Xenomai release pa=
tched in only, so running a script to get them is 100% overkill.

I'll come up with something simpler in the next days, so that Makefiles can=
 just refer to $(RTDM_CFLAGS) or something along these lines.

--
Philippe.

