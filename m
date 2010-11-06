MIME-Version: 1.0
In-Reply-To: <4CD59C5F.6030808@domain.hid>
References: <AANLkTimpz6=DWjrKLRoG6O5XGotgQX6FTZR+U2b54awU@mail.gmail.com>
	<4CD55D61.7050208@domain.hid>
	<AANLkTinw+H2shS4SpxhTS7GNOZptjR8xLpcwpzDtKDmi@domain.hid>
	<4CD59C5F.6030808@domain.hid>
Date: Sat, 6 Nov 2010 12:43:23 -0700
Message-ID: <AANLkTikjovoR71pGkAOasVOENj4SiZ4hLYpSidvVxm06@domain.hid>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/alternative; boundary=0016362845f49b9daf0494679a43
Subject: Re: [Xenomai-help] detect mode switches to primary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--0016362845f49b9daf0494679a43
Content-Type: text/plain; charset=ISO-8859-1

Hey Gilles,

>> There is no such thing as unwanted mode switches from secondary mode to
primary mode.
Really ?? I want to ensure that my boarder line thread runs in SECONDARY
mode except when it is accessing the shared memory. The reason for that is
that I want linux to be able to preempt that thread if necessary. I have
enabled the Xenomai watchdog to kill real-time threads when they starve the
linux kernel. Thus, the result is that this watchdog kills (or sometimes
only preempts?) my boarder line thread (preempting is OK, but killing is
NOT). I see that the watchdog kicked in in the logs (dmesg). This happens
roughly every 5-10min or so... My idea is, that if I force the thread to run
in secondary mode (after accessing the shared memory), it will be a regular
linux thread (and can be preempted). Thus, having it switch to primary mode
is unwanted, is it ?

What am I missing here ?

Thanks,
 peter





On Sat, Nov 6, 2010 at 11:20 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Peter Pastor wrote:
> > Hey Gilles,
> >
> > Sorry for all the confusion. I hope my little example pseudo code of the
> > boarder line thread makes things clear.
> >
> > thread_loop()
> > {
> >
> > // access memory that is shared with a real-time thread (that does not
> > mode switch)
> > // calling pthread_mutex_lock causes the current thread to switch to
> > primary mode (in case it is not already in primary mode)
> >
> >   pthread_mutex_lock( &mutex1 );
> >
> > // access shared memory, that is copy memory and nothing else !!
> >
> >   pthread_mutex_unlock( &mutex1 );
> >
> > // Now, I want the rest of the code to run in secondary mode !!
> > // therefore I could simply do a printf or...
> >
> > #ifdef __XENO__
> >   pthread_set_mode_np(PTHREAD_PRIMARY, 0);
> > #endif
>
> This is not needed, the thread will swtich to secondary mode when needed.
>
> >
> > // The thread switched to secondary mode.
> > // Now, I process the data and e.g. display it using openGL or read from
> > the command line. I want this part of the code to run in secondary mode
> !!
> >
> > // I am using the posix skin (/usr/xenomai/bin/xeno-config --skin posix
> > --cflags --ldflags) because I want to be able to compile the code in
> > xenomai and ensure real-time capabilities and also compile on a linux
> > only system for testing.
> >
> > // However, the openGL code or libreadline for example might do a posix
> > function call and cause the thread switch back to primary mode which I
> > don't want !!! ...and want to detect.
>
> No, dynamic libraries will not call xenomai posix skin functions,
> unless, when making the .so, you passed the --wrap flag. Once the .so is
> made, --wrap has no effect.
>
> >
> > }
> >
> >
> > My current approach to detect whether there was an unwanted mode switch
> > from secondary to primary in the non-real-time part of the thread is to
> > detect mode switches from primary to secondary using
> > pthread_set_mode_np(0, PTHREAD_WARNSW) and signal(SIGXCPU,
> > warn_upon_switch)... and do the following
> >
> >
> > thread_loop()
> > {
> >
> > // to check there was an unwanted mode switches to primary mode (in the
> > for example openGL code) I simply do a printf
> > // and check whether this raises the SIGXCPU signal. If so, the thread
> > was running in primary mode, otherwise, the thread was running in
> > secondary mode (which is want I want)
> > // If the thread switched back and force inside the openGL code, I
> > should have noticed it since switching from primary to secondary is
> > captured by the SIGXCPU (is it?)
> >
> > // here is the code...
> >
> > #ifdef __XENO__
> >   printf("test\n");  // in case the thread is running in PRIMARY mode,
> > this will raise a SIGXCPU signal and we conclude that there was an
> > unwanted mode swicht from secondary to primary mode in the openGL code.
> >   pthread_set_mode_np(0,PTHREAD_PRIMARY); // this is unnecessary !!!
> > ...since calling pthread_mutex_lock switches the thread to primary mode
> > automatically.
> > #endif
> >
> >   pthread_mutex_lock( &mutex1 );
> > // access shared memory, that is copy memory and nothing else !!
> >   pthread_mutex_unlock( &mutex1 );
> >
> > // switch back to SECONDARY mode
> > #ifdef __XENO__
> >   pthread_set_mode_np(PTHREAD_PRIMARY, 0);
> > #endif
> >
> > // do non-real-time processing (e.g. openGL stuff, libreadline...).
> >
> > }
> >
> > The question is, is there a better way to detect this unwanted mode
> > switches from secondary to primary mode ?
>
> There is no such thing as unwanted mode switches from secondary mode to
> primary mode.
>
>
> --
>                                                                 Gilles.
>

