From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Tue, 4 Jun 2013 11:07:33 -0400
Message-ID: <20130604150733.GT11182@csclub.uwaterloo.ca>
References: <1370278240.95211.YahooMailNeo@web172203.mail.ir2.yahoo.com>
	<51ACDEEF.5090302@xenomai.org>
	<1370331439.11278.YahooMailNeo@web172202.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1370331439.11278.YahooMailNeo@web172202.mail.ir2.yahoo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] gcc error: posix.wrappers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Franz Engel <franz_lambert_engel@yahoo.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Jun 04, 2013 at 08:37:19AM +0100, Franz Engel wrote:
> I changed my cmake file to this:
> IF(USE_XENOMAI)
> =C2=A0=C2=A0=C2=A0 message(STATUS "Starting Xenomai configuration")
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 find_package(PkgConfig)
>=20
> =C2=A0=C2=A0=C2=A0 if(NOT DEFINED ENV{PKG_CONFIG_PATH})
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set(ENV{PKG_CONFIG_PATH} $EN=
V{PKG_CONFIG_PATH} "/usr/xenomai/lib/pkgconfig")=20
> =C2=A0=C2=A0=C2=A0 endif(NOT DEFINED ENV{PKG_CONFIG_PATH})
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 pkg_search_module(XENOMAI REQUIRED libxenomai_posix)
> =C2=A0=C2=A0=C2=A0 if (XENOMAI_FOUND)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 message(STATUS "Start der pk=
g Ergebnisse")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 message(STATUS ${XENOMAI_CFL=
AGS})
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set(EXTRA_DEFINITIONS ${EXTR=
A_DEFINITIONS} ${XENOMAI_CFLAGS})
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 message(STATUS ${XENOMAI_LDF=
LAGS})
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set(CMAKE_EXE_LINKER_FLAGS $=
{CMAKE_EXE_LINKER_FLAGS} ${XENOMAI_LDFLAGS})
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 message(STATUS "Ende der pkg=
 Ergebnisse")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADD_DEFINITIONS(${EXTRA_DEFI=
NITIONS})
> =C2=A0=C2=A0=C2=A0 endif (XENOMAI_FOUND)
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 message(STATUS "Xenomai configuration finished")
> ENDIF(USE_XENOMAI)
>=20
> ADD_DEFINITIONS(${EXTRA_DEFINITIONS})
> add_executable(${ProjectName} ${SOURCES})
> TARGET_LINK_LIBRARIES(${ProjectName} ${EXTRA_LIBS})
> install(TARGETS ${ProjectName} DESTINATION ${INSTALLDIR})
>=20
> It looks like a better way then using the xeno-config file. But I have=20
> still the problem: gcc: error:=20
> ;-Wl,@//usr/xenomai/lib/posix.wrappers;-L/usr/xenomai/lib;-lpthread_rt;=
-lxenomai;-lpthread;-lrt: No such file or directory
> In anouther project I build a .so. That works without any problem. I ju=
st use this lines instead of the last four lines of my example above:

Clearly something is using ';' as a delimiter where you don't want one.

I wasn't even aware xenomai used cmake.  I just assumed it had plain
old simple to understand makefiles.  I guess if I ever had a need to
poke at how it builds I would know.  Or are these makefiles for your
own project that uses xenomai?

I would think it is your EXTRA_LIBS that is wrong.

--=20
Len Sorensen

