MIME-Version: 1.0
In-Reply-To: <20090923175232.AF318832E864@domain.hid>
References: <7a15153d0909230456l1a094dc6g6bea8ba7f077e567@domain.hid>
	<20090923175232.AF318832E864@domain.hid>
Date: Sat, 26 Sep 2009 00:12:57 +0200
Message-ID: <cbe23c50909251512xa686b15pe986085852c34254@domain.hid>
From: Eric Noulard <eric.noulard@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Xenomai help <xenomai@xenomai.org>

2009/9/23 Wolfgang Denk <wd@domain.hid>:
> Dear Felipe Castro,
>
> In message <7a15153d0909230456l1a094dc6g6bea8ba7f077e567@domain.hid> =
you wrote:
>>
>> I need some suggestion about how to deal with QT library, or another and
>> xenomai real time path.
>> What I'm working on, is a real time data processing and i need to show t=
he
>> results in a VGA display.
>>
>> I have my data processing routine running in real time kernel with a hig=
h
>> priority task, and now after 5ms i need to refresh all data in display.
>
> What makes you think so? A refresh every 5 milliseconds means 200
> frames per second. No human eye is fast enough to see that.
> Even if you relax your timings by a factor of 10 (!) you get 20 frames pe=
r
> second, which is faster than you can actually see.

I don't know Felipe's test case but I know at least one application
which was a Star Sensor stimulator which needs higher refresh rate than
human eye, but not that high too (32..64Hz max).
The device looking at the screen was not a human in this case.

In the human case I agree even if you still need a smooth/regular refresh r=
ate
if you do visualize animated 3D scene which pictures your data.
Some explanation here:
http://www.100fps.com/how_many_frames_can_humans_see.htm

>> I don't know how to handle it to get my realtime response shown in displ=
ay
>> in a realtime too ...
>
> You don't need that, and you don't want that. Instead, =A0you =A0want =A0=
to
> split =A0your =A0design =A0into =A0a real-time part that does the data ac=
qui-
> sition =A0and =A0processing, =A0and =A0a =A0non-realtime =A0part =A0that =
=A0does =A0the
> visualization.

Nevertheless I agree with that, even if you need high refresh rate display
you'll certainly want to decouple display from hard RT data processing.

>> I did some tests using a simple QT software but it appears to refresh to
>> slow. Is it possible to do ? another question is , is there another libr=
ary
>> to handle VGA display tha you suggest me ?
>
> There are many options for the GUI, but you =A0should =A0not =A0attempt =
=A0to
> select =A0these =A0for =A0their =A0real-time =A0capabilities. =A0If =A0yo=
u =A0need =A0a
> RT-capable graphics environment, you can be =A0pretty =A0sure =A0that =A0=
your
> system is misdesigned.

I 'm not sure to understand what you say Wolfgang, but I think
that high refresh rate display should certainly be realized using
specialized shader languages (http://en.wikipedia.org/wiki/Shader_language)
this must be done in user land (may be non RT) tasks taking their data
from RT ones.

For 2D images may writing directly to some framebuffer
(http://en.wikipedia.org/wiki/Linux_framebuffer)
may be a solution.

I did never mix Xenomai with such solution, my experience was with
"classical" linux SCHED_FIFO processes reading some serial port
at most at 32Hz with no HARD jitter requirement.
Thus I don't know the possible "interaction" off an hard RT xenomai process
with some fancy graphic driver.

What is your precise graphic display need?

Do you want to display animated 3D scene built from RT data?
2D image??


--=20
Erk
Membre de l'April - =AB promouvoir et d=E9fendre le logiciel libre =BB -
http://www.april.org

