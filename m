Date: Mon, 10 Feb 2020 22:29:18 +0100
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: Migrate project from Debian 8 Xenomai 2.x to Debain 9 Xenomai 3.x
Message-ID: <20200210222918.37d1e803@md1za8fc.ad001.siemens.net>
In-Reply-To: <373cc865d6c34dda997ac6745bae99cd@RCDC-MAIL09.corp.diehl.com>
References: <23edaf750b0b41ef9a129bbaf2758d9f@RCDC-MAIL09.corp.diehl.com>
 <0281e4a5-a2b2-bac5-1e30-ea2bb85f3d8d@siemens.com>
 <373cc865d6c34dda997ac6745bae99cd@RCDC-MAIL09.corp.diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Carsten EHRMANN via Xenomai <xenomai@xenomai.org>
Cc: Carsten EHRMANN <Carsten.Ehrmann@diehl.com>, Jan Kiszka <jan.kiszka@siemens.com>

Hi Carsten,

the sniplets look like cmake. There are more cmake-xenomai-users
around, i would suggest to dig in the archive of the mailinglist. AFAIK
there have been contributions that did not get merged but will probably
solve your problem.

If that is the case we should keep in mind that xenomai users seem to
like cmake and consider those cmake patches more relevant for the
project.

regards,
Henning

On Mon, 10 Feb 2020 14:20:04 +0000
Carsten EHRMANN via Xenomai <xenomai@xenomai.org> wrote:

> Hi Jan,
>=20
> do I have to include the xeno-config file? I just configured it with
> "xeno-config --skin=3Dnative".
>=20
> I use a project file where includes are defined, see below:
>=20
> unix {
> TEMPLATE =3D app
> } else {
> TEMPLATE =3D vcapp
> }
> CONFIG -=3D qt
> CONFIG +=3D debug_and_release warn_on exceptions rtti=20
> Debug {
>     TARGET =3D CSRTDaemon
>     CONFIG +=3D console
>     OBJECTS_DIR =3D ../tmp/obj/CSRTDaemon/debug
>     DESTDIR =3D ../lib/CSRTDaemon
>     DLLDESTDIR =3D ../dll/CSRTDaemon
>     SCOPE=3Ddebug
>     unix {
>         QMAKE_CXXFLAGS +=3D=20
>         QMAKE_CFLAGS +=3D=20
>         QMAKE_LFLAGS +=3D
>     } else {
>         QMAKE_POST_LINK =3D COPY /Y ../lib/CSRTDaemon/*.pdb
> ../dll/CSRTDaemon/ }
> } else {
>     TARGET =3D CSRTDaemon
>     OBJECTS_DIR =3D ../tmp/obj/CSRTDaemon/release
>     DESTDIR =3D ../lib/CSRTDaemon
>     DLLDESTDIR =3D ../dll/CSRTDaemon
>     DEFINES +=3D QT_NO_DEBUG_OUTPUT NDEBUG
>     SCOPE=3Drelease
> }
>=20
>=20
> QMAKE_LIBDIR +=3D /usr/xenomai/lib
> INCLUDEPATH +=3D /usr/xenomai/include
>=20
>=20
>=20
>=20
> _________________________________________________________________________=
________________________________
> Bitte =C3=BCberlegen Sie, ob Sie diese Nachricht wirklich ausdrucken
> m=C3=BCssen/ before printing, think about environmental responsibility.
> Diehl Metering GmbH, Industriestra=C3=9Fe 13, 91522 Ansbach Telefon + 49
> 981 1806 0, Telefax +49 981 1806 615 Sitz der Gesellschaft: Ansbach,
> Registergericht: Ansbach HRB 69 Gesch=C3=A4ftsf=C3=BChrer: Dr. Christof B=
osbach
> (Sprecher), Thomas Gastner, Jean-Fran=C3=A7ois Marguet Der Inhalt der
> vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enth=C3=A4lt
> vertrauliche und/oder rechtlich gesch=C3=BCtzte Informationen. Informieren
> Sie uns bitte, wenn Sie diese E-Mail f=C3=A4lschlicherweise erhalten
> haben. Bitte l=C3=B6schen Sie in diesem Fall die Nachricht. Jede
> unerlaubte Form der Reproduktion, Bekanntgabe, =C3=84nderung, Verteilung
> und/oder Publikation dieser E-Mail ist strengstens untersagt. The
> contents of the above mentioned e-mail is not legally binding. This
> e-mail contains confidential and/or legally protected information.
> Please inform us if you have received this e-mail by mistake and
> delete it in such a case. Each unauthorized reproduction, disclosure,
> alteration, distribution and/or publication of this e-mail is
> strictly prohibited. Informationen zum Datenschutz finden Sie auf
> unserer Homepage.
> https://www.diehl.com/metering/de/diehl-metering/data-protection
> Information about data protection can be found on our homepage.
> https://www.diehl.com/metering/en/diehl-metering/data-protection
>=20
>=20
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>=20
> Sent: Monday, February 10, 2020 2:23 PM
> To: Carsten EHRMANN <Carsten.Ehrmann@diehl.com>; xenomai@xenomai.org
> Subject: Re: Migrate project from Debian 8 Xenomai 2.x to Debain 9
> Xenomai 3.x
>=20
> On 10.02.20 13:03, Carsten EHRMANN via Xenomai wrote:
> > Hello,
> >=20
> >=20
> > Because of new PC hardware I have to use debain 9 and Xenomai 3.=20
> > Xenomai is running on the system, I run the testsuite scripts. I
> > found a migration document on xenomai.org and changed the
> > includepaths and so on in my sourcecode. But now when I want to
> > compile the code I got this error In file included from
> > ./CSRTPosixQue.h:20:0, from ./CSRTTask.h:20, from main.cpp:26:
> > /usr/xenomai/include/trank/native/task.h: In function 'int
> > rt_task_notify(RT_TASK*, rt_sigset_t)':
> > /usr/xenomai/include/trank/native/task.h:41:64: error:
> > 'trank_warning' was not declared in this scope
> > trank_warning("in-kernel native API is gone, rebase over RTDM");
> >=20
> > But this "trank_warning" is defined in trank.h which is included
> >  =20
>=20
> Where you using xeno-config to obtain paths and other compiler
> switches? If not, please compare your settings. If yes, a simple test
> case would be nice. But it can't be very simple because
>=20
> #include <native/task.h>
> int main() {}
>=20
> compiles via "gcc $(xeno-config --skin native --cflags) ..."
>=20
> Jan
>=20
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate
> Competence Center Embedded Linux


