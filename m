MIME-Version: 1.0
In-Reply-To: <4C72D8C7.6000303@domain.hid>
References: <AANLkTik6qbZkrFyWYC4HQten+EcfHLboiSN2eRtTTqnQ@mail.gmail.com>
	<4C72D8C7.6000303@domain.hid>
Date: Tue, 24 Aug 2010 12:25:35 +0200
Message-ID: <AANLkTinZWo-U-mFzhKq3MjsTs6dr7zh49xZzWZVXe9wu@domain.hid>
From: ramon costa <ramoncostacastello@domain.hid>
Content-Type: multipart/alternative; boundary=00163630f35f7e8aaf048e8f2ffd
Subject: Re: [Xenomai-help] periodical task in posix skin
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
Cc: Xenomai help <xenomai@xenomai.org>

--00163630f35f7e8aaf048e8f2ffd
Content-Type: text/plain; charset=ISO-8859-1

Hi,


>
> > I also have tried
> >
> >        struct timespec period;
> >        period.tv_sec=0;
> >        period.tv_nsec=PERIOD;
> >
> >         clock_gettime      ( CLOCK_REALTIME, &now);
> >         pthread_make_periodic_np (pthread_self(), &now,&period);
> >
> > Although both compile and execute, non of them works fine to me. Any clue
> ?
>
> Here I have no clue, more exactly, I would need to see the whole code to
> see what is going wrong. But again, checking pthread_make_periodic_np
> return value, and looking at the documentation would help. My guess
> would be that at the time of pthread_make_periodic_np, "now" is a date
> in the past.
>

Yes !!! You are completelly right !!

I was following RTLinux scheme and that made me to fail.
Current code is :

clock_gettime      ( TIMER_ABSTIME, &now);
now.tv_nsec=now.tv_nsec+PERIOD;
out=pthread_make_periodic_np (pthread_self(), &now,&period);
       switch(out){
         case 0 :
          break;
         case ESRCH:
        printf("thread is invalid \n");
        pthread_exit ((void *)-1);
          break;
         case ETIMEDOUT :
        printf("the start time has already passed\n");
        pthread_exit ((void *)-1);
          break;
         default :
        printf(" output value not defined \n");
            pthread_exit ((void *)-1);
    }




>
> And pthread_make_periodic_np/pthread_wait_np are supposed to help
> porting code from RTLinux, they should not be used in new programs. You
> should be using clock_gettime with the TIMER_ABSTIME flag.
>

This is very useful for porting from RTLinux which is exactly what I'm
doing.

Any suggestion to substitute pthread_make_periodic_np and  pthread_wait_np
in a POSIX skin ?



Thank you very much
Ramon

--00163630f35f7e8aaf048e8f2ffd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br>=A0<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8=
ex; padding-left: 1ex;"><br><div class=3D"im">
&gt; I also have tried<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0struct timespec period;<br>
&gt; =A0 =A0 =A0 =A0period.tv_sec=3D0;<br>
&gt; =A0 =A0 =A0 =A0period.tv_nsec=3DPERIOD;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 clock_gettime =A0 =A0 =A0( CLOCK_REALTIME, &amp;now);<=
br>
&gt; =A0 =A0 =A0 =A0 pthread_make_periodic_np (pthread_self(), &amp;now,&am=
p;period);<br>
&gt;<br>
&gt; Although both compile and execute, non of them works fine to me. Any c=
lue ?<br>
<br>
</div>Here I have no clue, more exactly, I would need to see the whole code=
 to<br>
see what is going wrong. But again, checking pthread_make_periodic_np<br>
return value, and looking at the documentation would help. My guess<br>
would be that at the time of pthread_make_periodic_np, &quot;now&quot; is a=
 date<br>
in the past.<br></blockquote><div><br>Yes !!! You are completelly right !!<=
br><br>I was following RTLinux scheme and that made me to fail.<br>Current =
code is :<br><br>clock_gettime=A0 =A0=A0=A0 ( TIMER_ABSTIME, &amp;now);<br>=
now.tv_nsec=3Dnow.tv_nsec+PERIOD;<br>
out=3Dpthread_make_periodic_np (pthread_self(), &amp;now,&amp;period);<br>=
=A0=A0=A0=A0=A0=A0 switch(out){<br>=A0=A0=A0=A0=A0=A0=A0=A0 case 0 : <br>=
=A0=A0=A0 =A0=A0=A0=A0=A0 break;<br>=A0=A0=A0=A0=A0=A0=A0=A0 case ESRCH: <b=
r>=A0=A0=A0 =A0=A0=A0 printf(&quot;thread is invalid \n&quot;); <br>=A0=A0=
=A0 =A0=A0=A0 pthread_exit ((void *)-1);=A0 <br>
=A0=A0=A0 =A0=A0=A0=A0=A0 break;<br>=A0=A0=A0=A0=A0=A0=A0=A0 case ETIMEDOUT=
 : <br>=A0=A0=A0 =A0=A0=A0 printf(&quot;the start time has already passed\n=
&quot;); <br>=A0=A0=A0 =A0=A0=A0 pthread_exit ((void *)-1); <br>=A0=A0=A0 =
=A0=A0=A0=A0=A0 break;<br>=A0=A0=A0=A0=A0=A0=A0=A0 default : <br>=A0=A0=A0 =
=A0=A0=A0 printf(&quot; output value not defined \n&quot;); <br>
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 pthread_exit ((void *)-1); <br>=A0=A0=A0 }<=
br><br><br>=A0<br></div><blockquote class=3D"gmail_quote" style=3D"border-l=
eft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left:=
 1ex;">
<br>
And pthread_make_periodic_np/pthread_wait_np are supposed to help<br>
porting code from RTLinux, they should not be used in new programs. You<br>
should be using clock_gettime with the TIMER_ABSTIME flag.<br></blockquote>=
<div><br>This is very useful for porting from RTLinux which is exactly what=
 I&#39;m doing.<br><br>Any suggestion to substitute pthread_make_periodic_n=
p and=A0 pthread_wait_np in a POSIX skin ?<br>
<br><br><br>Thank you very much<br>Ramon</div></div><br>

--00163630f35f7e8aaf048e8f2ffd--

