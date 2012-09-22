From: "Franz Engel" <franz_lambert_engel@yahoo.de>
References: <mailman.1.1348308001.4459.xenomai@xenomai.org>
	<004901cd98c5$194fc590$4bef50b0$@de> <505DBE28.1040803@xenomai.org>
In-Reply-To: <505DBE28.1040803@xenomai.org>
Date: Sat, 22 Sep 2012 15:55:04 +0200
Message-ID: <004a01cd98c9$de589c50$9b09d4f0$@de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: de
Subject: [Xenomai] Context Switch with rtnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> On 09/22/2012 03:40 PM, Gilles Chanteperdrix wrote:
> > On 09/22/2012 03:20 PM, Franz Engel wrote:
> >> On Fri, 21 Sep 2012 12:08:40 +0200, Kai Bollue <mlist1@bollue.de>
> >>> On 21.09.2012 12:02, Gilles Chanteperdrix wrote:
> >>>> On 09/21/2012 11:58 AM, Kai Bollue wrote:
> >>>>> On 14.09.2012 17:01, Franz Engel wrote:
> >>>>> Hi,
> >>>>>
> >>>>> I've a little problem. I'm using the rtnet.h-header and the
> >> following function:
> >>>>> ret =3D recvfrom ( ethernetConnection.sock, &recBuffer, sizeof (
> >>>>> recBuffer ),0, ( struct sockaddr * )
> >>>>> &ethernetConnection.dest_addr,&destlen );
> >>>> Hi,
> >>>>
> >>>> stupid question: But you do use an rtnet socket, not a normal =
one,
> >> do
> >>>> you? In this case, shouldn't it be rt_dev_recvfrom(...)?
> >>> When using the posix skin, recvfrom is substituted at compilation
> >>> (or more exactly link-edit) time with __wrap_recvfrom, implemented
> >>> in libpthread_rt.so, allowing to work with real-time sockets.
> >>>
> >>
> >> Ah, sorry, I missed that.
> >>
> >
> > Sorry, I missed to answer on some questions:
> >
> > Let me explain my problem again. When I run my program ("mytask") =
the
> > CSW and MSW increase every time the program receive a message:
> > CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
> >   0  0      0          396        0     00500080  100.0  ROOT/0
> >   1  0      0          0          0     00500080  100.0  ROOT/1
> >   0  1336   1          1          0     00300380    0.0  kogmo_man
> >   0  0      0          209        0     00000082    0.0  rtnet-stack
> >   0  0      0          1          0     00000082    0.0  rtnet-rtpc
> >   0  0      0          1          0     00000082    0.0  rtcfg-rx
> >   0  5182   1          15         0     00340182    0.0  mytask
> >   0  0      0          143        0     00000000    0.0  IRQ22:
> rteth0
> >   1  0      0          186        0     00000000    0.0  IRQ22:
> rteth0
> >   0  0      0          2054479    0     00000000    0.0  IRQ4364:
> [timer]
> >   1  0      0          547805     0     00000000    0.0  IRQ4364:
> [timer]
> >
> > Wolfgang advised me to find the reason for this phenomenon like the
> > program on this link:
> > http://www.rts.uni-
> hannover.de/xenomai/lxr/source/examples/native/sigd
> > ebug.c I tried it and modified my code (see the code further down).
> > When I insert an "cout" after "rt_task_set_mode(0, T_WARNSW, NULL);"
> I
> > get a failure message (so it should work). But when I run this
> program
> > without the cout I get no message, but the CSW and MSW counter are
> > still increases.
> >
> >
> > That's my versions:
> > rtnet 0.9.12
> > xenomai 2.5.5.2
>=20
>=20
> That is not the latest release in the 2.5 branch. You are advised to
> upgrade to 2.5.6, it should work with the same linux kernel version.
>=20
> >
>=20
> >     exec_program("${XENOMAI_DIR}/bin/xeno-config --skin=3Dnative --
> ldflags"
> > OUTPUT_VARIABLE XENOMAI_EXE_LINKER_FLAGS)
> >     set(CMAKE_EXE_LINKER_FLAGS ${CMAKE_EXE_LINKER_FLAGS}
> > ${XENOMAI_EXE_LINKER_FLAGS})
> >     exec_program("${XENOMAI_DIR}/bin/xeno-config --skin=3Dnative --
> cflags"
> > OUTPUT_VARIABLE XENOMAI_DEFINITIONS)
>=20
>=20
> Here you are retrieving the flags for the native skin, not for the
> posix skin, unless there is some other part of your makefile which =
gets
> them.

Oh, sorry. I mixed two of my demo projects. In the correct cmake file I =
use the posix skin. In my second project I use the native skin and the =
rt_dev_* commands. But it has the same result.

