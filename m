Message-ID: <1373196748.98256.YahooMailNeo@web172204.mail.ir2.yahoo.com>
Date: Sun, 7 Jul 2013 12:32:28 +0100 (BST)
From: Franz Engel <franz_lambert_engel@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Problem with shared memory (no entry in /dev/shm)
Reply-To: Franz Engel <franz_lambert_engel@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,=0A=0ACurrently I'm upgrading my system to Xenomai 2.6.2.1 and the Linux=
 kernel 3.5.7. Everything looks fine. I see the services starting in the dm=
esg and the latency test runs without problems (besides some high latencies=
 :-)). But I have a problem with the shared memory. When I run my project i=
n the old system, everything works fine and I saw an entry in /dev/shm. Wit=
h my new system I get segmentations faults when I try to write to the share=
d memory I created. Futhermore I have no entries in /dev/shm. If I compile =
the code (in my cmake file it is possible to change between "normal" compil=
ing and compiling with xenomai) without xenomai everything works good and I=
 get an entry in /dev/shm. Does somebody else have the same problems with t=
he shared memory in the new xenomai version or is something wrong with my c=
ode. Here is a small example with the corresponding cmake-file (I get no er=
rors):=0A=0A#include <errno.h>=0A#include <fcntl.h>anybody=0A=0Aint main(in=
t argc, char *argv[])=0A{=0A=A0=A0=A0 int fd =3D shm_open("MeinSHM", O_CREA=
T | O_RDWR, 0777);=0A=A0=A0=A0 if (fd =3D=3D -1)=0A=A0=A0=A0 {=0A=A0=A0=A0 =
printf("shm_open: %d\n", errno);=0A=A0=A0=A0 return -errno;=0A=A0=A0=A0 }=
=0A=0A=A0=A0=A0 if (ftruncate(fd, 65536))=0A=A0=A0=A0 {=0A=A0=A0=A0 printf(=
"ftruncate: %d\n", errno);=0A=A0=A0=A0 }=0A=A0=A0=A0 exit(0);=0A}=0A=0AI us=
e this cmake file:=0Acmake_minimum_required(VERSION 2.8)=0A=0A#############=
#####################=0A# BEGIN OF EDITING THIS TEMPLATE #=0A##############=
####################=0A=0A############################################=0A# =
PLEASE ENTER HERE THE NAME OF YOUR PROJECT=0A=0Aset(ProjectName "kogmo_man"=
)=0A=0APROJECT(${ProjectName})=0A=0A#######################################=
########=0A# ENTER HERE THE VERSION NUMBER OF YOUR PROJECT=0Aset(${ProjectN=
ame}_VERSION_MAJOR 1)=0Aset(${ProjectName}_VERSION_MINOR 0)=0A=0A##########=
#####################################=0A# ENABLE OR DIABLE THE USE OF XENOM=
AI AND QT=0Aoption(${ProjectName}_USE_XENOMAI=A0=A0=A0 =A0=A0=A0 "xenomai"=
=A0=A0=A0 OFF=A0=A0=A0 )=0A=0A=0Aset(INSTALLDIR ${MAIN_DIR}/bin)=0A=0A=0A##=
####=0A# CPPs=0Aset(SOURCES =0A=A0=A0=A0 main.c=0A)=0A=0A=0Amessage ("Usage=
 of Xenomai: =A0=A0=A0 =A0=A0=A0 ${${ProjectName}_USE_XENOMAI}")=0A=0AIF(${=
