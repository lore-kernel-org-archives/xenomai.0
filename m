MIME-Version: 1.0
From: Ed Hannigan <edphannigan@gmail.com>
Date: Sat, 11 Mar 2017 14:58:15 -0500
Message-ID: <CAHN8pEZByi0QXdxwrDhdFshF-uyHoXYGc3z=vAdLGC=BwNmYxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Raw Ethernet socket in Xenomai 3.0.3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I have a Xenomai 2.6.1 userspace app that uses RTNet 0.9.13 and I can
send/receive raw Ethernet packets with calls rt_dev_send and rt_dev_recv.

I am trying to migrate to Xenomai 3.0.3 but receiving a negative error
code from the following line:

s = rt_dev_socket(AF_PACKET, SOCK_RAW, MY_PROTOCOL);

rtifconfig shows rteth0 as UP and receives packets so my
8139 works.  The eth_p_all demo appears to only show packets received
from non-realtime cards.  Looking on the web I've seen that maybe I should
use rtdm_socket, rtdm_send, etc.  If I try doing this then I run into linker
errors with the Cobalt core.  I need help with setup and sending/receiving
of raw Ethernet packets from in user-space.  Thanks. -Ed
