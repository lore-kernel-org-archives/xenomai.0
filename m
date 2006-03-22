Message-ID: <20060322203422.2866.qmail@domain.hid>
Date: Wed, 22 Mar 2006 17:34:22 -0300 (ART)
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Hard real-time and C++
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai <xenomai@xenomai.org>

Hi,

I'm willing to develop a framework for helping people to program mobile rob=
ots for doing hard
real-time tasks. Assuming most of them will have a limitated knowledge both=
 to RTOS and
programming, I would like to keep it simple to use.

I think that developing it using a object-oriented methodology is crucial f=
or achieving my
objectives. But I have some challenges then. And some questions too.

Since Xenomai and Linux will be built using gcc, I'm willing to use it too.=
 So, I would need to
choose between C++ and C (through the Object Oriented C - OOC - approach). =
I didn't like very much
the OOC aproaches I've seen. I would like to understand better what would b=
e the C++ problems
before I can choose between these alternatives.

I know about the new/delete problems that use the malloc like functions, th=
at runs on secondary
mode. I was wondering if there is an elegant way of changing these call to =
some Xenomai memory
allocation functions. Maybe overriding new() methods... Any more suggestion?

Please, if someone could list me a list of disadvantages of C++ use on hard=
 real-time systems,
requiring object oriented approach, I would be very glad to read it. Better=
 yet if it comes with
the possible solutions to each problem or pointing out that there is no sol=
ution at all.

Thanks in advance,

Rodrigo.



=09



=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20