ProjectName}_USE_XENOMAI)=0A=A0=A0=A0 message(STATUS "Starting Xenomai conf=
iguration")=0A=A0=A0=A0 =0A=A0=A0=A0 find_package(PkgConfig)=0A=0A=A0=A0=A0=
 if(NOT DEFINED ENV{PKG_CONFIG_PATH})=0A=A0=A0=A0=A0=A0=A0=A0 set(ENV{PKG_C=
ONFIG_PATH} $ENV{PKG_CONFIG_PATH} "/usr/xenomai/lib/pkgconfig") =0A=A0=A0=
=A0 endif(NOT DEFINED ENV{PKG_CONFIG_PATH})=0A=A0=A0=A0 =0A=A0=A0=A0 pkg_se=
arch_module(XENOMAI libxenomai_posix)=0A=A0=A0=A0 if (XENOMAI_FOUND)=0A=A0=
=A0=A0=A0=A0=A0=A0 set(EXTRA_DEFINITIONS ${EXTRA_DEFINITIONS} ${XENOMAI_CFL=
AGS})=0A=A0=A0=A0=A0=A0=A0=A0 set(EXTRA_LIBS ${EXTRA_LIBS} ${XENOMAI_LDFLAG=
S})=0A=A0=A0=A0=A0=A0=A0=A0 ADD_DEFINITIONS(${EXTRA_DEFINITIONS})=0A=A0=A0=
=A0 else(XENOMAI_FOUND)=0A=A0=A0=A0=A0=A0=A0=A0 set(XENOMAI_DIR "/usr/xenom=
ai")=0A=A0=A0=A0=A0=A0=A0=A0 set(XENOMAI_INCLUDE_DIR ${XENOMAI_DIR}/include=
)=0A=A0=A0=A0=A0=A0=A0=A0 set(XENOMAI_INCLUDE_POSIX_DIR ${XENOMAI_DIR}/incl=
ude/posix)=0A=A0=A0=A0=A0=A0=A0=A0 exec_program("${XENOMAI_DIR}/bin/xeno-co=
nfig --skin=3Dposix --ldflags" OUTPUT_VARIABLE XENOMAI_EXE_LINKER_FLAGS)=0A=
=A0=A0=A0=A0=A0=A0=A0 set(CMAKE_EXE_LINKER_FLAGS ${CMAKE_EXE_LINKER_FLAGS} =
${XENOMAI_EXE_LINKER_FLAGS})=0A=A0=A0=A0=A0=A0=A0=A0 exec_program("${XENOMA=
I_DIR}/bin/xeno-config --skin=3Dposix --cflags" OUTPUT_VARIABLE XENOMAI_DEF=
INITIONS)=0A=A0=A0=A0=A0=A0=A0=A0 set(EXTRA_DEFINITIONS ${EXTRA_DEFINITIONS=
} ${XENOMAI_DEFINITIONS})=0A=A0=A0=A0=A0=A0=A0=A0 ADD_DEFINITIONS(${EXTRA_D=
EFINITIONS})=0A=A0=A0=A0=A0=A0=A0=A0 set(EXTRA_LIBS ${EXTRA_LIBS} rtdk)=0A=
=A0=A0=A0 endif (XENOMAI_FOUND)=0A=A0=A0=A0 =0A=A0=A0=A0 message(STATUS "Xe=
nomai configuration finished")=0AELSE(${ProjectName}_USE_XENOMAI)=0A=A0=A0=
=A0 set(EXTRA_DEFINITIONS ${EXTRA_DEFINITIONS} "-O2 -fno-strict-aliasing -W=
strict-prototypes -O2 -g -Wall")=0A=A0=A0=A0 set(EXTRA_DEFINITIONS ${EXTRA_=
DEFINITIONS} "-D_GNU_SOURCE -D_REENTRANT")=0A=A0=A0=A0 find_library(THREAD_=
LIB pthread ../usr/lib)=0A=A0=A0=A0 set(EXTRA_LIBS ${EXTRA_LIBS} ${THREAD_L=
IB})=0A=A0=A0=A0 find_library(C_LIB c ../usr/lib)=0A=A0=A0=A0 set(EXTRA_LIB=
S ${EXTRA_LIBS} ${C_LIB})=0A=A0=A0=A0 find_library(RT_LIB rt ../usr/lib)=0A=
=A0=A0=A0 set(EXTRA_LIBS ${EXTRA_LIBS} ${RT_LIB})=0AENDIF(${ProjectName}_US=
E_XENOMAI)=0A=0A=0AADD_DEFINITIONS(${EXTRA_DEFINITIONS})=0A=0Aadd_executabl=
e(${ProjectName} ${SOURCES})=0A=0ATARGET_LINK_LIBRARIES(${ProjectName} ${EX=
TRA_LIBS})=0A=0Ainstall(TARGETS ${ProjectName} DESTINATION ${INSTALLDIR})
