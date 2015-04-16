Message-ID: <552F7BD2.5030700@xenomai.org>
Date: Thu, 16 Apr 2015 11:07:30 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <9BA84827B30CBE4996725F98F7DC912342962F15@SMExchange01.siebmeyer.org>
In-Reply-To: <9BA84827B30CBE4996725F98F7DC912342962F15@SMExchange01.siebmeyer.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] porting issue Xeno2 Xeno3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?windows-1252?Q?=22H=E4nel-Baas=2C_Alexander=22?= <alexander.haenel-baas@sieb-meyer.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/16/2015 08:59 AM, H=E4nel-Baas, Alexander wrote:
> Hi Philippe
>=20
> Thank you for your reply.
>=20
> I know this document. In the section "Using the Transition Kit" is descri=
bed how to use the xeno-config script.
> So I call the script with:
> usr/xenomai/bin/xeno-config --skin=3Dnative --cflags
>=20
> and get:
> -I/usr/xenomai/include/trank -D__XENO_COMPAT__ -I/usr/xenomai/include/cob=
alt -I/usr/xenomai/include -march=3Darmv7-a -mfpu=3Dvfp3 -D_GNU_SOURCE -D_R=
EENTRANT -D__COBALT__ -I/usr/xenomai/include/alchemy
>=20
> I get this info to set the right cflags/ldflags in my own environment.
>=20
> In the document stands alchemy is the native skin, so I set the include p=
ath to alchemy. In this case I get some undefined errors.
> When I changed the include path to trank the compiler are lucky. Because =
the trank/native/timer.h include the /alchemy/timer too.

I'm unsure to understand what you want to achieve or at least where the
problem stands, so here is a bit of background in case that helps.
Alchemy is the evolution in x3 of the former native API from x2 which is
10 years old, the name was changed because referring to "native" causes
confusion, particularly when Xenomai can run in dual kernel or
single/native kernel configuration.

As this API was revised, some differences appeared with the former
specification: 1) to fix usability issues, 2) to make it seamlessly
usable over single and dual kernel configurations indifferently.

For this reason, Alchemy does depart in some cases from the former
"native" skin, I assume this is the undefined symbols you are referring to.

For this reason the so-called "Transition Kit" (aka libtrank) was
introduced, to provide a compatibility layer on top of Alchemy, which
hides most of the differences using wrappers when this can be done.
This package makes sense for building apps running in dual kernel mode
only (i.e. Cobalt).

So, building an application currently running on the legacy "native" API
with the CFLAGS returned by "xeno-config --alchemy --cflags" could
require you to fix up that application, in order to cope with the
changes described in the migration guide.

If you don't want to do that, then using the transition kit by passing
the CFLAGS obtained from "xeno-config --native --cflags" may allow you
to run your application over the Alchemy skin unmodified in most cases.

The only feature that was dropped and not emulated by libtrank is the
set of former RT_INTR services. Applications that have to synchronize on
IRQ receipts from user-space over x3 should implement a UDD mini-driver,
which is like UIO for dual kernel mode:
http://www.xenomai.org/documentation/xenomai-3/html/xeno3prm/group__rtdm__u=
dd.html

Basically, to build for Alchemy, you will have to pull headers from
[$sysroot/]$xenomai_prefix/include/alchemy. This is what the --cflags
switch gives along with --alchemy.

For enabling the compatibility mode, one would need to 1) define
__XENO_COMPAT__ 2) pull headers from
[$sysroot/]$xenomai_prefix/include/trank _and_
[$sysroot/]$xenomai_prefix/include/alchemy, in that order. This is what
the --cflags switch gives along with --native.

In addition, -I[$sysroot/]$xenomai_prefix/include is always required
since all Xenomai headers are referring to files prefixed by their
package name, e.g. <alchemy/timer.h>. This is the recommended practice
with the Xenomai API headers, except for the POSIX files from
include/cobalt obviously.

>=20
> Now I am not sure which is the right include path when I will used the na=
tive api alchemy.
>=20
> Sorry for that detailed question, but I can't use the xeno-config script =
in my cross environment directly. I need a sysroot directive to
> set the include path correct to the installed xenomai headers under my sy=
sroot path, and not to the host path.
>=20

You can achieve this using xeno-config as well:

$ DESTDIR=3D$sysroot/$xenomai_prefix xeno-config ...

--=20
Philippe.

