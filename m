Date: Fri, 16 May 2008 11:10:08 +0200
Message-Id: <1165612730@domain.hid>
MIME-Version: 1.0
From: Paradoxxa2001@domain.hid
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help]
 =?iso-8859-15?q?at91sam9263_and_user-space_support?=
 =?iso-8859-15?q?_compile_fails?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I checked the linux-2.6.24/arch/arm/Makefile file.
OBJCOPYFLAGS is like these in the referenced Patch.

Thomas

-----Urspr=FCngliche Nachricht-----
Von: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
Gesendet: 16.05.08 10:45:01
An: Paradoxxa2001@domain.hid
CC: xenomai@xenomai.org
Betreff: Re: [Xenomai-help] at91sam9263 and user-space support compile fai=
ls

On Fri, May 16, 2008 at 10:15 AM,  <Paradoxxa2001@domain.hid> wrote:
> Hi,
>
> actual i working with the CodeSourcery 2008q1 toolchain. When im buildin=
g the
> user-space support it seem to work fine. Then im also compiled the kerne=
l with this
> toolchain. The Image file which i get is about 4,7MB big. My System prov=
ide just
> less then 4MB space for the Kernel Image. With my first compiler i got k=
ernel images
> with the size of 1,6MB. I also checked the Optimization Level, but that =
isn't the cause.
> What do you think about that=3F

This is a known issue. Use a more recent kernel, or patch the arch
Makefile as indicated here:
http://lists.arm.linux.org.uk/lurker/message/20080508.101225.d54f8f71.en.h=
tml

--=20
 Gilles



=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Unbegrenzter Speicherplatz f=FCr Ihr E-Mail Postfach=3F Jetzt aktivieren!
http://freemail.web.de/club/landingpage.htm/=3Fmc=3D025555


