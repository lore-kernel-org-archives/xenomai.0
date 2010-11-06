MIME-Version: 1.0
In-Reply-To: <4CD55D61.7050208@domain.hid>
References: <AANLkTimpz6=DWjrKLRoG6O5XGotgQX6FTZR+U2b54awU@mail.gmail.com>
	<4CD55D61.7050208@domain.hid>
Date: Sat, 6 Nov 2010 10:03:58 -0700
Message-ID: <AANLkTinw+H2shS4SpxhTS7GNOZptjR8xLpcwpzDtKDmi@domain.hid>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/alternative; boundary=0016364ee31e7a27af0494656071
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

--0016364ee31e7a27af0494656071
Content-Type: text/plain; charset=ISO-8859-1

Hey Gilles,

Sorry for all the confusion. I hope my little example pseudo code of the
boarder line thread makes things clear.

thread_loop()
{

// access memory that is shared with a real-time thread (that does not mode
switch)
// calling pthread_mutex_lock causes the current thread to switch to primary
mode (in case it is not already in primary mode)

  pthread_mutex_lock( &mutex1 );

// access shared memory, that is copy memory and nothing else !!

  pthread_mutex_unlock( &mutex1 );

// Now, I want the rest of the code to run in secondary mode !!
// therefore I could simply do a printf or...

#ifdef __XENO__
  pthread_set_mode_np(PTHREAD_PRIMARY, 0);
#endif

// The thread switched to secondary mode.
// Now, I process the data and e.g. display it using openGL or read from the
command line. I want this part of the code to run in secondary mode !!

// I am using the posix skin (/usr/xenomai/bin/xeno-config --skin posix
--cflags --ldflags) because I want to be able to compile the code in xenomai
and ensure real-time capabilities and also compile on a linux only system
for testing.

// However, the openGL code or libreadline for example might do a posix
function call and cause the thread switch back to primary mode which I don't
want !!! ...and want to detect.

}


My current approach to detect whether there was an unwanted mode switch from
secondary to primary in the non-real-time part of the thread is to detect
mode switches from primary to secondary using pthread_set_mode_np(0,
PTHREAD_WARNSW) and signal(SIGXCPU, warn_upon_switch)... and do the
following


thread_loop()
{

// to check there was an unwanted mode switches to primary mode (in the for
example openGL code) I simply do a printf
// and check whether this raises the SIGXCPU signal. If so, the thread was
running in primary mode, otherwise, the thread was running in secondary mode
(which is want I want)
// If the thread switched back and force inside the openGL code, I should
have noticed it since switching from primary to secondary is captured by the
SIGXCPU (is it?)

// here is the code...

#ifdef __XENO__
  printf("test\n");  // in case the thread is running in PRIMARY mode, this
will raise a SIGXCPU signal and we conclude that there was an unwanted mode
swicht from secondary to primary mode in the openGL code.
  pthread_set_mode_np(0,PTHREAD_PRIMARY); // this is unnecessary !!!
...since calling pthread_mutex_lock switches the thread to primary mode
automatically.
#endif

  pthread_mutex_lock( &mutex1 );
// access shared memory, that is copy memory and nothing else !!
  pthread_mutex_unlock( &mutex1 );

// switch back to SECONDARY mode
#ifdef __XENO__
  pthread_set_mode_np(PTHREAD_PRIMARY, 0);
#endif

// do non-real-time processing (e.g. openGL stuff, libreadline...).

}

The question is, is there a better way to detect this unwanted mode switches
from secondary to primary mode ?

I just read your last mail and it seems that there is still some sort of
misunderstanding..

>> A high priority thread running in secondary mode is not what you want...
Yes, that is true, however that is not want I am doing, correct ? The
boarder line thread (above) runs in primary mode for exactly the "three
lines of code" (1) lock mutex (2) access "shared" memory and (3) unlock
mutex
The rest of the code in the boarder line thread should be executed in
secondary mode where it can be preempted by the linux kernel, which is ok.
It does not influence the real-time thread that writes to the "shared"
memory, does it. There is no synchronization between the real-time thread
and the boarder line thread required !!! Thus, there is no guarantee that
the boarder line thread does not miss cycles (shared memory updates) of the
real-time thread, which is OK.

>> Something else: if you want to avoid issues, the mutex protecting the
>> shared memory area shared between a high priority thread and the border
>> line thread should have priority inheritance enabled.
I can see why "priority inheritance enabled" makes sense here (which is what
I do). Just to verify my understanding, priority inheritance gives the
boarder-line thread a higher priority once it is holding the lock in order
to have it run and release the mutex again. Otherwise the high-priority
thread may starve the system when trying to lock the mutex which is hold by
the lower priority (boarder-line) thread.

