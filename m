From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Fri, 11 Sep 2009 17:25:30 +0200
Message-Id: <1252682730.2820.414.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] RTIPC protocol driver set
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


In the wake of a recent discussion about Xenomai 3, the requirement to
find a substitute for the native message pipes interface (i.e. RT_PIPE)
was pointed out.

The real-time side of this new interface would have to be available from
kernel space to RTDM drivers as well, so that people adopting a clean
split model like RTDM-drivers <-> userland applications, would not be
left in the cold, with no replacement for the legacy RT_PIPE API in
kernel space, which will be phased out in Xenomai 3.

This question, and a few others, may have found an answer with the
recent merging of the so-called RTIPC framework, for Xenomai 2.5.x.
RTIPC is an RTDM-based "meta-driver", on top of which one may stack
protocol drivers, exporting a socket interface to the real-time users,
running in primary mode within the Xenomai domain. The point of RTIPC
being precisely that such users won't want to leave the real-time mode
for sending/receiving data to/from other destinations/sources.

So far, I have merged three protocols along with the RTIPC framework,
namely XDDP, IDDP and BUFP.

* XDDP stands for "cross-domain datagram protocol", i.e. to exchange
datagrams between the Xenomai (primary) real-time domain, and the Linux
realm. This is what the message pipe fans may want to have a look at.
Basically, it connects a real-time RTDM socket to one of the /dev/rtp*
pseudo-devices. The network port used on the socket side matches the
minor device number used on the non RT side. The added bonus of XDDP is
that people relying on the POSIX skin may now have access to the message
pipe feature, without dragging in bits of the native skin API for that
purpose.

* IDDP stands for "intra-domain datagram protocol", i.e. a
Xenomai-to-Xenomai real-time datagram channel. This protocol may not be
as flexible as POSIX message queues (does not support message priority
but does out-of-bound sending though), but exports a socket interface,
which is surely better for your brain than mq_*() (ask Gilles). The
basic idea behind it is that anything you could do based on AF_UNIX
sockets in the Linux realm, should be (mostly) doable with AF_RTIPC+IDDP
in the Xenomai domain. However, we use numeric port numbers or label
strings, and not socket paths to bind sockets in the Xenomai namespace.

* BUFP stands for "buffer protocol", probably the most naive of all, but
likely the best fit when you don't care for message boundaries, and just
want an efficient IPC to send a byte stream from a producer to a
consumer thread, without leaving the Xenomai domain. This protocol is
the exact equivalent of the RT_BUFFER API that came to light earlier in
the 2.5.x series, but again, exporting a socket interface to the
real-time application.

The fact that all RTIPC protocols are RTDM-based, means that one can
reach the socket API from kernel space as well, using the inter-driver
RTDM interface, see:
http://www.xenomai.org/documentation/xenomai-head/html/api/index.html

A few examples illustrating usage of those protocols from user-space are
available from my GIT tree, see there:
http://git.xenomai.org/?p=xenomai-head.git;a=tree;f=examples/rtdm/profiles/ipc;h=a352a07067bfbad44d4d13cc386d567ca1911bb0;hb=HEAD

So far, reasonable testing took place for all protocols using the RTDM
socket interface in user-space, albeit the RTIPC framework itself should
still be considered as work in progress. However, in-kernel calls via
RTDM's inter-driver interface remain to be validated, although RTDM does
most of the job here, so the remaining issues should not be complex ones
if any.

-- 
Philippe.



