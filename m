MIME-Version: 1.0
From: Pierre C <cpierre0031@gmail.com>
Date: Wed, 2 Nov 2016 14:45:09 +0100
Message-ID: <CALJb2vDv67n902qmu04Zodr1rSap8QJ9WymN1ndRxWwO=tf3HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] [RTnet]: select() function (on Promiscuous RAW sockets)
 return all the time, the number of initialized file descriptor.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi everybody,

When i use the select() function on the RTnet Promiscuous RAW socket
interfaces, the function return the number of initialized file descriptor
and when i read the data received (with the "rt_dev_recv" function), the
function return -11 for each port.

Xenomai: V3.0.2
Kernel: 3.14.44

Thanks alot, in advance, for your answer or solution.
