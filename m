MIME-Version: 1.0
In-Reply-To: <cbe23c50909251512xa686b15pe986085852c34254@domain.hid>
References: <7a15153d0909230456l1a094dc6g6bea8ba7f077e567@domain.hid>
	<20090923175232.AF318832E864@domain.hid>
	<cbe23c50909251512xa686b15pe986085852c34254@domain.hid>
Date: Tue, 29 Sep 2009 09:18:51 -0300
Message-ID: <7a15153d0909290518v5f6a323cqa5580a4325ff1b56@domain.hid>
From: Felipe Castro <felipecpc1@domain.hid>
Content-Type: multipart/alternative; boundary=0016367b6a6acef49e0474b66a8f
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

--0016367b6a6acef49e0474b66a8f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I was doing a mistake actually. For me 20fps is more than enough

In my application i need to draw some graphics after the signal processing.
Now I'm trying to use QT library, but unsuccessfully.

In fact i can draw in VGA display and so on, but a simple hello world with
is unsing 97% of my processor .... i need to study a little bit more about
QT .....

Another option that i found is minigui lib, but i didn't try yet.

Felipe

On Fri, Sep 25, 2009 at 7:12 PM, Eric Noulard <eric.noulard@domain.hid>wrote=
:

> 2009/9/23 Wolfgang Denk <wd@domain.hid>:
> > Dear Felipe Castro,
> >
> > In message <7a15153d0909230456l1a094dc6g6bea8ba7f077e567@domain.hid=
>
> you wrote:
> >>
> >> I need some suggestion about how to deal with QT library, or another a=
nd
> >> xenomai real time path.
> >> What I'm working on, is a real time data processing and i need to show
> the
> >> results in a VGA display.
> >>
> >> I have my data processing routine running in real time kernel with a
> high
> >> priority task, and now after 5ms i need to refresh all data in display=
.
> >
> > What makes you think so? A refresh every 5 milliseconds means 200
> > frames per second. No human eye is fast enough to see that.
> > Even if you relax your timings by a factor of 10 (!) you get 20 frames
> per
> > second, which is faster than you can actually see.
>
> I don't know Felipe's test case but I know at least one application
> which was a Star Sensor stimulator which needs higher refresh rate than
> human eye, but not that high too (32..64Hz max).
> The device looking at the screen was not a human in this case.
>
> In the human case I agree even if you still need a smooth/regular refresh
> rate
> if you do visualize animated 3D scene which pictures your data.
> Some explanation here:
> http://www.100fps.com/how_many_frames_can_humans_see.htm
>
> >> I don't know how to handle it to get my realtime response shown in
> display
> >> in a realtime too ...
> >
> > You don't need that, and you don't want that. Instead,  you  want  to
> > split  your  design  into  a real-time part that does the data acqui-
> > sition  and  processing,  and  a  non-realtime  part  that  does  the
> > visualization.
>
> Nevertheless I agree with that, even if you need high refresh rate displa=
y
> you'll certainly want to decouple display from hard RT data processing.
>
> >> I did some tests using a simple QT software but it appears to refresh =
to
> >> slow. Is it possible to do ? another question is , is there another
> library
> >> to handle VGA display tha you suggest me ?
> >
> > There are many options for the GUI, but you  should  not  attempt  to
> > select  these  for  their  real-time  capabilities.  If  you  need  a
> > RT-capable graphics environment, you can be  pretty  sure  that  your
> > system is misdesigned.
>
> I 'm not sure to understand what you say Wolfgang, but I think
> that high refresh rate display should certainly be realized using
> specialized shader languages (http://en.wikipedia.org/wiki/Shader_languag=
e
> )
> this must be done in user land (may be non RT) tasks taking their data
> from RT ones.
>
> For 2D images may writing directly to some framebuffer
> (http://en.wikipedia.org/wiki/Linux_framebuffer)
> may be a solution.
>
> I did never mix Xenomai with such solution, my experience was with
> "classical" linux SCHED_FIFO processes reading some serial port
> at most at 32Hz with no HARD jitter requirement.
> Thus I don't know the possible "interaction" off an hard RT xenomai proce=
ss
> with some fancy graphic driver.
>
> What is your precise graphic display need?
>
> Do you want to display animated 3D scene built from RT data?
> 2D image??
>
>
> --
> Erk
> Membre de l'April - =AB promouvoir et d=E9fendre le logiciel libre =BB -
> http://www.april.org
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

--0016367b6a6acef49e0474b66a8f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I was doing a mistake actually. For me 20fps is more than enough<br><br>In
my application i need to draw some graphics after the signal
processing. Now I&#39;m trying to use QT library, but unsuccessfully.<br><b=
r>In
fact i can draw in VGA display and so on, but a simple hello world with
is unsing 97% of my processor .... i need to study a little bit more
about QT ..... <br>

<br>Another option that i found is minigui lib, but i didn&#39;t try yet. <=
br><br>Felipe<br><br><div class=3D"gmail_quote">On Fri, Sep 25, 2009 at 7:1=
2 PM, Eric Noulard <span dir=3D"ltr">&lt;<a href=3D"mailto:eric.noulard@domain.hid=
il.com">eric.noulard@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">2009/9/23 Wolfgan=
g Denk &lt;<a href=3D"mailto:wd@domain.hid">wd@domain.hid</a>&gt;:<br>
&gt; Dear Felipe Castro,<br>
&gt;<br>
&gt; In message &lt;<a href=3D"mailto:7a15153d0909230456l1a094dc6g6bea8ba7f=
077e567@domain.hid">7a15153d0909230456l1a094dc6g6bea8ba7f077e567@domain.hid=
mail.com</a>&gt; you wrote:<br>
&gt;&gt;<br>
&gt;&gt; I need some suggestion about how to deal with QT library, or anoth=
er and<br>
&gt;&gt; xenomai real time path.<br>
&gt;&gt; What I&#39;m working on, is a real time data processing and i need=
 to show the<br>
&gt;&gt; results in a VGA display.<br>
&gt;&gt;<br>
&gt;&gt; I have my data processing routine running in real time kernel with=
 a high<br>
&gt;&gt; priority task, and now after 5ms i need to refresh all data in dis=
play.<br>
&gt;<br>
&gt; What makes you think so? A refresh every 5 milliseconds means 200<br>
&gt; frames per second. No human eye is fast enough to see that.<br>
&gt; Even if you relax your timings by a factor of 10 (!) you get 20 frames=
 per<br>
&gt; second, which is faster than you can actually see.<br>
<br>
I don&#39;t know Felipe&#39;s test case but I know at least one application=
<br>
which was a Star Sensor stimulator which needs higher refresh rate than<br>
human eye, but not that high too (32..64Hz max).<br>
The device looking at the screen was not a human in this case.<br>
<br>
In the human case I agree even if you still need a smooth/regular refresh r=
ate<br>
if you do visualize animated 3D scene which pictures your data.<br>
Some explanation here:<br>
<a href=3D"http://www.100fps.com/how_many_frames_can_humans_see.htm" target=
=3D"_blank">http://www.100fps.com/how_many_frames_can_humans_see.htm</a><br=
>
<br>
&gt;&gt; I don&#39;t know how to handle it to get my realtime response show=
n in display<br>
&gt;&gt; in a realtime too ...<br>
&gt;<br>
&gt; You don&#39;t need that, and you don&#39;t want that. Instead, =A0you =
=A0want =A0to<br>
&gt; split =A0your =A0design =A0into =A0a real-time part that does the data=
 acqui-<br>
&gt; sition =A0and =A0processing, =A0and =A0a =A0non-realtime =A0part =A0th=
at =A0does =A0the<br>
&gt; visualization.<br>
<br>
Nevertheless I agree with that, even if you need high refresh rate display<=
br>
you&#39;ll certainly want to decouple display from hard RT data processing.=
<br>
<br>
&gt;&gt; I did some tests using a simple QT software but it appears to refr=
esh to<br>
&gt;&gt; slow. Is it possible to do ? another question is , is there anothe=
r library<br>
&gt;&gt; to handle VGA display tha you suggest me ?<br>
&gt;<br>
&gt; There are many options for the GUI, but you =A0should =A0not =A0attemp=
t =A0to<br>
&gt; select =A0these =A0for =A0their =A0real-time =A0capabilities. =A0If =
=A0you =A0need =A0a<br>
&gt; RT-capable graphics environment, you can be =A0pretty =A0sure =A0that =
=A0your<br>
&gt; system is misdesigned.<br>
<br>
I &#39;m not sure to understand what you say Wolfgang, but I think<br>
that high refresh rate display should certainly be realized using<br>
specialized shader languages (<a href=3D"http://en.wikipedia.org/wiki/Shade=
r_language" target=3D"_blank">http://en.wikipedia.org/wiki/Shader_language<=
/a>)<br>
this must be done in user land (may be non RT) tasks taking their data<br>
from RT ones.<br>
<br>
For 2D images may writing directly to some framebuffer<br>
(<a href=3D"http://en.wikipedia.org/wiki/Linux_framebuffer" target=3D"_blan=
k">http://en.wikipedia.org/wiki/Linux_framebuffer</a>)<br>
may be a solution.<br>
<br>
I did never mix Xenomai with such solution, my experience was with<br>
&quot;classical&quot; linux SCHED_FIFO processes reading some serial port<b=
r>
at most at 32Hz with no HARD jitter requirement.<br>
Thus I don&#39;t know the possible &quot;interaction&quot; off an hard RT x=
enomai process<br>
with some fancy graphic driver.<br>
<br>
What is your precise graphic display need?<br>
<br>
Do you want to display animated 3D scene built from RT data?<br>
2D image??<br>
<br>
<br>
--<br>
Erk<br>
Membre de l&#39;April - =AB promouvoir et d=E9fendre le logiciel libre =BB =
-<br>
<a href=3D"http://www.april.org" target=3D"_blank">http://www.april.org</a>=
<br>
<br>
_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
</blockquote></div><br>

--0016367b6a6acef49e0474b66a8f--

