Date: Mon, 26 Mar 2012 09:14:17 -0700 (PDT)
From: "Doug Brunner" <dbrunner@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4F63867D.7060204@domain.hid>
References: <1331579565.394426122@domain.hid>
	<4F5E51E2.1020802@domain.hid> 
	<1331829045.814121867@domain.hid>
	<4F63867D.7060204@domain.hid>
Message-ID: <1332778457.241521523@domain.hid>
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

Thanks for the information--the issue is not about picking a free port on t=
he server side, but rather about communicating the information on which por=
ts are "free" to the clients (server has connected its end, but no other cl=
ient is using the port). The semaphore mechanism isn't that much of a probl=
em, though; I've been able to build a satisfactory implementation.=0A=0AOne=
 other question: although I know in-order delivery isn't necessarily a feat=
ure of datagram based protocols, would I get that with an IDDP socket conne=
ction between just two processes, and/or an XDDP connection to a /dev/rtpN?=
=0A=0A    Doug Brunner=0A=0A-----Original Message-----=0AFrom: "Philippe Ge=
rum" <rpm@xenomai.org>=0ASent: Friday, March 16, 2012 11:29am=0ATo: "Doug B=
runner" <dbrunner@domain.hid>=0ACc: xenomai@xenomai.org: Re: [Xeno=
mai-help] Intermixing native and POSIX skins=0A=0AOn 03/15/2012 05:30 PM, D=
oug Brunner wrote:=0A> Thanks Philippe. I hadn't even known about the exist=
ence of the RTIPC driver, and I definitely like the idea.=0A>=0A> I've been=
 experimenting with it a bit today, and found that it seems to be allowed f=
or more than two sockets to connect to the same port. I modified iddp-sendr=
ecv.c to have two client processes, both of which now connect to the same p=
ort as the server, then did the same thing with iddp-label.c (two clients b=
oth connect()ing to the same label).=0A>=0A> This would cause havoc with th=
e communications that go on between my processes--they need a one-to-one ch=
annel. I could implement semaphores to enforce this, but it would be nice t=
o avoid that complication. Is there a way to make it happen using just the =
socket interface?=0A=0AThe RTIPC protocols are fundamentally datagram-based=
, so allowing N:1 =0Adata paths is wanted. If the issue is about picking a =
different port =0Aeach time you bind a server socket in the AF_RTIPC domain=
, then I would =0Asuggest to set sipc_port to -1 when binding the server-si=
de socket: a =0Afree port will be picked automatically. You could then use =
getsockname() =0Ato retrieve the actual port #, and pass it to the clients.=
=0A=0A-- =0APhilippe.=0A


