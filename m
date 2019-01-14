Subject: Re: How to close orphan FDs
References: <1c7af21b-d6db-fdd6-6083-bad2b877cf1d@compador.de>
 <3ed8dc64-20ce-1c3c-05fd-5fe6ab7dee55@web.de>
From: Johannes Holtz <johannes.holtz@compador.de>
Message-ID: <0ba2523e-e040-4527-f60b-27a62a3d8bb4@compador.de>
Date: Mon, 14 Jan 2019 11:37:55 +0100
MIME-Version: 1.0
In-Reply-To: <3ed8dc64-20ce-1c3c-05fd-5fe6ab7dee55@web.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>, xenomai@xenomai.org

Am 13.01.19 um 05:08 schrieb Jan Kiszka:
 > On 11.01.19 22:55, Johannes Holtz via Xenomai wrote:
 >> Hi,
 >>
 >> I managed to leave some labeled XDDP and IDDP FDs  open after a 
segfault.
 >> Even though the process is killed the resources/FDs are not freed. 
Is there a
 >> way to close them or do I have to restart the box?
 >
 > Could you describe in more details - or even with a small test 
program - how you created the resources that then leaked?
 >
 > Conceptually, everything should be cleaned up automatically when the 
last owner of a resource vanished.
 >
 > Jan

My project has several different modules. Module 'A' is a non-rt Thread 
which
handles all the communication with the rt-modules. In turn I have a 
rt-thread,
module 'B', which is connected to A via XDDP.

B <--XDDP--> A

B creates a socket (rt_dev_socket) sets label and poolsz 
(rt_dev_setsockopt)
and binds (rt_dev_bind) it subsequently.


A opens (open) the file counterpart from 
/proc/xenomai/registry/rtipc/xddp/[label]
when it is needed. It's guaranteed that A opens later then B binds the 
socket.

B needs to do some CAN communication so there are another two rt-threads 
'C'
and 'D' which are connected to B via IDDP.

C <-- IDDP --> B <-- XDDP --> A

D <-- IDDP --> B

C and D each open a socket and set label and poolsz before binding. B
afterwards creates it's socket the same way but instead of binding it 
connects
(rt_dev_connect).

When the project experiences a segfault and the threads and sockets are not
orderly closed the /proc/xenoai/registry/rtipc/iddp and .../xddp still 
show my
fd/labels.

Additional info after segfault:

#cat /proc/xenomai/registry/usage
slots=512:used=6:exported=5

# cat /proc/xenomai/rtdm/open_fildes
Index    Locked    Device                Owner [PID]
0    1    rtcan                           <kernel> [-1]
1    1    rtipc                           <kernel> [-1]
2    1    rtipc                           <kernel> [-1]
3    1    rtipc                           <kernel> [-1]
4    1    rtipc                           <kernel> [-1]
5    1    rtipc                           <kernel> [-1]

I still think I overlooked something but as you said the resources 
should be
freed automatically anyway.

Xenomai 2.6


