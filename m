From: Wolfgang Denk <wd@domain.hid>
Mime-version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-reply-to: Your message of "Tue, 06 May 2008 18:06:03 +0200."
	<20080506160603.216980@domain.hid>
Date: Tue, 06 May 2008 21:19:06 +0200
Sender: wd@domain.hid
Message-Id: <20080506191906.C9F0A247F5@domain.hid>
Subject: Re: [Xenomai-help] Pros/Contras Xenomai - CONFIG_PREEMPT_RT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Karl Reichert <Karl-Trampe@domain.hid>
Cc: xenomai@xenomai.org

Hello,

in message <20080506160603.216980@domain.hid> you wrote:
>=20
> I see a lot of advantages from this solution:
>...
> 4) As they don't use anything like nucleus, there is less overhead.

But then, PREEMPT_RT executes more code in the real-time path, and it
has measurable impact on non-RT tasks.

> These are the thoughts running through my mind at the moment. I would lik=
e to discuss these with you. What do you think about this? Where do you see=
 pros and contras for xenomai / CONFIG_PREEMPT_RT?

My biggest concern about PREEMPT_RT is that it delivers  only  proba-
bilistic  real-time. It is possible to write non-rt kernel code (like
some devcice drivers) which ruins  RT  behaviour.  That  means,  that
maximum  latencies  are  only  known  for certain hardware / software
combinations, and only by measuring the system.  Any  piece  of  code
that has not been very carefully reviewed and tested can ruin this.

Assume some control application that really requires  hard  real-time
responses.  Let's  pick  an  example  -  today I saw a sewer cleaning
vehicle which pumps water at a rate of 4,500 m=B3/h [1]; assume you are
to control the cut-off valve. The you want to be *really*  sure  that
the valve closes in time - each and every time.=20

Now assume it was a Linux based controller, it has  a  USB  connector
somewhere  (not so uncommon - many systems use USB storage devices to
distribute software  updates  or  to  exchange  data),  and  one  day
somebody has the idea of plugging in his USB camera.

You may end up with loading and running  a  device  driver  that  has
never  been  tested for RT behaviour before. And with PREEMPT_RT, you
run the risk that it will  impact  RT  performance,  eventually  with
serious consequences.

That's why we chose and recommend Xenomai when it comes to  reliable,
guaranteed hard real time.


Another aspect: today, it is probably not so critical any more  which
system  you  chose:  please  don't  see Xenomai and PREEMPT_RT as two
contradicting approaches to realtime Linux. Instead, try to see it as
two independent implementations. Some parts of the community  try  to
bridge the gaps - RTDM has been ported to PREEMPT_RT [2], and so have
the  Xenomai  skins  [3].  The  idea  is  that  you  just write POSIX
compatible application code, which, in combination with RTDM drivers,
can be run both on Xenomai or PREEMPT_RT. That allows you to focus on
your  problem  domain  (application  development),  and   chose   the
implementation  that  fits  your  specific needs best. Some may chose
PREEMPT_RT because they think an unpatched kernel.org tree is vitally
important to them, others chose Xenomai because they  must  guarantee
some  deadlines.  And  at the cost of a recompile/link you can switch
from one configuration to the other.


[1] http://www.wiedemann-reichhardt.de/produkte/s2000det-e.htm
    (Note that I'm picking an example at random. I have no idea which
    sort of software they use on such vehicles.)
[2] http://www.osadl.org/?id=3D212
[3] http://www.denx.de/en/News/WebHome#NewsXenomaiSolo


Best regards,

Wolfgang Denk

--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
Any sufficiently advanced bug is indistinguishable from a feature.
                                                      - Rich Kulawiec

