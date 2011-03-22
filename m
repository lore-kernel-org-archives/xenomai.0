Message-ID: <846378.85636.qm@domain.hid>
Date: Tue, 22 Mar 2011 11:52:47 +0000 (GMT)
From: Franz Engel <franz_lambert_engel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-663053486-1300794767=:85636"
Subject: [Xenomai-help] Problem with Posix Skin and RTnet
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0-663053486-1300794767=:85636
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,
I've a little problem. I began a new project where I've to use Kdevelop. So=
 I thought it is a good idea to work with cmake-project and the posix skin =
to get a more commone code. I want to use RTnet for my communication. But I=
 think that Xenomai don't use the RTnet-Driver. I got the message:
"Cannot assign requested address" from the function "ret=3Drecvfrom(socket,=
 &buffer, sizeof(buffer), (struct sockaddr *)&dest_addr, &sizeof(dest_addr)=
)"
I think the problem is that Xenomai use the standart recvfrom and the stand=
art recvfrom can not recognize the realtime driver. I use the following cma=
ke file:
=A0
PROJECT(robotclient)
cmake_minimum_required(VERSION 2.8)
=A0
set(Robot_Client_VERSION_MAJOR 1)
set(Robot_Client_VERSION_MINOR 0)
=A0
set(XENOMAI_SEARCH_PATH "/usr/xenomai" "/usr/local/xenomai")
find_path(${XENOMAI_DIR} "include/xeno_config.h" ${XENOMAI_SEARCH_PATH})
=A0
IF(${XENOMAI_DIR})
=A0=A0 set(XENOMAI_INCLUDE_DIR ${XENOMAI_DIR}/include)
=A0=A0 set(XENOMAI_INCLUDE_POSIX_DIR ${XENOMAI_DIR}/include/posix)
=A0
=A0=A0 find_library(XENOMAI_LIBRARY_XENOMAI xenomai ${XENOMAI_DIR}/lib)
=A0=A0 find_library(XENOMAI_LIBRARY_PTHREAD_RT pthread_rt ${XENOMAI_DIR}/li=
b)
=A0=A0 find_library(XENOMAI_LIBRARY_RTDM rtdm ${XENOMAI_DIR}/lib)
=A0=A0 find_library(XENOMAI_LIBRARY_RT rt ${XENOMAI_DIR}/lib)
=A0
=A0 set(EXTRA_LIBS ${EXTRA_LIBS} ${XENOMAI_LIBRARY_XENOMAI})
=A0=A0 set(EXTRA_LIBS ${EXTRA_LIBS} ${XENOMAI_LIBRARY_PTHREAD_RT})
=A0=A0 set(EXTRA_LIBS ${EXTRA_LIBS} ${XENOMAI_LIBRARY_RTDM})
=A0=A0 set(EXTRA_LIBS ${EXTRA_LIBS} ${XENOMAI_LIBRARY_RT})
=A0
=A0=A0 find_file(XENOMAI_POSIX_WRAPPERS lib/posix.wrappers=A0 {XENOMAI_SEAR=
CH_PATH})
=A0
=A0=A0 set(XENOMAI_EXE_LINKER_FLAGS "-W1,@${XENOMAI_POSIX_WRAPPERS}")
=A0=A0 set(CMAKE_EXE_LINKER_FLAGS ${CMAKE_EXE_LINKER_FLAGS} ${XENOMAI_EXE_L=
INKER_FLAGS})
=A0
=A0=A0 set(XENOMAI_DEFINITIONS "-D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__=
XENO__")
=A0=A0 set(EXTRA_DEFINITIONS ${EXTRA_DEFINITIONS} ${XENOMAI_DEFINITIONS})
=A0
=A0=A0 include_directories(${XENOMAI_DIR}/include)
=A0=A0 include_directories(${XENOMAI_DIR}/include/posix)
ENDIF(${XENOMAI_DIR})
=A0
ADD_DEFINITIONS(${EXTRA_DEFINITIONS})
ADD_EXECUTABLE(robotclient main.cpp)
TARGET_LINK_LIBRARIES(robotclient ${EXTRA_LIBS})

Is there something wrong?
=A0
regards,
=A0=A0=A0 franz=0A=0A
--0-663053486-1300794767=:85636
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><DIV>Hello,</DIV>
<DIV>I've a little problem. I began a new project where I've to use Kdevelo=
p. So I thought it is a good idea to work with cmake-project and the posix =
skin to get a more commone code. I want to use RTnet for my communication. =
But I think that Xenomai don't use the RTnet-Driver. I got the message:<BR>=
"Cannot assign requested address" from the function "ret=3Drecvfrom(socket,=
 &amp;buffer, sizeof(buffer), (struct sockaddr *)&amp;dest_addr, &amp;sizeo=
f(dest_addr))"<BR>I think the problem is that Xenomai use the standart recv=
from and the standart recvfrom can not recognize the realtime driver. I use=
 the following cmake file:</DIV>
