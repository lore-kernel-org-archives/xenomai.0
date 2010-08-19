MIME-Version: 1.0
In-Reply-To: <4C6CE4E0.1000609@domain.hid>
References: <AANLkTi=2kNE2KznfnY0voTbWMFqy5_LESXswjJ25O-hk@domain.hid>
	<4C6C019D.1040406@domain.hid>
	<AANLkTi=uuzsAsgt8mk04VJE0-tmd1YQ5KoiTu3a-dO3v@domain.hid>
	<4C6CE4E0.1000609@domain.hid>
Date: Thu, 19 Aug 2010 16:11:00 +0530
Message-ID: <AANLkTimS-p0OWzrhuwuLwN27hUvQqTML8B-YALRwLuxz@domain.hid>
From: Prakash A S <asprakash83@domain.hid>
Content-Type: multipart/alternative; boundary=001636c5a4fe712148048e2ad15d
Subject: Re: [Xenomai-help] Timing calculation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--001636c5a4fe712148048e2ad15d
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Aug 19, 2010 at 1:31 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Prakash A S wrote:
> > On Wed, Aug 18, 2010 at 9:21 PM, Gilles Chanteperdrix <
> >> We still receive HTML.
> >>
> >
> > May be because of simply copy and pasted the old content in the last
> thread.
> >
> > How about the scenario now?.
>
> Nope. Still multipart/alternative with HTML.
>

Sorry, I have no clue why its happening.



>
> >
> >
> >>> Obviously I should improve my C language skills.
> >>>
> >>> I am using linux kernel 2.6.30.8 on Ubuntu 8.04,
> >>> Adeos-ipipe-2.6.30.8-x86-2.4-09.patch and Xenomai-2.5.3
> >> What about the kernel configuration and self-contained test exhibiting
> >> the behaviour you do not understand?
> >>
> >
> > My .config file is here, http://pastebin.ca/1919917
>
> This .config is wrong: it has ACPI disabled.
>
>
I will enabled the ACPI, recompile the kernel and get back to you later.


> > I tested and understand few test cases below.
> > switchtest : I am using Intel Dual core processor. ~5731 context switches
> > happening in a second
> > cyclictest : Tested with 10 threads. Maximum timer latency is 38us and
> > minimum is 1us
> > clocktest : Simply prints the time offset, drift value and wraps compare
> > with normal linux's gettimeofday(). Not much understand from this test.
> > latency : user mode latency test provides maximum latency time is 15us.
> > latency : kernel mode latency test provides maximum latency time is 3.6
> us
> > latency : timer mode latency test provides maximum latency time is 3 us
>
> So, timing works correctly. If there was something wrong with time
> keeping, you would have seen latency and switchtest drifting, and
> printing infinitely increasing or decreasing latencies.
>

Valuable information.


>
> >
> > Not much understand about the clocktest.
> > More helpful if we have any documentations for the all tests rather than
> how
> > to use the tests.
>
> The fact that ACPI must be enabled is documented, though you disabled
> it, which proves that you do not read the documentation.
>

Let me know which document you are talking about?.
>From the beginners point of view, he/she is trying to install a software
successfully first and not to worry about the performance scale at initial
stage. In the kernel compilation part disabling power management option is
one of the usual step followed by the beginners. I did the same and later,
forgot that its an important factor.

Hope you remember that the issue was posted by another community person
regarding the booting issue after he compiled the kernel. I suggested to use
"noacpi" "nolapci" in boot argument.  Though the system was booted properly,
your suggestion was, not to use this option. Bcoz the kernel unable to use
ACPI. So we have two scenarios here.
[1]If we disable the ACPI in BIOS level then the kernel is booting properly.
But, the real time system can not use ACPI
[2] ACPI enabled. But system will not boot properly.

So how to resolve the above issue and please share if you have any specific
documents/guidelines/howto/articles on how this ACPI affects the normal
Linux and real time systems & why it is mandatory for xenomai.


>
> What I would like you is to do is to write a self-contained as simple as
> possible test which exhibits the behaviour you find suspicious, and
> publish it here so that I can try and reproduce this behaviour.
>
>
I will try such an simple example and get back to you later.

-Prakash

--001636c5a4fe712148048e2ad15d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Aug 19, 2010 at 1:31 PM, Gilles =
Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@=
xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204,=
 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">Prakash A S wrote:<br>
