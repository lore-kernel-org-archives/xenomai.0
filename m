MIME-Version: 1.0
Date: Fri, 01 Jul 2016 16:31:58 +0200
From: Geoffrey BONNEVILLE <geoffrey.bonneville@smile.fr>
Message-ID: <3137778ca215b6db6061de83fa64dcae@smile.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] RTnet - List corruption when creating packet socket two
 consecutive times
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

 

Hi, 

Tested with Xenomai 3.0.2 (Cobalt) on a 4.1 kernel. Both on a
32-bits ARM and a 32 bits x86 platform. 

I get a list corruption
warning when I try to open()/close() one packet socket, two (or more)
consecutive times. 

I think the problem is not limited to packet
sockets. 

Steps to reproduce: 

- Use a kernel with CONFIG_DEBUG_LIST=y


- Load rtnet.ko and rtpacket.ko 

- Execute a program which open() and
close() a packet socket. (see test_socket.c below)


====test_socket.c==== 

#include <stdio.h>
#include
<stdlib.h>
#include <limits.h>
#include <fcntl.h>
#include
<errno.h>
#include <sys/socket.h>
#include <unistd.h>

int main() {
 int
sockfd; 
 sockfd = socket(PF_PACKET, SOCK_RAW, 0); 
 if (sockfd < 0) { 

printf("%s, Error opening socket: %dn", __func__, sockfd); return -1; 

} 
 close(sockfd); 
 return 0; 
}
====END test_socket.c====

I get a
warning about a list corruption from the second time I execute this
code. This is the dmesg output : 

===log=== 

