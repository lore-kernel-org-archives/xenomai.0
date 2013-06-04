References: <1370278240.95211.YahooMailNeo@web172203.mail.ir2.yahoo.com>
	<20130603182002.GS11182@csclub.uwaterloo.ca>
Message-ID: <1370331867.30520.YahooMailNeo@web172202.mail.ir2.yahoo.com>
Date: Tue, 4 Jun 2013 08:44:27 +0100 (BST)
From: Franz Engel <franz_lambert_engel@yahoo.de>
In-Reply-To: <20130603182002.GS11182@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] gcc error: posix.wrappers
Reply-To: Franz Engel <franz_lambert_engel@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

----- Urspr=FCngliche Message -----=0A> Von: Lennart Sorensen <lsorense@csc=
lub.uwaterloo.ca>=0A> An: Franz Engel <franz_lambert_engel@yahoo.de>=0A> CC=
: "xenomai@xenomai.org" <xenomai@xenomai.org>=0A> Gesendet: 20:20 Montag, 3=
.Juni 2013=0A> Betreff: Re: [Xenomai] gcc error: posix.wrappers=0A> =0A> On=
 Mon, Jun 03, 2013 at 05:50:40PM +0100, Franz Engel wrote:=0A>>  I've a lit=
tle problem. When I try to compile my code with my new system =0A> (xenomai=
 2.6.2.1) I get the following error:=0A>>  gcc: error: ;-Wl,@/usr/xenomai/l=
ib/posix.wrappers: No such file or =0A> directory=0A> =0A> What is that ';'=
 doing there?=A0 That looks weird.=A0 That would end one=0A> command and ma=
ke it seem the -Wl... is a command to try and execute,=0A> which is unlikel=
y to work.=0A> =0A> The rest of your message is probably just symptoms of t=
he above problem.=0A> =0A> -- =0A> Len Sorensen=0A>=0A=0AI have no idee whe=
re the ";" is coming from. When I print my ldflags I get use this: -Wl,@//u=
sr/xenomai/lib/posix.wrappers-L/usr/xenomai/lib-lpthread_rt-lxenomai-lpthre=
ad-lrt=0A=0AThe ";" must be set by the compiler.