<DIV>&nbsp;</DIV>
<DIV>PROJECT(robotclient)</DIV>
<DIV>cmake_minimum_required(VERSION 2.8)</DIV>
<DIV>&nbsp;</DIV>
<DIV>set(Robot_Client_VERSION_MAJOR 1)<BR>set(Robot_Client_VERSION_MINOR 0)=
</DIV>
<DIV>&nbsp;</DIV>
<DIV>set(XENOMAI_SEARCH_PATH "/usr/xenomai" "/usr/local/xenomai")<BR>find_p=
ath(${XENOMAI_DIR} "include/xeno_config.h" ${XENOMAI_SEARCH_PATH})</DIV>
<DIV>&nbsp;</DIV>
<DIV>IF(${XENOMAI_DIR})<BR>&nbsp;&nbsp; set(XENOMAI_INCLUDE_DIR ${XENOMAI_D=
IR}/include)<BR>&nbsp;&nbsp; set(XENOMAI_INCLUDE_POSIX_DIR ${XENOMAI_DIR}/i=
nclude/posix)</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp; find_library(XENOMAI_LIBRARY_XENOMAI xenomai ${XENOMAI_DI=
R}/lib)<BR>&nbsp;&nbsp; find_library(XENOMAI_LIBRARY_PTHREAD_RT pthread_rt =
${XENOMAI_DIR}/lib)<BR>&nbsp;&nbsp; find_library(XENOMAI_LIBRARY_RTDM rtdm =
${XENOMAI_DIR}/lib)<BR>&nbsp;&nbsp; find_library(XENOMAI_LIBRARY_RT rt ${XE=
NOMAI_DIR}/lib)</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp; set(EXTRA_LIBS ${EXTRA_LIBS} ${XENOMAI_LIBRARY_XENOMAI})<BR>&nb=
sp;&nbsp; set(EXTRA_LIBS ${EXTRA_LIBS} ${XENOMAI_LIBRARY_PTHREAD_RT})<BR>&n=
bsp;&nbsp; set(EXTRA_LIBS ${EXTRA_LIBS} ${XENOMAI_LIBRARY_RTDM})<BR>&nbsp;&=
nbsp; set(EXTRA_LIBS ${EXTRA_LIBS} ${XENOMAI_LIBRARY_RT})</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp; find_file(XENOMAI_POSIX_WRAPPERS lib/posix.wrappers&nbsp;=
 {XENOMAI_SEARCH_PATH})</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp; set(XENOMAI_EXE_LINKER_FLAGS "-W1,@${XENOMAI_POSIX_WRAPPE=
RS}")<BR>&nbsp;&nbsp; set(CMAKE_EXE_LINKER_FLAGS ${CMAKE_EXE_LINKER_FLAGS} =
${XENOMAI_EXE_LINKER_FLAGS})</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp; set(XENOMAI_DEFINITIONS "-D_GNU_SOURCE -D_REENTRANT -Wall=
 -pipe -D__XENO__")<BR>&nbsp;&nbsp; set(EXTRA_DEFINITIONS ${EXTRA_DEFINITIO=
NS} ${XENOMAI_DEFINITIONS})</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp; include_directories(${XENOMAI_DIR}/include)<BR>&nbsp;&nbs=
p; include_directories(${XENOMAI_DIR}/include/posix)<BR>ENDIF(${XENOMAI_DIR=
})</DIV>
<DIV>&nbsp;</DIV>
<DIV>ADD_DEFINITIONS(${EXTRA_DEFINITIONS})<BR>ADD_EXECUTABLE(robotclient ma=
in.cpp)<BR>TARGET_LINK_LIBRARIES(robotclient ${EXTRA_LIBS})</DIV>
<DIV><BR>Is there something wrong?</DIV>
<DIV>&nbsp;</DIV>
<DIV>regards,<BR>&nbsp;&nbsp;&nbsp; franz</DIV></td></tr></table><br>
--0-663053486-1300794767=:85636--