[ 1099.905801]
------------[ cut here ]------------
[ 1099.910486] WARNING: CPU: 0 PID:
1194 at lib/list_debug.c:29 __list_add+0x47/0x90()
[ 1099.918283]
list_add corruption. next->prev should be prev (bf8039f4), but was
(null). (next=c35aa8f0).
[ 1099.927921] Modules linked in: rtpacket
rtnet
[ 1099.932371] CPU: 0 PID: 1194 Comm: demo_mn_console Not tainted
4.1.25+ #39
[ 1099.939303] Hardware name: Generic AM33XX (Flattened
Device Tree)
[ 1099.945476] [<c0013ebd>] (unwind_backtrace) from
[<c00116b5>] (show_stack+0x11/0x14)
[ 1099.953301] [<c00116b5>]
(show_stack) from [<c0031bfd>] (warn_slowpath_common+0x69/0x8c)
[
1099.961460] [<c0031bfd>] (warn_slowpath_common) from [<c0031c43>]
(warn_slowpath_fmt+0x23/0x2c)
[ 1099.970257] [<c0031c43>]
(warn_slowpath_fmt) from [<c02912bb>] (__list_add+0x47/0x90)
[
1099.978249] [<c02912bb>] (__list_add) from [<bf80091f>]
(rtdev_map_rtskb+0x52/0x68 [rtnet])
[ 1099.986789] [<bf80091f>]
(rtdev_map_rtskb [rtnet]) from [<bf801c47>] (rtskb_pool_extend+0x56/0xc0
[rtnet])
[ 1099.996572] [<bf801c47>] (rtskb_pool_extend [rtnet]) from
[<bf801cc9>] (rtskb_pool_init+0x18/0x44 [rtnet])
[ 1100.006474]
[<bf801cc9>] (rtskb_pool_init [rtnet]) from [<bf801e73>]
(__rt_bare_socket_init+0x26/0x48 [rtnet])
[ 1100.016618] [<bf801e73>]
(__rt_bare_socket_init [rtnet]) from [<bf801f2b>]
(__rt_socket_init+0x4a/0x94 [rtnet)
[ 1100.026852] [<bf801f2b>]
(__rt_socket_init [rtnet]) from [<bf81374d>] (rt_packet_socket+0x1c/0x74
[rtpacket])
[ 1100.036886] [<bf81374d>] (rt_packet_socket [rtpacket])
from [<c00db33d>] (__rtdm_dev_socket+0x65/0x14c)
[ 1100.046362]
[<c00db33d>] (__rtdm_dev_socket) from [<c00e7803>]
(ipipe_syscall_hook+0xbf/0x218)
[ 1100.055096] [<c00e7803>]
(ipipe_syscall_hook) from [<c009fd73>]
(__ipipe_notify_syscall+0x7f/0xf0)
[ 1100.064115] [<c009fd73>]
(__ipipe_notify_syscall) from [<c000eb5d>] (pipeline_syscall+0x7/0x22)
[
1100.072911] ---[ end trace c2caa9e6d27329a8 ]---
[ 1100.077569]
------------[ cut here ]------------
[ 1100.082215] WARNING: CPU: 0 PID:
1194 at lib/list_debug.c:36 __list_add+0x8d/0x90()
[ 1100.089928]
list_add double add: new=c35aa8f0, prev=bf8039f4, next=c35aa8f0.
[
1100.097092] Modules linked in: rtpacket rtnet
[ 1100.101504] CPU: 0
PID: 1194 Comm: demo_mn_console Tainted: G W 4.1.25+ #39
[ 1100.109705]
Hardware name: Generic AM33XX (Flattened Device Tree)
[ 1100.115862]
[<c0013ebd>] (unwind_backtrace) from [<c00116b5>]
(show_stack+0x11/0x14)
[ 1100.123648] [<c00116b5>] (show_stack) from
[<c0031bfd>] (warn_slowpath_common+0x69/0x8c)
[ 1100.131833]
[<c0031bfd>] (warn_slowpath_common) from [<c0031c43>]
(warn_slowpath_fmt+0x23/0x2c)
[ 1100.140599] [<c0031c43>]
(warn_slowpath_fmt) from [<c0291301>] (__list_add+0x8d/0x90)
[
1100.148559] [<c0291301>] (__list_add) from [<bf80091f>]
(rtdev_map_rtskb+0x52/0x68 [rtnet])
[ 1100.157033] [<bf80091f>]
(rtdev_map_rtskb [rtnet]) from [<bf801c47>] (rtskb_pool_extend+0x56/0xc0
[rtnet])
[ 1100.166855] [<bf801c47>] (rtskb_pool_extend [rtnet]) from
[<bf801cc9>] (rtskb_pool_init+0x18/0x44 [rtnet])
[ 1100.176635]
[<bf801cc9>] (rtskb_pool_init [rtnet]) from [<bf801e73>]
(__rt_bare_socket_init+0x26/0x48 [rtnet])
[ 1100.186791] [<bf801e73>]
(__rt_bare_socket_init [rtnet]) from [<bf801f2b>]
(__rt_socket_init+0x4a/0x94 [rtnet)
[ 1100.196995] [<bf801f2b>]
(__rt_socket_init [rtnet]) from [<bf81374d>] (rt_packet_socket+0x1c/0x74
[rtpacket])
[ 1100.207048] [<bf81374d>] (rt_packet_socket [rtpacket])
from [<c00db33d>] (__rtdm_dev_socket+0x65/0x14c)
[ 1100.216570]
[<c00db33d>] (__rtdm_dev_socket) from [<c00e7803>]
(ipipe_syscall_hook+0xbf/0x218)
[ 1100.225258] [<c00e7803>]
(ipipe_syscall_hook) from [<c009fd73>]
(__ipipe_notify_syscall+0x7f/0xf0)
[ 1100.234267] [<c009fd73>]
(__ipipe_notify_syscall) from [<c000eb5d>] (pipeline_syscall+0x7/0x22)
[
1100.243057] ---[ end trace c2caa9e6d27329a9 ]---
===END log=== 

After
some time spent on debugging, it seems that the line
"list_del(&skb->entry);" in function "rtdev_unmap_rtskb()" found in
net/stack/rtdev.c is never reached, because the condition
"skb->buf_dma_addr == RTSKB_UNMAPPED" is true. 

Best regards,


Geoffrey Bonneville 

 int sockfd; 
 sockfd = socket(PF_PACKET,
SOCK_RAW, 0); 
 if (sockfd < 0) { 
 printf("%s, Error opening socket:
%dn", __func__, sockfd); return -1; 
 } 
 close(sockfd); 
 return 0; 
