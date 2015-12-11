Date: Fri, 11 Dec 2015 14:20:12 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151211132012.GA24775@hermes.click-hack.org>
References: <2004286.fnOG18ZY9A@soho>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2004286.fnOG18ZY9A@soho>
Subject: Re: [Xenomai] Porting a library to Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: Xenomai list <xenomai@xenomai.org>

On Fri, Dec 11, 2015 at 01:44:01PM +0100, Leopold Palomo-Avellaneda wrote:
> Hi,
>=20
> I'm working to make a library to work with Xenomai. It's a library that h=
as a=20
> thread and open a socket to communicate with an external device via netwo=
rk.
>=20
> I have read the guide "Porting a Linux application to Xenomai dual kernel=
 [1]"=20
> but still I have some doubts in some details. So, here my topics without =
any=20
> importance order:
>=20
> - What is the recommended way to obtain the link, flags, etc information =
to=20
> build an application that use Xenomai? xeno-config, pkg-config, some buil=
d=20
> macros to find the information, ...=20

Quoting the document you say you have read:
"Compilation flags

To ease that task, the xeno-config script, installed when compiling
Xenomai user-space support, is able to give you these flags. (...)=20
Beware: this way of obtaining the compilation flags is recommended,
if for anything because it will make using a different release of
Xenomai easier: the flags may change between two different releases."=20

>=20
> - I would like to have a code that could be used with an Standard POSIX o=
r a=20
> Xenomai. I thought that protecting my code with some #ifdef __XENO__ I co=
uld=20
> choose which part is specific to Xenomai and which no. However, I'm a bit=
=20
> confused, because then, I don't understand what is the utility of the wra=
p=20
> script. Please, could you elaborate a bit more this part, especially focu=
sed=20
> in an application the could use an standard network interface or rtnet=20
> version.

Quoting the documentation again: "Use of Linux original services

It may happen that you would like to use Linux services instead of
Xenomai POSIX skin overloaded services. In this case, the =96wrap
mechanism described in section Under the hood: the =96wrap flag.
offers a solution: prefix the name of the service you would like to
use with the __real_ prefix, such as, for instance
__real_pthread_create.

If you do that, and would still want to be able to compile your
application without Xenomai (it may be a good idea, as it allows,
for instance, to run your application with valgrind, which you can
not do with an application compiled for Xenomai), Xenomai
compilation flags define a preprocessor macro (__XENO__) which
allows you to know whether or not you are compiling the application
for Xenomai. You can use it for instance in the following way:

 /* Open a plain Linux UDP socket. */
 #ifndef __XENO__
       fd =3D socket(PF_INET, SOCK_DGRAM, 0);
 #else /* __XENO__ */
       fd =3D __real_socket(PF_INET, SOCK_DGRAM, 0);
 #endif /* __XENO__ */
"

>=20
> - In the document, there's a section about the mlockall option. So, may I=
=20
> understand that from xenomai <=3D 2.6.3 it's not needed that I call the m=
lockall=20
> function?

Quoting the documentation again: "
Starting with version 2.6.3, as part of their initialization,
Xenomai libraries systematically call mlockall to commit and lock
the whole application memory.
(...)
Before version 2.6.3

Xenomai POSIX library only invoked mlockall if the
=96enable-posix-auto-mlockall option was passed to the configure
script when compiling Xenomai user-space support. So, applications
which did not want to depend on this configuration had to call
mlockall by themselves, before using any Xenomai service, by using:=20

 mlockall(MCL_CURRENT | MCL_FUTURE);"


--=20
					    Gilles.
https://click-hack.org

