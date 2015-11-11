Date: Wed, 11 Nov 2015 10:22:28 +0100 (CET)
From: g.strobbe@telenet.be
Message-ID: <752993598.201105477.1447233748728.JavaMail.root@telenet.be>
In-Reply-To: <20151110142814.GA4629@hermes.click-hack.org>
References: <5641F09E.3040608@free.fr>
 <20151110142814.GA4629@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] panic macro interference with xerces api.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


----- Original Message -----
> From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> To: "St=C3=A9phane ANCELOT" <sancelot@free.fr>
> Cc: xenomai@xenomai.org
> Sent: Tuesday, November 10, 2015 3:28:14 PM
> Subject: Re: [Xenomai] panic macro interference with xerces api.
>=20
> On Tue, Nov 10, 2015 at 02:26:54PM +0100, St=C3=A9phane ANCELOT wrote:
> > Hi,
> >=20
> > I don't know if there might be a  big impact, but I noticed, depending
> > on the order we include headers , that
> > there was a panic macro interfering with xercesc api headers.
> >=20
> > #include <alchemy/task.h>
> > #include <xercesc/dom/DOMException.hpp>
> >=20
> >=20
> > /usr/xenomai-3.0-igb/include/boilerplate/ancillaries.h:64:10: error:
> > expected identifier before '__func__'
> >    __panic(__func__, __fmt, ##__args)
>=20
> Well, if the two headers define the same macro, there are not many
> solutions: arrange for not having to include them in the same file.
> It should not be too hard, since a real-time thread using
> alchemy/task.h has no business using an xml library, probably only
> using linux services which a real-time task can not use without
> switching to secondary mode.
>=20
> --
> =09=09=09=09=09    Gilles.
> https://click-hack.org
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://xenomai.org/mailman/listinfo/xenomai
>=20

I recently had a similar issue with the macro

#define panic(__fmt, __args...)=09=09=09\
=09__panic(__func__, __fmt, ##__args)

defined in ancillaries.h

The preprocessor modified virtual void panic(const PanicHandler::PanicReaso=
ns reason) =3D 0;

in the included xercesc/util/PanicHandler.hpp

resulting in a compilation error.

>From the gcc preprocessor manual https://gcc.gnu.org/onlinedocs/cpp/Undefin=
ing-and-Redefining-Macros.html#Undefining-and-Redefining-Macros

If a macro ceases to be useful, it may be undefined with the =E2=80=98#unde=
f=E2=80=99 directive. =E2=80=98#undef=E2=80=99 takes a single argument, the=
 name of the macro to undefine. You use the bare macro name, even if the ma=
cro is function-like. It is an error if anything appears on the line after =
the macro name. =E2=80=98#undef=E2=80=99 has no effect if the name is not a=
 macro. =20

So after the #include <alchemy/task.h> I placed
           =20
#undef panic

No problems since. Should also be fine as a solution, no?

Best regards,

Gino




