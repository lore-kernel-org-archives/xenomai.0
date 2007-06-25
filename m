From: Paul <paul_c@domain.hid>
Date: Mon, 25 Jun 2007 19:04:04 +0100
References: <467FBC67.8030805@domain.hid>
In-Reply-To: <467FBC67.8030805@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UOAgGUXCAD/1FI4"
Message-Id: <200706251904.04510.paul_c@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and mlockall
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--Boundary-00=_UOAgGUXCAD/1FI4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 25 June 2007 14:00, Johan Borkhuis wrote:
> Is there a way to "tweak" the CAP_IPC_LOCK capability of the system or
> the task so that I can run mlockall call, or is there a way to disable
> this check on Xenomai?

See attached source - It needs to be linked to libcap. Once compiled, set 
user/group to root along with the sticky flag (chmod a+s).


Regards, Paul.





--Boundary-00=_UOAgGUXCAD/1FI4
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="capabilities_demo.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="capabilities_demo.c"

/********************************************************************
*
* Description: capabilities_demo.c
*
*	Based on trivial-periodic.c from Xenomai's examples/native
*       directory - Additional material for dropping root privileges
*       and communicating with a kernel task subject to the following
*       statement:
*
* Author: Paul Corner <paul_c@domain.hid>
* Created on: Thu Mar 29 12:21:00 BST 2007
* License: GPL Ver. 2
*    
* Copyright (c) 2007 Paul Corner <paul_c@domain.hid>  All rights reserved.
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License version 2 as
* published by the Free Software Foundation.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*
********************************************************************/

#include "autoconf.h"
#include <stdlib.h>
#include <stdio.h>
#include <signal.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/mman.h>

#include <native/task.h>
#include <native/heap.h>
#include <native/timer.h>

#define TASK_PRIO 10

void catch_signal(int sig)
{
}


#if HAVE_LIBCAP
#include <sys/capability.h>
#include <sys/prctl.h>
#endif

void set_security(void)
{
#if HAVE_LIBCAP
    cap_t cap;

    /* Running as root - No need to drop anything. */
    if (getuid() == 0)
        return;

    /* Do a `chown root` and `chmod a+s` to allow non-root use */
    if (geteuid() != 0) {
	printf("suid not set - aborting");
	exit(-EPERM);
    }

    /* keep root capabilities in the transition to non-root user */
    prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0);
    setuid(getuid());

    /* drop all privs except CAP_SYS_NICE (for Xenomai), CAP_IPC_LOCK       
        (for mlockall), and CAP_SYS_RAWIO (for ioperm/iopl) for all
        current and future ops - Note: If all IO is done in kernel space,
        CAP_SYS_RAWIO can be dropped. */
    cap = cap_from_text("CAP_SYS_RAWIO,CAP_IPC_LOCK,CAP_SYS_NICE+ep");
    if (errno)
	perror("cap_from_text failed");
    if (cap_set_proc(cap) < 0) {
	perror("Failed to drop root privileges, aborting");
	exit(-EPERM);
    }

    cap_free(cap);
#endif
    return;
}

RT_HEAP driver_heap;

int main(int argc, char *argv[])
{
    int err = 0;
    int t, k, s;
    void* mem = NULL;
    struct driver_info *info;
    struct driver_data *data;
    RT_HEAP_INFO heap_info;

    signal(SIGTERM, catch_signal);
    signal(SIGINT, catch_signal);

    set_security();

    /* Avoids memory swapping for this program */
    mlockall(MCL_CURRENT | MCL_FUTURE);
    rt_task_create(&demo_task, "trivial", 0, TASK_PRIO, 0);
    rt_task_start(&demo_task, &demo, NULL);

    pause();

    return err;
}

--Boundary-00=_UOAgGUXCAD/1FI4--