Thanks for all the clarifications,
 peter


On Sat, Nov 6, 2010 at 6:51 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Peter Pastor wrote:
> > Dear all,
> >
> > I am running several boarder line threads that are running in primary
> > mode only when accessing some shared memory, otherwise I want them to
> > run in secondary mode. I have used rt_task_set_mode to warn me upon
> > switches to secondary modes, however, my question is, is there a similar
> > way to detect mode switches to primary mode ?
> >
> > I have figured out a workaround using pthread_set_mode_np to force the
> > thread to run in secondary mode (after shared memory access) and right
> > before I force it back to primary mode do a printf and see whether I get
> > a warning of switching into secondary mode (if so, then I know that the
> > thread was running in primary mode, if not, then the thread was running
> > in secondary mode.)
> >
> > Again, my question is, is there an elegant way to detect mode switches
> > from secondary mode to primary mode ?
>
> No there is not. The reason to detect switches from primary to secondary
> mode is to debug issues of threads which should remain in primary mode,
> nothing else. And pthread_set_mode_np(PTHREAD_PRIMARY) is deprecated.
>
> If you have a borderline thread sharing memory with a primary-mode only
> thread, you are supposed to protect the accesses to the shared memory
> with a mutex, then the borderline thread will automatically switch to
> primary mode when it acquires the mutex. When it gets out of this
> critical section and it calls a function which requires running in
> secondary mode, then it will switch automatically to secondary mode.
>
> Next versions of Xenomai will get this borderline thread to switch
> automatically to secondary mode when it releases the mutex (the patch
> already exists).
>
> --
>                                                                 Gilles.
>

--0016364ee31e7a27af0494656071
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hey Gilles,<br><br>Sorry for all the confusion. I hope my little example ps=
eudo code of the boarder line thread makes things clear.<br><br>thread_loop=
()<br>{<br><br>// access memory that is shared with a real-time thread (tha=
t does not mode switch)<br>
// calling pthread_mutex_lock causes the current thread to switch to primar=
y mode (in case it is not already in primary mode)<br><br>=A0 pthread_mutex=
_lock( &amp;mutex1 );<br><br>// access shared memory, that is copy memory a=
nd nothing else !!<br>
<br>=A0 pthread_mutex_unlock( &amp;mutex1 );<br><br>// Now, I want the rest=
 of the code to run in secondary mode !!<br>// therefore I could simply do =
a printf or...<br><br>#ifdef __XENO__<br>=A0 pthread_set_mode_np(PTHREAD_PR=
IMARY, 0);<br>
#endif<br><br>// The thread switched to secondary mode.<br>// Now, I proces=
s the data and e.g. display it using openGL or read from the command line. =
I want this part of the code to run in secondary mode !!<br><br>// I am usi=
ng the posix skin (/usr/xenomai/bin/xeno-config --skin posix --cflags --ldf=
lags) because I want to be able to compile the code=20
in xenomai and ensure real-time capabilities and also compile on a linux
 only system for testing.<br>
<br>// However, the openGL code or libreadline for example might do a posix=
 function call and cause the thread switch back to primary mode which I don=
&#39;t want !!! ...and want to detect.<br><br>}<br><br><br>My current appro=
ach to detect whether there was an unwanted mode switch from secondary to p=
rimary in the non-real-time part of the thread is to detect mode switches f=
rom primary to secondary using pthread_set_mode_np(0, PTHREAD_WARNSW) and s=
ignal(SIGXCPU, warn_upon_switch)... and do the following<br>
<pre class=3D"fragment"></pre><br>thread_loop()<br>{<br><br>// to check the=
re was an unwanted mode switches to primary mode  (in the for example openG=
L code) I simply do a printf<br>// and check whether this raises the SIGXCP=
U signal. If so, the thread was running in primary mode, otherwise, the thr=
ead was running in secondary mode (which is want I want)<br>
// If the thread switched back and force inside the openGL code, I should h=
ave noticed it since switching from primary to secondary is captured by the=
 SIGXCPU (is it?)<br><br>// here is the code...<br><br>#ifdef __XENO__<br>
=A0 printf(&quot;test\n&quot;);=A0 // in case the thread is running in PRIM=
ARY mode, this will raise a SIGXCPU signal and we conclude that there was a=
n unwanted mode swicht from secondary to primary mode in the openGL code.<b=
r>

=A0 pthread_set_mode_np(0,PTHREAD_PRIMARY); // this is unnecessary !!! ...s=
ince calling pthread_mutex_lock switches the thread to primary mode automat=
ically.<br>#endif<br><br>=A0 pthread_mutex_lock( &amp;mutex1 );<br>// acces=
s shared memory, that is copy memory and nothing else !!<br>
=A0 pthread_mutex_unlock( &amp;mutex1 );<br><br>// switch back to SECONDARY=
 mode<br>#ifdef __XENO__<br>=A0 pthread_set_mode_np(PTHREAD_PRIMARY, 0);<br=
>#endif<br><br>// do non-real-time processing (e.g. openGL stuff, libreadli=
ne...).<br>
<br>}<br><br>The question is, is there a better way to detect this unwanted=
 mode switches from secondary to primary mode ?<br><br>I just read your las=
