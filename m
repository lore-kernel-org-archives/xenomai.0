MIME-Version: 1.0
In-Reply-To: <1289816369.1933.97.camel@domain.hid>
References: <AANLkTimpBp3+w3thbLwCSiTz--h7HBZx+ZLtV4vhbemo@domain.hid>
	<1289816369.1933.97.camel@domain.hid>
Date: Thu, 18 Nov 2010 17:07:50 +0100
Message-ID: <AANLkTikwfiP6UAO4VmJ8rjYvoZgeS+FwVRqBGR6RCKjZ@mail.gmail.com>
From: ronny meeus <ronny.meeus@domain.hid>
Content-Type: multipart/alternative; boundary=0016364c7111d7d062049555fd54
Subject: Re: [Xenomai-help] psos+ Skin: argument passing to task body
 sometimes failing
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
Cc: Xenomai-help@domain.hid

--0016364c7111d7d062049555fd54
Content-Type: text/plain; charset=ISO-8859-1

Philippe,

this patch looks fine. The cases in which I saw an issue are working well
after applying the patch.
Thanks

Best regards,
Ronny

On Mon, Nov 15, 2010 at 11:19 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Wed, 2010-10-20 at 22:28 +0200, ronny meeus wrote:
> > Hello
> >
> > it is me again.
> >
> > This is the configuration I'm using: Target based on QEMU, Xenomai
> > 2.5.4 and the PSOS skin.
> > [    0.623238] Xenomai: hal/i386 started.
> > [    0.633758] Xenomai: scheduling class idle registered.
> > [    0.636172] Xenomai: scheduling class rt registered.
> > [    0.693178] Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.
> > [    0.723234] Xenomai: starting native API services.
> > [    0.728107] Xenomai: starting pSOS+ services.
> >
> > I sometimes observe issues in passing task arguments to the taskbody
> > of the pSOS task.
> > Observations:
> > 1 During debugging I observe in 50% of the cases that all arguments of
> > some task are 0 (all 4). There is no issue with this task if the
> > debugger is not used.
> > 2 During a task creation (in some scenarios) I see in 100% of the
> > cases that all arguments are 0 while the parameters are fine for other
> > application scenarios where the same code is used to create the task
> > itself.
> >
> > Conclusion: strange behavior is seen (looks like a race
> > condition ...).
> >
> > I did already some research in the code and on the web and came across
> > following thread:
> > http://www.mail-archive.com/xenomai@xenomai.org
> >
> > This explains the mechanism and also talks about a problem that has
> > been resolved in this area.
> > I think there is still a gap somewhere.
>
> That bug was never addressed actually (errno = EPROCRASTINATE). Try this
> patch:
>
> http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=4f30d401be83bb7754b018c82f6f8791c75da06f
>
> --
> Philippe.
>
>
>

--0016364c7111d7d062049555fd54
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe,<br><br>this patch looks fine. The cases in which I saw an issue a=
re working well after applying the patch.<br>Thanks<br><br>Best regards,<br=
>Ronny<br><br><div class=3D"gmail_quote">On Mon, Nov 15, 2010 at 11:19 AM, =
Philippe Gerum <span dir=3D"ltr">&lt;<a href=3D"mailto:rpm@xenomai.org">rpm=
@xenomai.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"h5">On Wed, 2010-10-20 at 22:28 +0200, ronny meeus wrote:<br>
&gt; Hello<br>
&gt;<br>
&gt; it is me again.<br>
&gt;<br>
&gt; This is the configuration I&#39;m using: Target based on QEMU, Xenomai=
<br>
&gt; 2.5.4 and the PSOS skin.<br>
&gt; [ =A0 =A00.623238] Xenomai: hal/i386 started.<br>
&gt; [ =A0 =A00.633758] Xenomai: scheduling class idle registered.<br>
&gt; [ =A0 =A00.636172] Xenomai: scheduling class rt registered.<br>
&gt; [ =A0 =A00.693178] Xenomai: real-time nucleus v2.5.4 (Sleep Walk) load=
ed.<br>
&gt; [ =A0 =A00.723234] Xenomai: starting native API services.<br>
&gt; [ =A0 =A00.728107] Xenomai: starting pSOS+ services.<br>
&gt;<br>
&gt; I sometimes observe issues in passing task arguments to the taskbody<b=
r>
&gt; of the pSOS task.<br>
&gt; Observations:<br>
&gt; 1 During debugging I observe in 50% of the cases that all arguments of=
<br>
&gt; some task are 0 (all 4). There is no issue with this task if the<br>
&gt; debugger is not used.<br>
&gt; 2 During a task creation (in some scenarios) I see in 100% of the<br>
&gt; cases that all arguments are 0 while the parameters are fine for other=
<br>
&gt; application scenarios where the same code is used to create the task<b=
r>
&gt; itself.<br>
&gt;<br>
&gt; Conclusion: strange behavior is seen (looks like a race<br>
&gt; condition ...).<br>
&gt;<br>
&gt; I did already some research in the code and on the web and came across=
<br>
&gt; following thread:<br>
&gt; <a href=3D"http://www.mail-archive.com/xenomai@xenomai.org=
tml" target=3D"_blank">http://www.mail-archive.com/xenomai@xenomai.org=
04470.html</a><br>
&gt;<br>
&gt; This explains the mechanism and also talks about a problem that has<br=
>
&gt; been resolved in this area.<br>
&gt; I think there is still a gap somewhere.<br>
<br>
</div></div>That bug was never addressed actually (errno =3D EPROCRASTINATE=
). Try this<br>
patch:<br>
<a href=3D"http://git.xenomai.org/?p=3Dxenomai-rpm.git;a=3Dcommit;h=3D4f30d=
401be83bb7754b018c82f6f8791c75da06f" target=3D"_blank">http://git.xenomai.o=
rg/?p=3Dxenomai-rpm.git;a=3Dcommit;h=3D4f30d401be83bb7754b018c82f6f8791c75d=
a06f</a><br>

<br>
--<br>
<font color=3D"#888888">Philippe.<br>
<br>
<br>
</font></blockquote></div><br>

--0016364c7111d7d062049555fd54--

