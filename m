MIME-Version: 1.0
In-Reply-To: <4DB83CBE.5040007@domain.hid>
References: <4DB8149A.7080600@domain.hid>
	<4DB83CBE.5040007@domain.hid>
Date: Wed, 27 Apr 2011 23:49:01 +0600
Message-ID: <BANLkTikmzwturTQNB20eiaOkEYdhEnBmyw@domain.hid>
From: Alexey Galakhov <agalakhov@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba5bc9c9515d0c04a1ea0e07
Subject: Re: [Adeos-main] Ipipe hangs on ARM MINI2440 after switching
	clocksource
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

--90e6ba5bc9c9515d0c04a1ea0e07
Content-Type: text/plain; charset=ISO-8859-1

>
> There was a bug some time ago, which was fixed for TIMER3, see commit:
>
> http://git.xenomai.org/?p=ipipe-gch.git;a=commit;h=ebf2fac4298e25509ba47942b9fad408dcefce1e
>

Oh, I know about this bug. That's the first thing I checked. I found that it
is already fixed in my case. However, it is still unclear for me where the
correct MUXes for timer4 and timer3 are initialized, seems to be kind of
magic. I didn't checked TCFGs against the datasheet, going to do it now. I
also think about making the free-running timer selectable from config since
some machines may have something wired to timer3's PWM.

I forgot to say, it works with patched kernel if CONFIG_IPIPE=no. Timers are
the same in both cases. I don't quite understand, however, how the
non-working free-running timer may affect the system in that case.
Interrupts from timer4 are still generated, so the system may boot with
ipipe off even with broken free-running timer without any obvious problems,
am I right?


> But I think your problem has more to do with the following commit, could
> you try reverting it?
>
> http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=6ab29d9c7a4b119f45ef4d93780e894fe1c0c6c6;hp=cd9c5e016092258d4450e137be2d0844d0fe8b38
>
> The same issue was reported on ixp4xx.
>

I'll give it a try tomorrow, thanks. A little question about this part of
the patch:
-       if (!__ipipe_mach_timerstolen)
+       if (!__ipipe_mach_timerstolen) {
+               spin_lock(&timer_lock);
                getticksoffset_tscupdate();
+               spin_unlock(&timer_lock);
+       }
Is it a bugfix (forgotten spinlock added) or is it due to change of
getticksoffset_tscupdate() contents? (Just trying to understand how it
works.)

--
Alex

--90e6ba5bc9c9515d0c04a1ea0e07
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-le=
ft: 1ex;">There was a bug some time ago, which was fixed for TIMER3, see co=
mmit:<br>

<a href=3D"http://git.xenomai.org/?p=3Dipipe-gch.git;a=3Dcommit;h=3Debf2fac=
4298e25509ba47942b9fad408dcefce1e" target=3D"_blank">http://git.xenomai.org=
/?p=3Dipipe-gch.git;a=3Dcommit;h=3Debf2fac4298e25509ba47942b9fad408dcefce1e=
</a><br></blockquote>
<div><br>Oh, I know about this bug. That&#39;s the first thing I checked. I=
 found that it is already fixed in my case. However, it is still unclear fo=
r me where the correct MUXes for timer4 and timer3 are initialized, seems t=
o be kind of magic. I didn&#39;t checked TCFGs against the datasheet, going=
 to do it now. I also think about making the free-running timer selectable =
from config since some machines may have something wired to timer3&#39;s PW=
M.<br>
<br>I forgot to say, it works with patched kernel if CONFIG_IPIPE=3Dno. Tim=
ers are the same in both cases. I don&#39;t quite understand, however, how =
the non-working free-running timer may affect the system in that case. Inte=
rrupts from timer4 are still generated, so the system may boot with ipipe o=
ff even with broken free-running timer without any obvious problems, am I r=
ight?<br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8=
ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
But I think your problem has more to do with the following commit, could<br=
>
you try reverting it?<br>
<a href=3D"http://git.xenomai.org/?p=3Dipipe-gch.git;a=3Dcommitdiff;h=3D6ab=
29d9c7a4b119f45ef4d93780e894fe1c0c6c6;hp=3Dcd9c5e016092258d4450e137be2d0844=
d0fe8b38" target=3D"_blank">http://git.xenomai.org/?p=3Dipipe-gch.git;a=3Dc=
ommitdiff;h=3D6ab29d9c7a4b119f45ef4d93780e894fe1c0c6c6;hp=3Dcd9c5e016092258=
d4450e137be2d0844d0fe8b38</a><br>

<br>
The same issue was reported on ixp4xx.<font color=3D"#888888"><br>
</font></blockquote></div><br>I&#39;ll give it a try tomorrow, thanks. A li=
ttle question about this part of the patch:<br>-=A0=A0=A0=A0=A0=A0 if (!__i=
pipe_mach_timerstolen)<br>+=A0=A0=A0=A0=A0=A0 if (!__ipipe_mach_timerstolen=
) {<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spin_lock(&amp;timer_loc=
k);<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 getticksoffset_tscupdate();<b=
r>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 spin_unlock(&amp;timer_lock);=
<br>+=A0=A0=A0=A0=A0=A0 }<br>Is it a bugfix (forgotten spinlock added) or i=
s it due to change of getticksoffset_tscupdate() contents? (Just trying to =
understand how it works.)<br>
<br>--<br>Alex<br>

--90e6ba5bc9c9515d0c04a1ea0e07--

