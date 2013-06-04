References: <1370278240.95211.YahooMailNeo@web172203.mail.ir2.yahoo.com>
	<51ACDEEF.5090302@xenomai.org>
Message-ID: <1370331439.11278.YahooMailNeo@web172202.mail.ir2.yahoo.com>
Date: Tue, 4 Jun 2013 08:37:19 +0100 (BST)
From: Franz Engel <franz_lambert_engel@yahoo.de>
In-Reply-To: <51ACDEEF.5090302@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] gcc error: posix.wrappers
Reply-To: Franz Engel <franz_lambert_engel@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

>________________________________=0A> Von: Gilles Chanteperdrix <gilles.cha=
nteperdrix@xenomai.org>=0A>An: Franz Engel <franz_lambert_engel@yahoo.de> =
=0A>CC: "xenomai@xenomai.org" <xenomai@xenomai.org> =0A>Gesendet: 20:22 Mon=
tag, 3.Juni 2013=0A>Betreff: Re: [Xenomai] gcc error: posix.wrappers=0A> =
=0A>=0A>On 06/03/2013 06:50 PM, Franz Engel wrote:=0A>=0A>> Hi,=0A>> =0A>> =
I've a little problem. When I try to compile my code with my new system (xe=
nomai 2.6.2.1) I get the following error:=0A>> gcc: error: ;-Wl,@/usr/xenom=
ai/lib/posix.wrappers: No such file or directory=0A>=0A>=0A>If the build-to=
ol you use supports pkg-config, you may find it easier to=0A>use the .pc fi=
les installed by xenomai. The posix skin library "package=0A>name" is libxe=
nomai_posix (so the .pc file is called libxenomai_posix.pc).=0A>=0A>=0A>-- =
=0A>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.=0A=0AI cha=
nged my cmake file to this:=0AIF(USE_XENOMAI)=0A=A0=A0=A0 message(STATUS "S=
tarting Xenomai configuration")=0A=A0=A0=A0 =0A=A0=A0=A0 find_package(PkgCo=
nfig)=0A=0A=A0=A0=A0 if(NOT DEFINED ENV{PKG_CONFIG_PATH})=0A=A0=A0=A0=A0=A0=
=A0=A0 set(ENV{PKG_CONFIG_PATH} $ENV{PKG_CONFIG_PATH} "/usr/xenomai/lib/pkg=
config") =0A=A0=A0=A0 endif(NOT DEFINED ENV{PKG_CONFIG_PATH})=0A=A0=A0=A0 =
=0A=A0=A0=A0 pkg_search_module(XENOMAI REQUIRED libxenomai_posix)=0A=A0=A0=
=A0 if (XENOMAI_FOUND)=0A=A0=A0=A0=A0=A0=A0=A0 message(STATUS "Start der pk=
g Ergebnisse")=0A=A0=A0=A0=A0=A0=A0=A0 message(STATUS ${XENOMAI_CFLAGS})=0A=
=A0=A0=A0=A0=A0=A0=A0 set(EXTRA_DEFINITIONS ${EXTRA_DEFINITIONS} ${XENOMAI_=
CFLAGS})=0A=A0=A0=A0=A0=A0=A0=A0 message(STATUS ${XENOMAI_LDFLAGS})=0A=A0=
=A0=A0=A0=A0=A0=A0 set(CMAKE_EXE_LINKER_FLAGS ${CMAKE_EXE_LINKER_FLAGS} ${X=
ENOMAI_LDFLAGS})=0A=A0=A0=A0=A0=A0=A0=A0 message(STATUS "Ende der pkg Ergeb=
nisse")=0A=A0=A0=A0=A0=A0=A0=A0 ADD_DEFINITIONS(${EXTRA_DEFINITIONS})=0A=A0=
=A0=A0 endif (XENOMAI_FOUND)=0A=A0=A0=A0 =0A=A0=A0=A0 message(STATUS "Xenom=
ai configuration finished")=0AENDIF(USE_XENOMAI)=0A=0AADD_DEFINITIONS(${EXT=
RA_DEFINITIONS})=0Aadd_executable(${ProjectName} ${SOURCES})=0ATARGET_LINK_=
LIBRARIES(${ProjectName} ${EXTRA_LIBS})=0Ainstall(TARGETS ${ProjectName} DE=
STINATION ${INSTALLDIR})=0A=0AIt looks like a better way then using the xen=
o-config file. But I have =0Astill the problem: gcc: error: =0A;-Wl,@//usr/=
xenomai/lib/posix.wrappers;-L/usr/xenomai/lib;-lpthread_rt;-lxenomai;-lpthr=
ead;-lrt: No such file or directory=0AIn anouther project I build a .so. Th=
at works without any problem. I just use this lines instead of the last fou=
r lines of my example above:=0A=0A=0AADD_DEFINITIONS(${EXTRA_DEFINITIONS})=
=0Aadd_library(${ProjectName} SHARED ${SOURCES})=0ATARGET_LINK_LIBRARIES(${=
ProjectName} ${EXTRA_LIBS})=0Ainstall(TARGETS ${ProjectName} DESTINATION ${=
INSTALLDIR})=0A=0A=0AAny Idea?

