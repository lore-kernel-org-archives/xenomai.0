From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Subject: Re: [Xenomai-help] PCI Framegrabber real-time driver
Date: Tue, 17 Jan 2006 12:33:48 -0200
References: <200601111655.57020.lbocseg@domain.hid>
	<200601131953.46146.lbocseg@domain.hid> <43C829C5.1060104@domain.hid>
In-Reply-To: <43C829C5.1060104@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200601171233.48941.lbocseg@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

>>... how can I use an IOCTL interface like a condition variable?
>
>By using one of RTDM's services in your driver's IOCTL handler,
>typically either a semaphore or an event. See the Xenomai API doc for
>details - and have a look at the existing drivers...

Thank you. I'll take a better look on RTDM.

>> ... I'll let you know when I finish it -- if I finish! ;)
>
>That's just a question of (re-)defining the goal when necessary. :)

Maybe you're right, but I don't think my advisor will agree :)

I think now it's time to put in practice what we've been discussing. When I=
=20
get some results we return to this topic. Now, I'm concerned about how to u=
se=20
C++ on the framework. I mean, how can I allocate memory in a time bounded w=
ay=20
in the robot and sensor classes with C++? I know I can't use libstdc++ and =

took a look at xeno-- but I didn't like the idea of using exceptions instea=
d=20
of returning some value, except for the new operator. It seems to me that i=
t=20
becomes too dificult to estimate the time between the exception is thrown t=
o=20
the time it is catched, as stated in EC++=20
(http://www.caravan.net/ec2plus/rationale.html).

Any ideas are welcome.

Thank you,

Rodrigo.

P.S: I couldn't send this message yesterday due to a break in the Internet =

system here.

=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