--0016362845f49b9daf0494679a43
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey Gilles,<br><br>&gt;&gt; There is no such thing as unwanted mode switche=
s from secondary mode to primary mode.<br>Really ?? I want to ensure that m=
y boarder line thread runs in SECONDARY mode except when it is accessing th=
e shared memory. The reason for that is that I want linux to be able to pre=
empt that thread if necessary. I have enabled the Xenomai watchdog to kill =
real-time threads when they starve the linux kernel. Thus, the result is th=
at this watchdog kills (or sometimes only preempts?) my boarder line thread=
 (preempting is OK, but killing is NOT). I see that the watchdog kicked in =
in the logs (dmesg). This happens roughly every 5-10min or so... My idea is=
, that if I force the thread to run in secondary mode (after accessing the =
shared memory), it will be a regular linux thread (and can be preempted). T=
hus, having it switch to primary mode is unwanted, is it ?<br>
<br>What am I missing here ? <br><br>Thanks,<br>=A0peter<br><br><br><br><br=
><br><div class=3D"gmail_quote">On Sat, Nov 6, 2010 at 11:20 AM, Gilles Cha=
nteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
omai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div class=3D"im"=
>Peter Pastor wrote:<br>
&gt; Hey Gilles,<br>
&gt;<br>
&gt; Sorry for all the confusion. I hope my little example pseudo code of t=
he<br>
&gt; boarder line thread makes things clear.<br>
&gt;<br>
&gt; thread_loop()<br>
&gt; {<br>
&gt;<br>
&gt; // access memory that is shared with a real-time thread (that does not=
<br>
&gt; mode switch)<br>
&gt; // calling pthread_mutex_lock causes the current thread to switch to<b=
r>
&gt; primary mode (in case it is not already in primary mode)<br>
&gt;<br>
&gt; =A0 pthread_mutex_lock( &amp;mutex1 );<br>
&gt;<br>
&gt; // access shared memory, that is copy memory and nothing else !!<br>
&gt;<br>
&gt; =A0 pthread_mutex_unlock( &amp;mutex1 );<br>
&gt;<br>
&gt; // Now, I want the rest of the code to run in secondary mode !!<br>
&gt; // therefore I could simply do a printf or...<br>
&gt;<br>
&gt; #ifdef __XENO__<br>
&gt; =A0 pthread_set_mode_np(PTHREAD_PRIMARY, 0);<br>
&gt; #endif<br>
<br>
</div>This is not needed, the thread will swtich to secondary mode when nee=
ded.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; // The thread switched to secondary mode.<br>
&gt; // Now, I process the data and e.g. display it using openGL or read fr=
om<br>
&gt; the command line. I want this part of the code to run in secondary mod=
e !!<br>
&gt;<br>
&gt; // I am using the posix skin (/usr/xenomai/bin/xeno-config --skin posi=
x<br>
&gt; --cflags --ldflags) because I want to be able to compile the code in<b=
r>
&gt; xenomai and ensure real-time capabilities and also compile on a linux<=
br>
&gt; only system for testing.<br>
&gt;<br>
&gt; // However, the openGL code or libreadline for example might do a posi=
x<br>
&gt; function call and cause the thread switch back to primary mode which I=
<br>
&gt; don&#39;t want !!! ...and want to detect.<br>
<br>
</div>No, dynamic libraries will not call xenomai posix skin functions,<br>
unless, when making the .so, you passed the --wrap flag. Once the .so is<br=
>
made, --wrap has no effect.<br>
<div><div></div><div class=3D"h5"><br>
&gt;<br>
&gt; }<br>
&gt;<br>
&gt;<br>
&gt; My current approach to detect whether there was an unwanted mode switc=
h<br>
&gt; from secondary to primary in the non-real-time part of the thread is t=
o<br>
&gt; detect mode switches from primary to secondary using<br>
&gt; pthread_set_mode_np(0, PTHREAD_WARNSW) and signal(SIGXCPU,<br>
&gt; warn_upon_switch)... and do the following<br>
&gt;<br>
&gt;<br>
&gt; thread_loop()<br>
&gt; {<br>
&gt;<br>
&gt; // to check there was an unwanted mode switches to primary mode (in th=
e<br>
&gt; for example openGL code) I simply do a printf<br>
&gt; // and check whether this raises the SIGXCPU signal. If so, the thread=
<br>
&gt; was running in primary mode, otherwise, the thread was running in<br>
&gt; secondary mode (which is want I want)<br>
&gt; // If the thread switched back and force inside the openGL code, I<br>
&gt; should have noticed it since switching from primary to secondary is<br=
>
&gt; captured by the SIGXCPU (is it?)<br>
&gt;<br>
&gt; // here is the code...<br>
&gt;<br>
&gt; #ifdef __XENO__<br>
&gt; =A0 printf(&quot;test\n&quot;); =A0// in case the thread is running in=
 PRIMARY mode,<br>