&gt; On Wed, Aug 18, 2010 at 9:21 PM, Gilles Chanteperdrix &lt;<br>
</div><div class=3D"im">&gt;&gt; We still receive HTML.<br>
&gt;&gt;<br>
&gt;<br>
&gt; May be because of simply copy and pasted the old content in the last t=
hread.<br>
&gt;<br>
&gt; How about the scenario now?.<br>
<br>
</div>Nope. Still multipart/alternative with HTML.<br></blockquote><div><br=
>Sorry, I have no clue why its happening. <br><br>=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margi=
n: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<div class=3D"im"><br>
&gt;<br>
&gt;<br>
&gt;&gt;&gt; Obviously I should improve my C language skills.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I am using linux kernel 2.6.30.8 on Ubuntu 8.04,<br>
&gt;&gt;&gt; Adeos-ipipe-2.6.30.8-x86-2.4-09.patch and Xenomai-2.5.3<br>
&gt;&gt; What about the kernel configuration and self-contained test exhibi=
ting<br>
&gt;&gt; the behaviour you do not understand?<br>
&gt;&gt;<br>
&gt;<br>
&gt; My .config file is here, <a href=3D"http://pastebin.ca/1919917" target=
=3D"_blank">http://pastebin.ca/1919917</a><br>
<br>
</div>This .config is wrong: it has ACPI disabled.<br>
<div class=3D"im"><br></div></blockquote><div><br>I will enabled the ACPI, =
recompile the kernel and get back to you later.<br>=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); marg=
in: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">
&gt; I tested and understand few test cases below.<br>
&gt; switchtest : I am using Intel Dual core processor. ~5731 context switc=
hes<br>
&gt; happening in a second<br>
&gt; cyclictest : Tested with 10 threads. Maximum timer latency is 38us and=
<br>
&gt; minimum is 1us<br>
&gt; clocktest : Simply prints the time offset, drift value and wraps compa=
re<br>
&gt; with normal linux&#39;s gettimeofday(). Not much understand from this =
test.<br>
&gt; latency : user mode latency test provides maximum latency time is 15us=
.<br>
&gt; latency : kernel mode latency test provides maximum latency time is 3.=
6 us<br>
&gt; latency : timer mode latency test provides maximum latency time is 3 u=
s<br>
<br>
</div>So, timing works correctly. If there was something wrong with time<br=
>
keeping, you would have seen latency and switchtest drifting, and<br>
printing infinitely increasing or decreasing latencies.<br></blockquote><di=
v><br>Valuable information.<br>=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">

<div class=3D"im"><br>
&gt;<br>
&gt; Not much understand about the clocktest.<br>
&gt; More helpful if we have any documentations for the all tests rather th=
an how<br>
&gt; to use the tests.<br>
<br>
</div>The fact that ACPI must be enabled is documented, though you disabled=
<br>
it, which proves that you do not read the documentation.<br></blockquote><d=
iv><br>Let me know which document you are talking about?.<br>From the begin=
ners point of view, he/she is trying to install a software successfully fir=
st and not to worry about the performance scale at initial stage. In the ke=
rnel compilation part disabling power management option is one of the usual=
 step followed by the beginners. I did the same and later, forgot that its =
an important factor. <br>
<br>Hope you remember that the issue was posted by another community person=
 regarding the booting issue after he compiled the kernel. I suggested to u=
se &quot;noacpi&quot; &quot;nolapci&quot; in boot argument.=A0 Though the s=
ystem was booted properly, your suggestion was, not to use this option. Bco=
z the kernel unable to use ACPI. So we have two scenarios here. <br>
[1]If we disable the ACPI in BIOS level then the kernel is booting properly=
. But, the real time system can not use ACPI<br>[2] ACPI enabled. But syste=
m will not boot properly.<br><br>So how to resolve the above issue and plea=
se share if you have any specific documents/guidelines/howto/articles on ho=
w this ACPI affects the normal Linux and real time systems &amp; why it is =
mandatory for xenomai.=A0 =A0 =A0 <br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
What I would like you is to do is to write a self-contained as simple as<br=
>
possible test which exhibits the behaviour you find suspicious, and <br>
publish it here so that I can try and reproduce this behaviour.<br>
<br></blockquote></div><br>I will try such an simple example and get back t=
o you later.<br><br>-Prakash<br>

--001636c5a4fe712148048e2ad15d--

