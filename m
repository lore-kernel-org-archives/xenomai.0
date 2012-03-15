Date: Thu, 15 Mar 2012 09:30:45 -0700 (PDT)
From: "Doug Brunner" <dbrunner@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4F5E51E2.1020802@domain.hid>
References: <1331579565.394426122@domain.hid>
	<4F5E51E2.1020802@domain.hid>
Message-ID: <1331829045.814121867@domain.hid>
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

Thanks Philippe. I hadn't even known about the existence of the RTIPC drive=
r, and I definitely like the idea.=0A=0AI've been experimenting with it a b=
it today, and found that it seems to be allowed for more than two sockets t=
o connect to the same port. I modified iddp-sendrecv.c to have two client p=
rocesses, both of which now connect to the same port as the server, then di=
d the same thing with iddp-label.c (two clients both connect()ing to the sa=
me label).=0A=0AThis would cause havoc with the communications that go on b=
etween my processes--they need a one-to-one channel. I could implement sema=
phores to enforce this, but it would be nice to avoid that complication. Is=
 there a way to make it happen using just the socket interface?=0A=0A    Do=
ug Brunner=0A=0A-----Original Message-----=0AFrom: "Philippe Gerum" <rpm@xenomai.org=
nomai.org>=0ASent: Monday, March 12, 2012 12:43pm=0ATo: "Doug Brunner" <dbr=
unner@domain.hid>=0ACc: xenomai@xenomai.org: Re: [Xenomai-help] In=
termixing native and POSIX skins=0A=0AOn 03/12/2012 08:12 PM, Doug Brunner =
wrote:=0A> I'd like to be able to use native skin communications services (=
most importantly real time pipes) from a thread created with the POSIX skin=
. Is this safe?=0A=0AYes, that's fine. You could also use the XDDP protocol=
 (cross-domain =0Adatagram) implemented by the RTIPC Xenomai driver for exa=
ctly the same =0Apurpose, with a socket-based interface as a bonus.=0A=0A>=
=0A> I'm doing this because I'm building a C++ library that can use either =
real-time communications services, when used with a real-time application, =
or regular Linux pipe I/O, when used with a Linux application; these servic=
es are called by tasks that need to exist in both cases. I'd like to make t=
he tasks always POSIX threads to eliminate the need for a bunch of wrappers=
 and preprocessor ugliness that I put there to support either skin, dependi=
ng on which version of the library is being built.=0A>=0A> Thanks,=0A>     =
 Doug Brunner=0A>=0A>=0A>=0A> _____________________________________________=
__=0A> Xenomai-help mailing list=0A> Xenomai-help@domain.hid> https://mail.=
gna.org/listinfo/xenomai-help=0A>=0A=0A=0A-- =0APhilippe.=0A


