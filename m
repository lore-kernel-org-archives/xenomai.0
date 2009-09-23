From: Wolfgang Denk <wd@domain.hid>
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <7a15153d0909230456l1a094dc6g6bea8ba7f077e567@domain.hid>
References: <7a15153d0909230456l1a094dc6g6bea8ba7f077e567@domain.hid>
Date: Wed, 23 Sep 2009 19:52:32 +0200
Message-Id: <20090923175232.AF318832E864@domain.hid>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Realtime data processing + VGA display
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Felipe Castro <felipecpc1@domain.hid>
Cc: xenomai@xenomai.org

Dear Felipe Castro,

In message <7a15153d0909230456l1a094dc6g6bea8ba7f077e567@domain.hid> =
you wrote:
>
> I need some suggestion about how to deal with QT library, or another an=
d
> xenomai real time path.
> What I'm working on, is a real time data processing and i need to show =
the
> results in a VGA display.
>=20
> I have my data processing routine running in real time kernel with a hi=
gh
> priority task, and now after 5ms i need to refresh all data in display.

What makes you think so? A refresh every 5 milliseconds means 200
frames per second. No human eye is fast enough to see that. Even if
you relax your timings by a factor of 10 (!) you get 20 frames per
second, which is faster than you can actually see.

> I don't know how to handle it to get my realtime response shown in disp=
lay
> in a realtime too ...

You don't need that, and you don't want that. Instead,  you  want  to
split  your  design  into  a real-time part that does the data acqui-
sition  and  processing,  and  a  non-realtime  part  that  does  the
visualization.

There are few excations, like when you must control alarm signals;
but in this case you normally want to have hardware support for that,
i. e. separate alram lights, beepers etc.

> I did some tests using a simple QT software but it appears to refresh t=
o
> slow. Is it possible to do ? another question is , is there another lib=
rary
> to handle VGA display tha you suggest me ?

There are many options for the GUI, but you  should  not  attempt  to
select  these  for  their  real-time  capabilities.  If  you  need  a
RT-capable graphics environment, you can be  pretty  sure  that  your
system is misdesigned.

Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
C++ was an interesting and valuable experiment, but we've learned its
lessons and it's time to move on.
                            - Peter Curran in <DCqM4z.BxB@isgtec.com>

