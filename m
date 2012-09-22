From: "Franz Engel" <franz_lambert_engel@yahoo.de>
References: <mailman.1.1348308001.4459.xenomai@xenomai.org>
In-Reply-To: <mailman.1.1348308001.4459.xenomai@xenomai.org>
Date: Sat, 22 Sep 2012 15:20:55 +0200
Message-ID: <004901cd98c5$194fc590$4bef50b0$@de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: xenomai@xenomai.org

> On Fri, 21 Sep 2012 12:08:40 +0200, Kai Bollue <mlist1@bollue.de>
> > On 21.09.2012 12:02, Gilles Chanteperdrix wrote:
> >> On 09/21/2012 11:58 AM, Kai Bollue wrote:
> >>> On 14.09.2012 17:01, Franz Engel wrote:
> >>> Hi,
> >>>
> >>> I've a little problem. I'm using the rtnet.h-header and the
> following function:
> >>> ret = recvfrom ( ethernetConnection.sock, &recBuffer, sizeof (
> >>> recBuffer ),0, ( struct sockaddr * )
> >>> &ethernetConnection.dest_addr,&destlen );
> >> Hi,
> >>
> >> stupid question: But you do use an rtnet socket, not a normal one,
> do
> >> you? In this case, shouldn't it be rt_dev_recvfrom(...)?
> > When using the posix skin, recvfrom is substituted at compilation (or
> > more exactly link-edit) time with __wrap_recvfrom, implemented in
> > libpthread_rt.so, allowing to work with real-time sockets.
> >
> 
> Ah, sorry, I missed that.
> 

Sorry, I missed to answer on some questions:

Let me explain my problem again. When I run my program ("mytask") the CSW
and MSW increase every time the program receive a message:
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          396        0     00500080  100.0  ROOT/0
  1  0      0          0          0     00500080  100.0  ROOT/1
  0  1336   1          1          0     00300380    0.0  kogmo_man
  0  0      0          209        0     00000082    0.0  rtnet-stack
  0  0      0          1          0     00000082    0.0  rtnet-rtpc
  0  0      0          1          0     00000082    0.0  rtcfg-rx
  0  5182   1          15         0     00340182    0.0  mytask
  0  0      0          143        0     00000000    0.0  IRQ22: rteth0
  1  0      0          186        0     00000000    0.0  IRQ22: rteth0
  0  0      0          2054479    0     00000000    0.0  IRQ4364: [timer]
  1  0      0          547805     0     00000000    0.0  IRQ4364: [timer]

Wolfgang advised me to find the reason for this phenomenon like the program
on this link:
http://www.rts.uni-hannover.de/xenomai/lxr/source/examples/native/sigdebug.c
I tried it and modified my code (see the code further down). When I insert
an "cout" after "rt_task_set_mode(0, T_WARNSW, NULL);" I get a failure
message (so it should work). But when I run this program without the cout I
get no message, but the CSW and MSW counter are still increases.  


That's my versions:
rtnet 0.9.12
xenomai 2.5.5.2
linux kernel 2.6.32-20
ubuntu 10.04
i-pipe patch: adeos-ipipe-2.6.32.20-x86-2.7-03.patch
NIC driver: 8139too
CPU: Intel vPro


Any other ideas? Or is it not a problem but the normal state that the
counters increases?

Here is the code of my cmake-file:
cmake_minimum_required(VERSION 2.8)

##################################
# BEGIN OF EDITING THIS TEMPLATE #
##################################

############################################
# PLEASE ENTER HERE THE NAME OF YOUR PROJECT

set(ProjectName robotrsiVersuch)  #e.g. "robotdatalogger" (do not forget the
quotes)

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
# IF YOU'RE USING QT, ALSO ADD ALL HEADERS OF 
# QT-OBJECTS, UI-FILES AND RESOURCES

#####################
# INCLUDE DIRECTORIES

set(MAIN_DIR ${PROJECT_SOURCE_DIR}/../..)
set(SOURCE_DIR src)


#############################################
# ENTER THE INSTALL DIRECTORY
# added by stefan.thumfart@profactor.at
set(INSTALLDIR ${MAIN_DIR}/bin)

set(INCLUDES
    ${SOURCE_DIR}
)


###########
# LIBRARIES

set(EXTRA_LIBS 

)

######
# CPPs