t mail and it seems that there is still some sort of misunderstanding..<br>
<br>&gt;&gt; A high priority thread running in secondary mode is not what y=
ou want...<br>Yes, that is true, however that is not want I am doing, corre=
ct ? The boarder line thread (above) runs in primary mode for exactly the &=
quot;three lines of code&quot; (1) lock mutex (2) access &quot;shared&quot;=
 memory and (3) unlock mutex<br>
The rest of the code in the boarder line thread should be executed in secon=
dary mode where it can be preempted by the linux kernel, which is ok. It do=
es not influence the real-time thread that writes to the &quot;shared&quot;=
 memory, does it. There is no synchronization between the real-time thread =
and the boarder line thread required !!! Thus, there is no guarantee that t=
he boarder line thread does not miss cycles (shared memory updates) of the =
real-time thread, which is OK.<br>

<br>
&gt;&gt; Something else: if you want to avoid issues, the mutex protecting =
the<br>


&gt;&gt; shared memory area shared between a high priority thread and the b=
order<br>
&gt;&gt; line thread should have priority inheritance enabled.<br>I can see=
 why &quot;priority inheritance enabled&quot; makes sense here (which is wh=
at I do). Just to verify my understanding, priority inheritance gives the b=
oarder-line thread a higher priority once it is holding the lock in order t=
o have it run and release the mutex again. Otherwise the high-priority thre=
ad may starve the system when trying to lock the mutex which is hold by the=
 lower priority (boarder-line) thread.<br>
<br>Thanks for all the clarifications,<br>=A0peter<br><br><br><div class=3D=
"gmail_quote">On Sat, Nov 6, 2010 at 6:51 AM, Gilles Chanteperdrix <span di=
r=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.ch=
anteperdrix@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div><div></div><=
div class=3D"h5">Peter Pastor wrote:<br>
&gt; Dear all,<br>
&gt;<br>
&gt; I am running several boarder line threads that are running in primary<=
br>
&gt; mode only when accessing some shared memory, otherwise I want them to<=
br>
&gt; run in secondary mode. I have used rt_task_set_mode to warn me upon<br=
>
&gt; switches to secondary modes, however, my question is, is there a simil=
ar<br>
&gt; way to detect mode switches to primary mode ?<br>
&gt;<br>
&gt; I have figured out a workaround using pthread_set_mode_np to force the=
<br>
&gt; thread to run in secondary mode (after shared memory access) and right=
<br>
&gt; before I force it back to primary mode do a printf and see whether I g=
et<br>
&gt; a warning of switching into secondary mode (if so, then I know that th=
e<br>
&gt; thread was running in primary mode, if not, then the thread was runnin=
g<br>
&gt; in secondary mode.)<br>
&gt;<br>
&gt; Again, my question is, is there an elegant way to detect mode switches=
<br>
&gt; from secondary mode to primary mode ?<br>
<br>
</div></div>No there is not. The reason to detect switches from primary to =
secondary<br>
mode is to debug issues of threads which should remain in primary mode,<br>
nothing else. And pthread_set_mode_np(PTHREAD_PRIMARY) is deprecated.<br>
<br>
If you have a borderline thread sharing memory with a primary-mode only<br>
thread, you are supposed to protect the accesses to the shared memory<br>
with a mutex, then the borderline thread will automatically switch to<br>
primary mode when it acquires the mutex. When it gets out of this<br>
critical section and it calls a function which requires running in<br>
secondary mode, then it will switch automatically to secondary mode.<br>
<br>
Next versions of Xenomai will get this borderline thread to switch<br>
automatically to secondary mode when it releases the mutex (the patch<br>
already exists).<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br>

--0016364ee31e7a27af0494656071--

