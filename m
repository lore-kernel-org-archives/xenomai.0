From: "Flavio de Castro Alves Filho" <flavio.alves@domain.hid>
References: <7a15153d0909230456l1a094dc6g6bea8ba7f077e567@domain.hid>
	<20090923175232.AF318832E864@domain.hid>
In-Reply-To: <20090923175232.AF318832E864@domain.hid>
Date: Fri, 25 Sep 2009 18:09:04 -0300
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAACaegimMCbhAp3tFUXd5zLjCgAAAEAAAAPOW/cf+tUNCgHMr877hPbMBAAAAAA==@phiinnovations.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Language: pt-br
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
To: xenomai@xenomai.org

Hello,

In this case, which is a nice library for HMI to use with real-time
software?

I am not working right now with this at the moment, but I intend to work
with it soon. And, probably, I will face similar issues.

Best Regards,

Flavio
=20

Flavio de Castro Alves Filho
flavio.alves@domain.hid

Tel.: + 55 11 8494 5676
Embedded Software Services
www.phiinnovations.com	 	=20


Escrit=F3rios:
S=E3o Paulo
Campinas

-----Original Message-----
From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] =
On
Behalf Of Wolfgang Denk
Sent: quarta-feira, 23 de setembro de 2009 14:53
To: Felipe Castro
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Realtime data processing + VGA display

Dear Felipe Castro,

In message <7a15153d0909230456l1a094dc6g6bea8ba7f077e567@domain.hid> =
you
wrote:
>
> I need some suggestion about how to deal with QT library, or another =
and
> xenomai real time path.
> What I'm working on, is a real time data processing and i need to show =
the
> results in a VGA display.
>=20
> I have my data processing routine running in real time kernel with a =
high
> priority task, and now after 5ms i need to refresh all data in =
display.

What makes you think so? A refresh every 5 milliseconds means 200
frames per second. No human eye is fast enough to see that. Even if
you relax your timings by a factor of 10 (!) you get 20 frames per
second, which is faster than you can actually see.

> I don't know how to handle it to get my realtime response shown in =
display
> in a realtime too ...

You don't need that, and you don't want that. Instead,  you  want  to
split  your  design  into  a real-time part that does the data acqui-
sition  and  processing,  and  a  non-realtime  part  that  does  the
visualization.

There are few excations, like when you must control alarm signals;
but in this case you normally want to have hardware support for that,
i. e. separate alram lights, beepers etc.

> I did some tests using a simple QT software but it appears to refresh =
to
> slow. Is it possible to do ? another question is , is there another
library
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

_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help

No virus found in this incoming message.
Checked by AVG - www.avg.com=20
Version: 8.5.409 / Virus Database: 270.13.112/2394 - Release Date: =
09/25/09
05:51:00