>=20
> >     if ( ( ethernetConnection.sock =3D socket ( AF_INET, SOCK_DGRAM,
> > IPPROTO_UDP ) ) < 0 )
>=20
> > (...)
> >     if ( bind ( ethernetConnection.sock, ( struct sockaddr * )
> > &ethernetConnection.local_addr, sizeof (
> ethernetConnection.local_addr
> ) ) <
> > 0 )
> > (...)
> >         recvfrom( ethernetConnection.sock, &recBuffer, sizeof (
> > recBuffer ),0, ( struct sockaddr * )
> > &ethernetConnection.dest_addr,&destlen );
>=20
> Here you are using the posix calls socket, bind and recvfrom. It will
> allow you to work with an RTDM socket only if you compile for the =
posix
> skin. See:
>=20
> =
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#
> Compilation_for_the_Xenomai_POSIX_skin
>=20
> Now, I have no idea why you do not get any signal when using these
> calls.

Here is my "good" cmake file:
cmake_minimum_required(VERSION 2.8)

##################################
# BEGIN OF EDITING THIS TEMPLATE #
##################################

############################################
# PLEASE ENTER HERE THE NAME OF YOUR PROJECT

set(ProjectName robotrsiVersuch)  #e.g. "robotdatalogger" (do not forget =
the quotes)

PROJECT(${ProjectName})

###############################################
# ENTER HERE THE VERSION NUMBER OF YOUR PROJECT
set(${ProjectName}_VERSION_MAJOR 1)
set(${ProjectName}_VERSION_MINOR 0)

###############################################
# ENABLE OR DIABLE THE USE OF XENOMAI AND QT
option(USE_XENOMAI	"xenomai"		ON	)
option(USE_RTNET	"rtnet"			ON	)

#############################################
# NOW ADD ALL SOURCE FILES OF YOUR PROJECT
# IF YOU'RE USING QT, ALSO ADD ALL HEADERS OF=20
# QT-OBJECTS, UI-FILES AND RESOURCES

#####################
# INCLUDE DIRECTORIES

set(MAIN_DIR ${PROJECT_SOURCE_DIR}/../..)
set(SOURCE_DIR src)


#############################################
# ENTER THE INSTALL DIRECTORY
set(INSTALLDIR ${MAIN_DIR}/bin)

set(INCLUDES
    ${SOURCE_DIR}
)


###########
# LIBRARIES

set(EXTRA_LIBS=20

)

######
# CPPs

set(SOURCES=20
	main.cpp
	src/rsiinterface.cpp
	src/rsiinterface.h
)

#############
# MOC-Headers
set(MOC_HEADERS

)

##########
# UI-Files
set(UIS

)

###########
# Resources
set(RESOURCES=20

)

##################################
#  END OF EDITING THIS TEMPLATE  #
##################################


message (STATUS "Usage of Xenomai: ${USE_XENOMAI}")
message (STATUS "Usage of RTnet: ${USE_RTNET}")

message(STATUS "Generating buid files for project ${ProjectName}, =
version =
${${ProjectName}_VERSION_MAJOR}.${${ProjectName}_VERSION_MINOR}")

include_directories(${INCLUDES})


IF(USE_XENOMAI)
    message(STATUS "Starting Xenomai configuration")

    message(STATUS "startign RTnet configuration")
    include_directories(/usr/local/rtnet/include)
    include_directories(/usr/xenomai/include/rtdm)
    message(STATUS "RTnet configuration finished")  =20

    find_library(XENO_rtdm rtdm /usr/xenomai/lib)
    set(EXTRA_LIBS ${EXTRA_LIBS} ${XENO_rtdm})
    message(STATUS ${EXTRA_LIBS} )

    set(XENOMAI_DIR "/usr/xenomai")
    set(XENOMAI_INCLUDE_DIR ${XENOMAI_DIR}/include)
    set(XENOMAI_INCLUDE_POSIX_DIR ${XENOMAI_DIR}/include/posix)

    exec_program("${XENOMAI_DIR}/bin/xeno-config --skin=3Dposix =
--ldflags" OUTPUT_VARIABLE XENOMAI_EXE_LINKER_FLAGS)
    set(CMAKE_EXE_LINKER_FLAGS ${CMAKE_EXE_LINKER_FLAGS} =
${XENOMAI_EXE_LINKER_FLAGS})
    exec_program("${XENOMAI_DIR}/bin/xeno-config --skin=3Dposix =
--cflags" OUTPUT_VARIABLE XENOMAI_DEFINITIONS)
    set(EXTRA_DEFINITIONS ${EXTRA_DEFINITIONS} ${XENOMAI_DEFINITIONS})
    ADD_DEFINITIONS(${EXTRA_DEFINITIONS})

    set(EXTRA_LIBS ${EXTRA_LIBS} rtdk)
   =20
    message(STATUS ${XENOMAI_EXE_LINKER_FLAGS})
    message(STATUS ${XENOMAI_DEFINITIONS})
    message(STATUS "Xenomai configuration finished")
ELSE(USE_XENOMAI)
    find_library(RT_TIME_LIB rt)
    set(EXTRA_LIBS ${EXTRA_LIBS} ${RT_TIME_LIB})
ENDIF(USE_XENOMAI)


IF (USE_RTNET)

ENDIF (USE_RTNET)


add_executable(${ProjectName} ${SOURCES})

TARGET_LINK_LIBRARIES(${ProjectName} ${EXTRA_LIBS})

install(TARGETS ${ProjectName} DESTINATION ${INSTALLDIR})



