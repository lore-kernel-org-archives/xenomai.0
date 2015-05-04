From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Mon, 4 May 2015 06:01:12 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC912364F3F2E4@SMExchange01.siebmeyer.org>
References: <9BA84827B30CBE4996725F98F7DC912342963659@SMExchange01.siebmeyer.org>
 <55363096.8070400@siemens.com>
 <9BA84827B30CBE4996725F98F7DC912364F3742C@SMExchange01.siebmeyer.org>
 <55373FBF.2000807@xenomai.org> <5541ECF8.1090706@xenomai.org>
In-Reply-To: <5541ECF8.1090706@xenomai.org>
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

Hi Philippe,

i have applied your patch, dropped the xeno-config --kcflags from my makefi=
le and
run the prepare-kernel script.

And now, i can compile my kernel-modules without the xeno-config kcflags.


---
Alex



-----Urspr=FCngliche Nachricht-----
Von: Philippe Gerum [mailto:rpm@xenomai.org]=20
Gesendet: Donnerstag, 30. April 2015 10:51
An: H=E4nel-Baas, Alexander; Jan Kiszka
Cc: xenomai@xenomai.org
Betreff: Re: [Xenomai] Xeno3.x xeno-config --kcflags

On 04/22/2015 08:29 AM, Philippe Gerum wrote:
> On 04/22/2015 08:14 AM, H=E4nel-Baas, Alexander wrote:
>> Hi Jan
>>
>> You are right, kbuild resolve it.
>>
>> My mistake: I stored the kcflags in a variable and put this variable in =
the EXTRA_CFLAGS from the make file.
>> XENOMAI_K_CFLAGS  =3D $(shell /usr/xenomai/bin/xeno-config --rtdm=20
>> --kcflags) EXTRA_CFLAGS +=3D $(XENOMAI_K_CFLAGS) The result was:=20
>> EXTRA_CFLAGS=3D -Iarch/$(SRCARCH)/xenomai/include.
>>
>> So I need a second expand step from $(SRCARCH).
>> My solution is the eval function:
>> $(eval EXTRA_CFLAGS +=3D $(XENOMAI_K_CFLAGS)) And now I get: =20
>> EXTRA_CFLAGS=3D -Iarch/arm/xenomai/include and now module builds are=20
>> success full.
>>
>> Thank you very much for your post.
>>
>=20
> Actually, this xeno-config --kcflags I came up with is overly and=20
> uselessly complex. Since we patch the build system for merging the=20
> Xenomai bits into the kernel image, we could just define a plain make=20
> variable for holding those extra flags, which depend on the file=20
> layout of the Xenomai release patched in only, so running a script to=20
> get them is 100% overkill.
>=20
> I'll come up with something simpler in the next days, so that=20
> Makefiles can just refer to $(RTDM_CFLAGS) or something along these lines=
.
>=20

You won't need any extra CFLAGS anymore for building RTDM drivers, with thi=
s commit from the -next branch:

http://git.xenomai.org/xenomai-3.git/commit/?h=3Dnext&id=3Da3a30499b7ffd9a3=
6c18d909909b4f45bf3f710a

For these changes to take effect, you will have to run the prepare-kernel.s=
h script on a fresh kernel, so that the kernel Makefiles are patched proper=
ly.

In other words, with this changes in, you can drop the xeno-config --kcflag=
s invocation from your Makefiles building RTDM drivers.

--
Philippe.