set(SOURCES 
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
set(RESOURCES 

)

##################################
#  END OF EDITING THIS TEMPLATE  #
##################################


message (STATUS "Usage of Xenomai: ${USE_XENOMAI}")
message (STATUS "Usage of RTnet: ${USE_RTNET}")

message(STATUS "Generating buid files for project ${ProjectName}, version
${${ProjectName}_VERSION_MAJOR}.${${ProjectName}_VERSION_MINOR}")

include_directories(${INCLUDES})


IF(USE_XENOMAI)
    message(STATUS "Starting Xenomai configuration")

    message(STATUS "startign RTnet configuration")
    include_directories(/usr/local/rtnet/include)
    include_directories(/usr/xenomai/include/rtdm)
    message(STATUS "RTnet configuration finished")   

    find_library(XENO_rtdm rtdm /usr/xenomai/lib)
    set(EXTRA_LIBS ${EXTRA_LIBS} ${XENO_rtdm})
    message(STATUS ${EXTRA_LIBS} )

    set(XENOMAI_DIR "/usr/xenomai")
    set(XENOMAI_INCLUDE_DIR ${XENOMAI_DIR}/include)
    set(XENOMAI_INCLUDE_POSIX_DIR ${XENOMAI_DIR}/include/native)

    exec_program("${XENOMAI_DIR}/bin/xeno-config --skin=native --ldflags"
OUTPUT_VARIABLE XENOMAI_EXE_LINKER_FLAGS)
    set(CMAKE_EXE_LINKER_FLAGS ${CMAKE_EXE_LINKER_FLAGS}
${XENOMAI_EXE_LINKER_FLAGS})
    exec_program("${XENOMAI_DIR}/bin/xeno-config --skin=native --cflags"
OUTPUT_VARIABLE XENOMAI_DEFINITIONS)
    set(EXTRA_DEFINITIONS ${EXTRA_DEFINITIONS} ${XENOMAI_DEFINITIONS})
    ADD_DEFINITIONS(${EXTRA_DEFINITIONS})

    set(EXTRA_LIBS ${EXTRA_LIBS} rtdk)
    
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

And this is my cpp:
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <getopt.h>
#include <execinfo.h>
#include <sys/mman.h>

#include <stdexcept>
#include <arpa/inet.h>
#include <native/task.h>
#include "rtdk.h"
#include <rtnet.h>


#define RECBUFFERSIZE 600
#define SENDBUFFERSIZE 300

RT_TASK task;
const char *reason_str[7];

struct conn_t
{
    int sock;
    struct sockaddr_in dest_addr;
    struct sockaddr_in local_addr;
};

struct conn_t getSocket ()
{
    struct conn_t ethernetConnection;

    //ethernetConnection.dest_addr.sin_family         = AF_INET;
    ethernetConnection.dest_addr.sin_addr.s_addr    = inet_addr
("192.168.100.12");
    ethernetConnection.dest_addr.sin_port           = htons (6002);
    
    //ethernetConnection.local_addr.sin_family        = AF_INET;
    ethernetConnection.local_addr.sin_addr.s_addr   = inet_addr
("192.168.100.11");
    ethernetConnection.local_addr.sin_port          = htons (6008);

    if ( ( ethernetConnection.sock = socket ( AF_INET, SOCK_DGRAM,
IPPROTO_UDP ) ) < 0 )
    {
        throw std::runtime_error("Can not open socket");
    }
    else
    {
    }

    if ( bind ( ethernetConnection.sock, ( struct sockaddr * )
&ethernetConnection.local_addr, sizeof ( ethernetConnection.local_addr ) ) <
0 )
    {
        close ( ethernetConnection.sock );
        throw std::runtime_error("Can not bind socket");
    }
    else
    {
    }

    return ethernetConnection;
}

void task_body (void *cookie)
{  
    char recBuffer[RECBUFFERSIZE];

    socklen_t destlen;
    
    struct conn_t ethernetConnection;
    
    ethernetConnection = getSocket();

    destlen = sizeof ( ethernetConnection.dest_addr );
    
    int k;
    
    rt_task_set_mode(0, T_WARNSW, NULL);
    
    for(k=0;k<1000;k++)
    {
        recvfrom( ethernetConnection.sock, &recBuffer, sizeof ( recBuffer
),0, ( struct sockaddr * ) &ethernetConnection.dest_addr,&destlen );
	
        //ret = rt_dev_sendto ( ethernetConnection.sock, &sendBuffer, strlen
( sendBuffer ) +1, 0, ( struct sockaddr * )
&ethernetConnection.dest_addr,destlen);
    }
}


void warn_upon_switch(int sig, siginfo_t *si, void *context)
{
    unsigned int reason = si->si_value.sival_int;
    void *bt[32];
    int nentries;
    
    printf("\nSIGDEBUG received, reason %d: %s\n", reason,
           reason <= SIGDEBUG_WATCHDOG ? reason_str[reason] : "<unknown>");
    /* Dump a backtrace of the frame which caused the switch to
       secondary mode: */
    nentries = backtrace(bt,sizeof(bt) / sizeof(bt[0]));
    backtrace_symbols_fd(bt,nentries,fileno(stdout));
}

int main (int argc, char **argv)
{
    struct sigaction sa;
    int err;

    reason_str[SIGDEBUG_UNDEFINED] = "undefined";
    reason_str[SIGDEBUG_MIGRATE_SIGNAL] = "received signal";
    reason_str[SIGDEBUG_MIGRATE_SYSCALL] = "invoked syscall";
    reason_str[SIGDEBUG_MIGRATE_FAULT] = "triggered fault";
    reason_str[SIGDEBUG_MIGRATE_PRIOINV] = "affected by priority inversion";
    reason_str[SIGDEBUG_NOMLOCK] = "missing mlockall";
    reason_str[SIGDEBUG_WATCHDOG] = "runaway thread";
    
    mlockall(MCL_CURRENT | MCL_FUTURE);
    
    //rt_print_auto_init(0);

    sigemptyset(&sa.sa_mask);
    sa.sa_sigaction = warn_upon_switch;
    sa.sa_flags = SA_SIGINFO;
    sigaction(SIGDEBUG, &sa, NULL);

    err = rt_task_create(&task,"mytask",0,1,T_FPU);

    if (err) {
      fprintf(stderr,"failed to create task, code %d\n",err);
      return 0;
    }

    err = rt_task_start(&task,&task_body,NULL);

    if (err) {
      fprintf(stderr,"failed to start task, code %d\n",err);
      return 0;
    }

    pause();

    return 0;
}



