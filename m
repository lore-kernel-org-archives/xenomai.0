MIME-Version: 1.0
Date: Thu, 31 May 2012 10:08:18 +0200
Message-ID: <CALH4WdbGSKTfoLS013KW4aoO=vs9qBwMWE5RhW5FVi=FmhAs_w@mail.gmail.com>
From: Frederik Bayart <frederik.bayart@triphase.com>
Content-Type: multipart/mixed; boundary=047d7b15a8af06edf504c15092cd
Subject: [Xenomai] TCP communication problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

--047d7b15a8af06edf504c15092cd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hallo,

When switching from xenomai 2.4.10 on linux 2.6.30.8 (x86) to xenomai
2.6.0 (stable) on linux 2.6.38.8, we noticed some TCP communication
problem between client and server in our application. We wrote a test
program and think this reproduces the problem.

First a short description of the test program :

When the client (rtest.c attached) connects to the server (rtestd.c
attached), the server starts sending packets to the client. Packets
are paired : first a header and then a corresponding data packet. The
payload of each packet starts with a sequence number (to match network
traces and logging), followed with hdr[A..Z])2222222...222hdr[A..Z]
for header and dat[A..Z]77777777...777dat[A..Z] for data packets.

The client can also sent request to server (using the same
connection). The server echoes these packets back.
Client requests are also paired : first a header and then a
corresponding data packet. The payload of each packet starts with a
sequence number (to match network traces and logging), followed with
fre[A..Z])3333333...333fre[A..Z] for header and
rik[A..Z]88888888...888rik[A..Z] for data packets.

Header and data packets have to arrive one after the oter. For that
reason, sending is protected by a mutex.
The send command used in the server is the normal send, so tasks are
switching from primary to secondary domain, but I think sending should
be protected by the mutex.
Also the task that echoes client requests has higher priority.

Client requests can be initiated to the client sending the TRAP signal, e.g

for i in {0..9000} ; do kill -TRAP <pid>; =A0done

where <pid> is the process id of the client process.

If you execute this some times after each other, we noticed that we
have lost some data.

In attached rtest.log, rule 6 , the tail of the packet
(...22222222hdrE) is lost.

This can also be seen in the network trace : packet 4 contains the
first part of the header, but packet 6 contains the start of the data
packet

Client and server are run on different hosts. The ip adress of the
server is given as argument to the client, so e.g. =A0 ./rtest
192.168.0.40

At the moment it's not clear to us whether the problem is caused by
the new xenomai, or by the new kernel, so my question is :

Can the problem be caused by different behaviour of the new xenomai :
new scheduler, no mutex protection in the secondary domain, =A0... ?

Frederik

--047d7b15a8af06edf504c15092cd
Content-Type: application/zip; name="rtest.zip"
Content-Disposition: attachment; filename="rtest.zip"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h2vjg1u10

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
--047d7b15a8af06edf504c15092cd--

