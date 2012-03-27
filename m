Date: Tue, 27 Mar 2012 14:35:56 -0700 (PDT)
From: "Doug Brunner" <dbrunner@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4F71EA1B.4080001@domain.hid>
References: <1331579565.394426122@domain.hid>
	<4F5E51E2.1020802@domain.hid> 
	<1331829045.814121867@domain.hid>
	<4F63867D.7060204@domain.hid> 
	<1332778457.241521523@domain.hid>
	<4F71EA1B.4080001@domain.hid>
Message-ID: <1332884156.408323832@domain.hid>
Subject: Re: [Xenomai-help] Intermixing native and POSIX skins
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

The usage pattern would be a bit like BSD ptys--the server maintains a few =
ports, say named "server0" through "server15" and clients that need a port =
try "server0", if it's busy then try "server1", etc..=0A=0AI suppose the pr=
oblem here is really that the application running over these sockets is sta=
teful, the configuration of the nodes (processes) that are communicating is=
 not known until run time, and nodes may appear and disappear as the server=
 runs, so the transport needs to be connection-oriented rather than message=
-oriented. The semaphore is still a bit of a kludge, since it doesn't notif=
y a thread blocked on recv() that the remote has hung up, but it works well=
 enough in conjunction with a message that says "I'm a client that's newly =
connected to this server" to reset the state associated with the connection=
. I suppose I could implement a sort of TCP handshake on top of the IDDP so=
cket layer and use that to provide true connection-oriented behavior.=0A=0A=
Good to know about in-order delivery; a quick glance at the source code see=
med to suggest that, but I wasn't sure.=0A=0A    Doug Brunner=0A=0A-----Ori=
ginal Message-----=0AFrom: "Philippe Gerum" <rpm@xenomai.org>=0ASent: Tuesd=
ay, March 27, 2012 9:26am=0ATo: "Doug Brunner" <dbrunner@domain.hid>=0ACc: xe=
nomai-help@domain.hid: Re: [Xenomai-help] Intermixing native and POS=
IX skins=0A=0AOn 03/26/2012 06:14 PM, Doug Brunner wrote:=0A> Thanks for th=
e information--the issue is not about picking a free port on the server sid=
e, but rather about communicating the information on which ports are "free"=
 to the clients (server has connected its end, but no other client is using=
 the port). The semaphore mechanism isn't that much of a problem, though; I=
've been able to build a satisfactory implementation.=0A=0AMm, still scratc=
hing my head to understand the issue. Both the client =0Aand server side ac=
cept -1 as the port spec, telling the kernel to draw a =0Afree port. I unde=
rstand the issue is not on the server side, so is it on =0Athe client side?=
=0A=0ACould you sketch the usage pattern?=0A=0A>=0A> One other question: al=
though I know in-order delivery isn't necessarily a feature of datagram bas=
ed protocols, would I get that with an IDDP socket connection between just =
two processes, and/or an XDDP connection to a /dev/rtpN?=0A=0AYes, in-order=
 delivery is guaranteed with all RTIPC protocols. This is =0Awritten in sto=
ne.=0A=0A>=0A>      Doug Brunner=0A>=0A> -----Original Message-----=0A> Fro=
m: "Philippe Gerum"<rpm@xenomai.org>=0A> Sent: Friday, March 16, 2012 11:29=
am=0A> To: "Doug Brunner"<dbrunner@domain.hid>=0A> Cc: xenomai@xenomai.org=
=0A> Subject: Re: [Xenomai-help] Intermixing native and POSIX skins=0A>=0A>=
 On 03/15/2012 05:30 PM, Doug Brunner wrote:=0A>> Thanks Philippe. I hadn't=
 even known about the existence of the RTIPC driver, and I definitely like =
the idea.=0A>>=0A>> I've been experimenting with it a bit today, and found =
that it seems to be allowed for more than two sockets to connect to the sam=
e port. I modified iddp-sendrecv.c to have two client processes, both of wh=
ich now connect to the same port as the server, then did the same thing wit=
h iddp-label.c (two clients both connect()ing to the same label).=0A>>=0A>>=
 This would cause havoc with the communications that go on between my proce=
sses--they need a one-to-one channel. I could implement semaphores to enfor=
ce this, but it would be nice to avoid that complication. Is there a way to=
 make it happen using just the socket interface?=0A>=0A> The RTIPC protocol=
s are fundamentally datagram-based, so allowing N:1=0A> data paths is wante=
d. If the issue is about picking a different port=0A> each time you bind a =
server socket in the AF_RTIPC domain, then I would=0A> suggest to set sipc_=
port to -1 when binding the server-side socket: a=0A> free port will be pic=
ked automatically. You could then use getsockname()=0A> to retrieve the act=
ual port #, and pass it to the clients.=0A>=0A=0A=0A-- =0APhilippe.=0A


