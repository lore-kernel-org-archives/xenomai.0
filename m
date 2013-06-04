References: <1370278240.95211.YahooMailNeo@web172203.mail.ir2.yahoo.com>
	<51ACDEEF.5090302@xenomai.org>
	<1370331439.11278.YahooMailNeo@web172202.mail.ir2.yahoo.com>
Message-ID: <1370333700.8301.YahooMailNeo@web172204.mail.ir2.yahoo.com>
Date: Tue, 4 Jun 2013 09:15:00 +0100 (BST)
From: Franz Engel <franz_lambert_engel@yahoo.de>
In-Reply-To: <1370331439.11278.YahooMailNeo@web172202.mail.ir2.yahoo.com>
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

----- Urspr=FCngliche Message -----=0A=0A> Von: Franz Engel <franz_lambert_=
engel@yahoo.de>=0A> An: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.=
org>=0A> CC: "xenomai@xenomai.org" <xenomai@xenomai.org>=0A> Gesendet: 9:37=
 Dienstag, 4.Juni 2013=0A> Betreff: Re: [Xenomai] gcc error: posix.wrappers=
=0A> =0A>> ________________________________=0A>>  Von: Gilles Chanteperdrix=
 <gilles.chanteperdrix@xenomai.org>=0A>> An: Franz Engel <franz_lambert_eng=
el@yahoo.de> =0A>> CC: "xenomai@xenomai.org" <xenomai@xenomai.org> =0A>> Ge=
sendet: 20:22 Montag, 3.Juni 2013=0A>> Betreff: Re: [Xenomai] gcc error: po=
six.wrappers=0A>> =0A>> =0A>> On 06/03/2013 06:50 PM, Franz Engel wrote:=0A=
>> =0A>>>  Hi,=0A>>> =0A>>>  I've a little problem. When I try to compile m=
y code with my new =0A> system (xenomai 2.6.2.1) I get the following error:=
=0A>>>  gcc: error: ;-Wl,@/usr/xenomai/lib/posix.wrappers: No such file or =
=0A> directory=0A>> =0A>> =0A>> If the build-tool you use supports pkg-conf=
ig, you may find it easier to=0A>> use the .pc files installed by xenomai. =
The posix skin library "package=0A>> name" is libxenomai_posix (so the .pc =
file is called =0A> libxenomai_posix.pc).=0A>> =0A>> =0A>> -- =0A>> =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.=0A> =0A> I changed =
my cmake file to this:=0A> IF(USE_XENOMAI)=0A> =A0=A0=A0 message(STATUS "St=
arting Xenomai configuration")=0A> =A0=A0=A0 =0A> =A0=A0=A0 find_package(Pk=
gConfig)=0A> =0A> =A0=A0=A0 if(NOT DEFINED ENV{PKG_CONFIG_PATH})=0A> =A0=A0=
=A0=A0=A0=A0=A0 set(ENV{PKG_CONFIG_PATH} $ENV{PKG_CONFIG_PATH} =0A> "/usr/x=
enomai/lib/pkgconfig") =0A> =A0=A0=A0 endif(NOT DEFINED ENV{PKG_CONFIG_PATH=
})=0A> =A0=A0=A0 =0A> =A0=A0=A0 pkg_search_module(XENOMAI REQUIRED libxenom=
ai_posix)=0A> =A0=A0=A0 if (XENOMAI_FOUND)=0A> =A0=A0=A0=A0=A0=A0=A0 messag=
e(STATUS "Start der pkg Ergebnisse")=0A> =A0=A0=A0=A0=A0=A0=A0 message(STAT=
US ${XENOMAI_CFLAGS})=0A> =A0=A0=A0=A0=A0=A0=A0 set(EXTRA_DEFINITIONS ${EXT=
RA_DEFINITIONS} ${XENOMAI_CFLAGS})=0A> =A0=A0=A0=A0=A0=A0=A0 message(STATUS=
 ${XENOMAI_LDFLAGS})=0A> =A0=A0=A0=A0=A0=A0=A0 set(CMAKE_EXE_LINKER_FLAGS $=
{CMAKE_EXE_LINKER_FLAGS} ${XENOMAI_LDFLAGS})=0A> =A0=A0=A0=A0=A0=A0=A0 mess=
age(STATUS "Ende der pkg Ergebnisse")=0A> =A0=A0=A0=A0=A0=A0=A0 ADD_DEFINIT=
IONS(${EXTRA_DEFINITIONS})=0A> =A0=A0=A0 endif (XENOMAI_FOUND)=0A> =A0=A0=
=A0 =0A> =A0=A0=A0 message(STATUS "Xenomai configuration finished")=0A> END=
IF(USE_XENOMAI)=0A> =0A> ADD_DEFINITIONS(${EXTRA_DEFINITIONS})=0A> add_exec=
utable(${ProjectName} ${SOURCES})=0A> TARGET_LINK_LIBRARIES(${ProjectName} =
${EXTRA_LIBS})=0A> install(TARGETS ${ProjectName} DESTINATION ${INSTALLDIR}=
)=0A> =0A> It looks like a better way then using the xeno-config file. But =
I have =0A> still the problem: gcc: error: =0A> ;-Wl,@//usr/xenomai/lib/pos=
ix.wrappers;-L/usr/xenomai/lib;-lpthread_rt;-lxenomai;-lpthread;-lrt: =0A> =
No such file or directory=0A> In anouther project I build a .so. That works=
 without any problem. I just use =0A> this lines instead of the last four l=
ines of my example above:=0A> =0A> =0A> ADD_DEFINITIONS(${EXTRA_DEFINITIONS=
})=0A> add_library(${ProjectName} SHARED ${SOURCES})=0A> TARGET_LINK_LIBRAR=
IES(${ProjectName} ${EXTRA_LIBS})=0A> install(TARGETS ${ProjectName} DESTIN=
ATION ${INSTALLDIR})=0A> =0A> =0A> Any Idea?=0A>=0A=0AO.k. I solved my prob=
lem. If I set the XENOMAI_LDFLAGS to the CMAKE_EXE_LINKER_FLAGS it doesn't =
work. But if I set it direct to the EXTRA_LIBS and link them with TARGET_LI=
NK_LIBRARIES(${ProjectName} ${EXTRA_LIBS}) it works perfect.=0A

