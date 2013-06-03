Message-ID: <1370278240.95211.YahooMailNeo@web172203.mail.ir2.yahoo.com>
Date: Mon, 3 Jun 2013 17:50:40 +0100 (BST)
From: Franz Engel <franz_lambert_engel@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] gcc error: posix.wrappers
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

Hi,=0A=0AI've a little problem. When I try to compile my code with my new s=
ystem (xenomai 2.6.2.1) I get the following error:=0Agcc: error: ;-Wl,@/usr=
/xenomai/lib/posix.wrappers: No such file or directory=0A=0AThe=0A file pos=
ix.wrappers exits in the /usr/xenomai/lib-directory. =0AFuthermore, if move=
 this file to anywhere else I get this message:=0A/home/profit/Work/Develop=
ment/bv_ProFIT_guidePC_shared/bin/libkogmo_rtdb.so: undefined reference to =
`pthread_mutexattr_settype'=0A/home/profit/Work/Development/bv_ProFIT_guide=
PC_shared/bin/libkogmo_rtdb.so: undefined reference to `clock_gettime'=0A/h=
ome/profit/Work/Development/bv_ProFIT_guidePC_shared/bin/libkogmo_rtdb.so:=
=0A undefined reference to `pthread_condattr_setpshared'=0A/home/profit/Wor=
k/Development/bv_ProFIT_guidePC_shared/bin/libkogmo_rtdb.so: undefined refe=
rence to=0A `pthread_mutexattr_setprotocol'=0A/home/profit/Work/Development=
/bv_ProFIT_guidePC_shared/bin/libkogmo_rtdb.so: undefined reference to `shm=
_unlink'=0A/home/profit/Work/Development/bv_ProFIT_guidePC_shared/bin/libko=
gmo_rtdb.so: undefined reference to `pthread_kill'=0A/home/profit/Work/Deve=
lopment/bv_ProFIT_guidePC_shared/bin/libkogmo_rtdb.so:=0A undefined referen=
ce to `pthread_mutexattr_setpshared'=0A/home/profit/Work/Development/bv_Pro=
FIT_guidePC_shared/bin/libkogmo_rtdb.so: undefined reference to `mq_send'=
=0A/home/profit/Work/Development/bv_ProFIT_guidePC_shared/bin/libkogmo_rtdb=
.so: undefined reference to `mq_unlink'=0A/home/profit/Work/Development/bv_=
ProFIT_guidePC_shared/bin/libkogmo_rtdb.so: undefined reference to `pthread=
_join'=0A/home/profit/Work/Development/bv_ProFIT_guidePC_shared/bin/libkogm=
o_rtdb.so: undefined reference to `pthread_create'=0A/home/profit/Work/Deve=
lopment/bv_ProFIT_guidePC_shared/bin/libkogmo_rtdb.so: undefined reference=
=0A to `pthread_mutexattr_init'=0A/home/profit/Work/Development/bv_ProFIT_g=
uidePC_shared/bin/libkogmo_rtdb.so: undefined reference to `pthread_mutexat=
tr_destroy'=0A/home/profit/Work/Development/bv_ProFIT_guidePC_shared/bin/li=
bkogmo_rtdb.so: undefined reference to `mq_getattr'=0A/home/profit/Work/Dev=
elopment/bv_ProFIT_guidePC_shared/bin/libkogmo_rtdb.so: undefined reference=
 to `shm_open'=0A/home/profit/Work/Development/bv_ProFIT_guidePC_shared/bin=
/libkogmo_rtdb.so: undefined reference to `mq_receive'=0A/home/profit/Work/=
Development/bv_ProFIT_guidePC_shared/bin/libkogmo_rtdb.so: undefined refere=
nce to `mq_close'=0A/home/profit/Work/Development/bv_ProFIT_guidePC_shared/=
bin/libkogmo_rtdb.so: undefined reference to `mq_open'=0Acollect2: ld retur=
ned 1 exit status=0A=0A=0ADoes=0A somebody know what does it mean? Is it po=
ssible that the error refers =0Ato the commands inside the file and not to =
the file itself?=0A=0AI use the following cmake=0A commands:=0Acmake_minimu=
m_required(VERSION 2.8)=0A=0A##################################=0A# BEGIN O=
F EDITING THIS TEMPLATE #=0A##################################=0A=0A#######=
#####################################=0A# PLEASE ENTER HERE THE NAME OF YOU=
R PROJECT=0A=0Aset(ProjectName "kogmo_man")=0A=0APROJECT(${ProjectName})=0A=
=0A###############################################=0A# ENTER HERE THE VERSI=
ON NUMBER OF YOUR PROJECT=0Aset(${ProjectName}_VERSION_MAJOR 1)=0Aset(${Pro=
jectName}_VERSION_MINOR 0)=0A=0A###########################################=
####=0A# ENABLE OR DIABLE THE USE OF XENOMAI AND QT=0Aoption(USE_XENOMAI=A0=
=A0=A0 =A0=A0=A0 "xenomai"=A0=A0=A0 ON=A0=A0=A0 )=0Aoption(USE_RTDB=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 "rtdb"=A0=A0=A0 =A0=A0=A0 ON=A0=A0=A0 )=0Aoption(US=
E_RTDB_DEBUG=A0=A0=A0 =A0=A0=A0 "rtdb_debug"=A0=A0=A0=0A OFF=A0=A0=A0 )=0Ao=
ption(USE_RTMALLOC_SUBA=A0=A0=A0 "suba"=A0=A0=A0 =A0=A0=A0 ON=A0=A0=A0 )=0A=
=0A=0A#############################################=0A# NOW ADD ALL SOURCE =
FILES OF YOUR PROJECT=0A# IF YOU'RE USING QT, ALSO ADD ALL HEADERS OF =0A# =
QT-OBJECTS, UI-FILES AND RESOURCES=0A=0A#####################=0A# INCLUDE D=
IRECTORIES=0Aset(MAIN_DIR ${PROJECT_SOURCE_DIR}/../..)=0Aset(RTDB_INC ../in=
clude)=0A=0A#############################################=0A# ENTER THE INS=
TALL DIRECTORY=0Aset(INSTALLDIR ${MAIN_DIR}/bin)=0A=0Ainclude_directories(=
=0A=A0=A0=A0 ${RTDB_INC}=0A)=0A=0A###########=0A# LIBRARIES=0A=0Aset(EXTRA_=
LIBS =0A=0A)=0A=0A######=0A# CPPs=0A=0Aset(SOURCES =0A=A0=A0=A0 main.c=0A)=
=0A=0A###########=0A# Resources=0Aset(RESOURCES =0A=0A)=0A=0A##############=
####################=0A#=A0 END OF EDITING THIS TEMPLATE=A0=0A #=0A########=
##########################=0A=0A=0Amessage ("Usage of Xenomai: =A0=A0=A0 =
=A0=A0=A0 ${USE_XENOMAI}")=0Amessage ("Usage of RTDB Debugger:=A0=A0=A0 ${U=
SE_RTDB_DEBUG}")=0Amessage ("Usage of RTDB: =A0=A0=A0 =A0=A0=A0 ${USE_RTDB}=
")=0Amessage ("If there's something wrong with these values, run rm -r * in=
 the build directory")=0A=0Amessage(STATUS=0A "Generating buid files for pr=
