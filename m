MIME-Version: 1.0
In-Reply-To: <C159A093-EA69-4903-8114-145C4355A0C0@domain.hid>
References: <AANLkTinRyxZ-BB_VwB2XPYwIPik8to_eynd-c-nNulQ1@domain.hid>
	<4C19EDA4.2030601@domain.hid> <4C1A040F.4030209@domain.hid>
	<AANLkTikMtR9kMd424sXIUdULJlaRxKIlJ19ElJ4Pt4o1@domain.hid>
	<C159A093-EA69-4903-8114-145C4355A0C0@domain.hid>
Date: Sat, 19 Jun 2010 15:34:39 +0800
Message-ID: <AANLkTim91ABqsvWb_GqMhOwnDlIQNfz1qoE-ABWc3KGE@mail.gmail.com>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] application make file
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bruno Rouchouse <brouchouse@domain.hid>
Cc: xenomai@xenomai.org

On Fri, Jun 18, 2010 at 7:40 PM, Bruno Rouchouse <brouchouse@domain.hid> wro=
te:
> Hi,
> if you haven't found it yet and if I understood correctly your question,
> xeno-config is probably what you need here ;)
> "xeno-config
> is=A0a=A0script=A0that=A0is=A0used=A0to=A0to=A0display=A0the=A0compiler=
=A0and=A0linker=A0flags=A0that=A0are=A0required=A0for=A0building=A0applicat=
ions=A0that=A0use=A0Xenomai."
> Regards,
> --Bruno
> Le 17 juin 2010 =E0 17:39, Everett Wang a =E9crit :
>
> On Thu, Jun 17, 2010 at 7:16 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>
> Gilles Chanteperdrix wrote:
>
> Everett Wang wrote:
>
> Hi All,
>
> Now my application based user space xenomai has a few files and I want
>
> to construct a Makefile to compile them. I looked at the
>
> Makefiles in examples folder. It is not straight forward to modify one
>
> for myself. I have c files and header files. =A0It is possible to get
>
> a makefile with minor changes so it can automatically find the
>
> dependence of c and h files?
>
> You can do this quite easily with GNU make.
>
> Namely:
>
> http://www.gnu.org/software/make/manual/html_node/Automatic-Prerequisites=
.html#Automatic-Prerequisites
>
> --
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>
>
> Thanks Gilles,
>
> I can construct a Makefile for a non realtime application
> with multiple files. What I don't know are the extra flags
> for compiling and linking that xenomai requires. My
> thinking is that after I have a normal (non xenomai) Makefile,
> I can just add the compile flags when I compile each of the files
> and add linking flags to produce a real time final program.
>
> Everett
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>

Thanks for the help. I touched cross-link.c then a "make -n" to find out th=
e
xenomai flags.  I added these flags to my normal make file. It compiles
and runs fine now.

compiler flags:
CFLAGS_XENO =3D -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall
-pipe -D__XENO__

linker flags:
LDFLAGS_XENO =3D -L/usr/xenomai/lib -lxenomai -lpthread  -lnative -lrtdm
-Xlinker -rpath -Xlinker /usr/xenomai/lib

Hopefully it can be useful for new xenomai users.

Best regards,

Everett

