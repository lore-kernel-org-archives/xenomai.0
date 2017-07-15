MIME-Version: 1.0
From: Andreas Glatz <andi.glatz@gmail.com>
Date: Sat, 15 Jul 2017 21:37:32 +0100
Message-ID: <CAKJ14NcXwHkEFSgrnQWG1KacvOhTp9BT9oQNZn_bdzJTCgqhvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Xv3.0.5 /Lv4.9.35 on wandboard: page domain fault in
	rtudp.ko
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi

I managed to compile and bring-up Xenomai v3.0.5, Ipipe v2, Linux
v4.9.35 on a Wandboard Quad C1 [1]. I ran all unit-tests sucessfully
[2] and was able to get RTnet ping to an external PC working. RT ping
stops working after about 1000 pings... but that's a different story,
I guess.

So when I try to get a simple UDP server [3] running on top of RTnet I
get "Unhandled fault: page domain fault (0x01b)" oopses, where the
stacktrace indicates it has to do with rtudp.ko, e.g.
rt_udp_recvmsg+03c/0x38c. Further googling [4] told me that these
faults are related to missing copy_from_user() calls in the udp
driver, which seems to have been enforced in the most recent kernel
versions (after 4.1.x?). So if I go into the rtudp.ko source code and
start introducing copy_to_user() statements, the the page domain
faults go away one after the other...

At my company I basically want to propose to upgrade our current
kernel (3.0.35) with a more recent one. So I'm looking for a hint
what's the best+latest+supported kernel version for i.MX6 in a
production grade setup, which can be patched with Xenomai3 (incl.
RTnet)?

Cheers,

Andreas



[1] https://www.wandboard.org
[2] https://xenomai.org/installing-xenomai-3-x/#Testing_the_real-time_system_both_cores
[3] http://www.binarytides.com/programming-udp-sockets-c-linux/
[4] https://stackoverflow.com/questions/39515407/how-to-handle-a-page-domain-fault-in-a-self-written-character-device-kernel-modu