oject ${ProjectName}, version =0A${${ProjectName}_VERSION_MAJOR}.${${Projec=
tName}_VERSION_MINOR}")=0A=0Ainclude_directories(${INCLUDES})=0A=0AIF(USE_X=
ENOMAI)=0A=A0=A0=A0 message(STATUS "Starting Xenomai configuration")=0A=A0=
=A0=A0 =0A=A0=A0=A0 set(XENOMAI_DIR "/usr/xenomai")=0A=A0=A0=A0 set(XENOMAI=
_INCLUDE_DIR ${XENOMAI_DIR}/include)=0A=A0=A0=A0 set(XENOMAI_INCLUDE_POSIX_=
DIR ${XENOMAI_DIR}/include/posix)=0A=0A=A0=A0=A0 execute_process(COMMAND=0A=
 "${XENOMAI_DIR}/bin/xeno-config" "--skin=3Dposix" "--ldflags" OUTPUT_VARIA=
BLE XENOMAI_EXE_LINKER_FLAGS)=0A=A0=A0=A0 set(CMAKE_EXE_LINKER_FLAGS ${CMAK=
E_EXE_LINKER_FLAGS} ${XENOMAI_EXE_LINKER_FLAGS})=0A=A0=A0=A0 execute_proces=
s(COMMAND "${XENOMAI_DIR}/bin/xeno-config" "--skin=3Dposix" "--cflags" OUTP=
UT_VARIABLE XENOMAI_DEFINITIONS)=0A=A0=A0=A0 set(EXTRA_DEFINITIONS ${EXTRA_=
DEFINITIONS} ${XENOMAI_DEFINITIONS})=0A=A0=A0=A0 ADD_DEFINITIONS(${EXTRA_DE=
FINITIONS})=0A=0A=0A=A0=A0=A0 set(EXTRA_LIBS ${EXTRA_LIBS} rtdk)=0A=A0=A0=
=A0 =0A=A0=A0=A0 message(STATUS ${XENOMAI_EXE_LINKER_FLAGS})=0A=A0=A0=A0 me=
ssage(STATUS ${XENOMAI_DEFINITIONS})=0A=A0=A0=A0 message(STATUS "Xenomai co=
nfiguration finished")=0AELSE(USE_XENOMAI)=0A=A0=A0=A0 set(EXTRA_DEFINITION=
S ${EXTRA_DEFINITIONS} "-O2 -fno-strict-aliasing -Wstrict-prototypes -O2 -g=
 -Wall")=0A=A0=A0=A0=0A set(EXTRA_DEFINITIONS ${EXTRA_DEFINITIONS} "-D_GNU_=
SOURCE -D_REENTRANT")=0A=A0=A0=A0 find_library(THREAD_LIB pthread ../usr/li=
b)=0A=A0=A0=A0 set(EXTRA_LIBS ${EXTRA_LIBS} ${THREAD_LIB})=0A=A0=A0=A0 find=
_library(C_LIB c ../usr/lib)=0A=A0=A0=A0 set(EXTRA_LIBS ${EXTRA_LIBS} ${C_L=
IB})=0A=A0=A0=A0 find_library(RT_LIB rt ../usr/lib)=0A=A0=A0=A0 set(EXTRA_L=
IBS ${EXTRA_LIBS} ${RT_LIB})=0AENDIF(USE_XENOMAI)=0A=0AIF (USE_RTDB)=0A=A0=
=A0=A0 message(STATUS "startign RTDB configuration")=0A=A0=A0=A0 set(KOGMO_=
DIR ../)=0A=A0=A0=A0 find_library(KOGMO_LIBRARY_KOGMO_RTDB kogmo_rtdb ${KOG=
MO_DIR}../bin)=0A=A0=A0=A0 set(EXTRA_LIBS ${EXTRA_LIBS} ${KOGMO_LIBRARY_KOG=
MO_RTDB})=0A=A0=A0=A0 include_directories(${KOGMO_DIR}/include)=0A=A0=A0=A0=
 include_directories(${KOGMO_DIR}/../bin)=0A=A0=A0=A0 message(STATUS "RTDB =
configuration finished")=0AENDIF=0A (USE_RTDB)=0A=0AIF(USE_RTDB_DEBUG)=0A=
=A0=A0=A0 set(EXTRA_DEFINITIONS ${EXTRA_DEFINITIONS} "-DDEBUG=3D1023")=0AEN=
DIF(USE_RTDB_DEBUG)=0A=0AIF(USE_RTMALLOC_SUBA)=0A=A0=A0=A0 set(KOGMO_DEFINI=
TIONS "-DRTMALLOC_suba")=0A=A0=A0=A0 set(EXTRA_DEFINITIONS ${EXTRA_DEFINITI=
ONS} ${KOGMO_DEFINITIONS})=0AENDIF(USE_RTMALLOC_SUBA)=0A=0A=0AADD_DEFINITIO=
NS(${EXTRA_DEFINITIONS})=0A=0Aadd_executable(${ProjectName} ${SOURCES})=0A=
=0ATARGET_LINK_LIBRARIES(${ProjectName} ${EXTRA_LIBS})=0A=0Ainstall(TARGETS=
 ${ProjectName} DESTINATION ${INSTALLDIR})=0A=0A=0AThanks,=0A=A0=A0=A0 Fran=
z