&gt; this will raise a SIGXCPU signal and we conclude that there was an<br>
&gt; unwanted mode swicht from secondary to primary mode in the openGL code=
.<br>
&gt; =A0 pthread_set_mode_np(0,PTHREAD_PRIMARY); // this is unnecessary !!!=
<br>
&gt; ...since calling pthread_mutex_lock switches the thread to primary mod=
e<br>
&gt; automatically.<br>
&gt; #endif<br>
&gt;<br>
&gt; =A0 pthread_mutex_lock( &amp;mutex1 );<br>
&gt; // access shared memory, that is copy memory and nothing else !!<br>
&gt; =A0 pthread_mutex_unlock( &amp;mutex1 );<br>
&gt;<br>
&gt; // switch back to SECONDARY mode<br>
&gt; #ifdef __XENO__<br>
&gt; =A0 pthread_set_mode_np(PTHREAD_PRIMARY, 0);<br>
&gt; #endif<br>
&gt;<br>
&gt; // do non-real-time processing (e.g. openGL stuff, libreadline...).<br=
>
&gt;<br>
&gt; }<br>
&gt;<br>
&gt; The question is, is there a better way to detect this unwanted mode<br=
>
&gt; switches from secondary to primary mode ?<br>
<br>
</div></div>There is no such thing as unwanted mode switches from secondary=
 mode to<br>
primary mode.<br>
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br>

--0016362845f49b9daf0494679a43--

