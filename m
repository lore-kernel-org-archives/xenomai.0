MIME-Version: 1.0
Message-ID: <OF53B8EEE0.69903FD4-ONC125781F.002A9283-C125781F.002FEBD2@domain.hid>
Date: Fri, 21 Jan 2011 09:43:22 +0100
From: Pierre.QUELIN@solystic.com
Content-type: multipart/alternative; 
	Boundary="0__=4EBBF28CDFB914138f9e8a93df938690918c4EBBF28CDFB91413"
Content-Disposition: inline
Subject: Re: [Xenomai-help] debug posix skin - pthread_cond_wait return EPERM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org


--0__=4EBBF28CDFB914138f9e8a93df938690918c4EBBF28CDFB91413
Content-Transfer-Encoding: quoted-printable
Content-type: text/plain; charset=ISO-8859-1



> Kolja Waschk wrote:
>>>> file cond-torture-posix
>>> Ok. On my side: I call set solib-absolute-prefix to where the debug
>>> binaries for the target filesystem are. And I call
>>> handle SIG34 nostop noprint pass.
>>>
>>> Coud you try and do the same?
>> Is SIG34 the same on blackfin? I do not remember ever having seen SIG34,
only
>> SIG32 ("Real-time event 32")
>>
>> Independent of that, the result is always the same SEGV. I cannot use
the absolute-prefix currently, as the directory layout is different on the
target. So my script is now
>>
>> set solib-absolute-prefix notexistent
>> set
solib-search-path /opt/uClinux/blackfin-linux-dist/staging/usr/lib:/opt/uCl=
inux/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib

>> file cond-torture-posix
>> handle SIG34 nostop noprint pass
>> target remote 10.0.10.9:2222
>>
>> And regardless whether I add an "break main", the SEGV will occur
immediately after telling gdb to "cont".
>>
>> Does my "try.c" always succeed (all errbits=3D0x0010) in your environmen=
t?
>
> Ok, I get the failure if I set up a breakpoint right after the call to
> pthread=5Fcond=5Fwait, as noted by Pierre. After some debugging, it appea=
rs
> that the syscall is restarted whereas it should return to user-spacce
> and let the user-space skin do its job. So, it seems that somehow, the
> behaviour is different for gdb signals than for usual signals.
>
> Working on it now, will tell you when we have a status.

The following patch seems to fix the issue, but I am not yet sure
whether it is really correct:

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index d27494c..717a8a0 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -770,7 +770,7 @@ static inline void request=5Fsyscall=5Frestart(xnthread=
=5Ft
*thread,
                         if (=5F=5Fxn=5Finterrupted=5Fp(regs)) {
                                     =5F=5Fxn=5Ferror=5Freturn(regs,
                                                               (sysflags &
=5F=5Fxn=5Fexec=5Fnorestart) ?
-
-ERESTARTNOHAND : -ERESTARTSYS);
+                                                              -EINTR :
-ERESTARTSYS);
                                     notify =3D !xnthread=5Ftest=5Fstate(th=
read,
XNDEBUG);
                         }



--
                                                                Gilles.

Sorry but I'm a novice.

As I understand, your patch is a kernel patch and I need to rebuild the
kernel package.
Where can I find the cond-torture-posix application to reproduce the
problem with your test case ?
My PC is a very standard one (Xeon dual core and my distro an Ubuntu 10.10
so I think it's very easy to reproduce the test case.
Do you know if there is a bug tracker where tickets are logged to be
informed when this point will be solved ?

Thank you for you help.

Pierre Qu=E9lin

--0__=4EBBF28CDFB914138f9e8a93df938690918c4EBBF28CDFB91413
Content-Transfer-Encoding: quoted-printable
Content-type: text/html; charset=ISO-8859-1
Content-Disposition: inline

<html><body><p><tt>&gt; Kolja Waschk wrote:<br>&gt;&gt;&gt;&gt; file cond-t=
orture-posix<br>&gt;&gt;&gt; Ok. On my side: I call set solib-absolute-pref=
ix to where the debug<br>&gt;&gt;&gt; binaries for the target filesystem ar=
e. And I call<br>&gt;&gt;&gt; handle SIG34 nostop noprint pass.<br>&gt;&gt;=
&gt;<br>&gt;&gt;&gt; Coud you try and do the same?<br>&gt;&gt; Is SIG34 the=
 same on blackfin? I do not remember ever having seen SIG34, only<br>&gt;&g=
t; SIG32 (&quot;Real-time event 32&quot;)<br>&gt;&gt;<br>&gt;&gt; Independe=
nt of that, the result is always the same SEGV. I cannot use the absolute-p=
refix currently, as the directory layout is different on the target. So my =
script is now<br>&gt;&gt;<br>&gt;&gt; set solib-absolute-prefix notexistent=
<br>&gt;&gt; set solib-search-path /opt/uClinux/blackfin-linux-dist/staging=
/usr/lib:/opt/uClinux/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib<br>&g=
t;&gt; file cond-torture-posix<br>&gt;&gt; handle SIG34 nostop noprint pass=
<br>&gt;&gt; target remote 10.0.10.9:2222<br>&gt;&gt;<br>&gt;&gt; And regar=
dless whether I add an &quot;break main&quot;, the SEGV will occur immediat=
ely after telling gdb to &quot;cont&quot;.<br>&gt;&gt;<br>&gt;&gt; Does my =
&quot;try.c&quot; always succeed (all errbits=3D0x0010) in your environment=
?<br>&gt; <br>&gt; Ok, I get the failure if I set up a breakpoint right aft=
er the call to<br>&gt; pthread=5Fcond=5Fwait, as noted by Pierre. After som=
e debugging, it appears<br>&gt; that the syscall is restarted whereas it sh=
ould return to user-spacce<br>&gt; and let the user-space skin do its job. =
So, it seems that somehow, the<br>&gt; behaviour is different for gdb signa=
ls than for usual signals.<br>&gt; <br>&gt; Working on it now, will tell yo=
u when we have a status.<br><br>The following patch seems to fix the issue,=
 but I am not yet sure <br>whether it is really correct:<br><br>diff --git =
a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c<br>index d27494c..717a8a0 1=
00644<br>--- a/ksrc/nucleus/shadow.c<br>+++ b/ksrc/nucleus/shadow.c<br>@@ -=
770,7 +770,7 @@ static inline void request=5Fsyscall=5Frestart(xnthread=5Ft=
 *thread,<br>                                   if (=5F=5Fxn=5Finterrupted=
=5Fp(regs)) {<br>                                                    =5F=5F=
xn=5Ferror=5Freturn(regs,<br>                                              =
                                        &nbsp; (sysflags &amp; =5F=5Fxn=5Fe=
xec=5Fnorestart) ?<br>-                                                    =
                                 &nbsp; -ERESTARTNOHAND : -ERESTARTSYS);<br=
>+                                                                         =
            &nbsp; -EINTR : -ERESTARTSYS);<br>                             =
                       notify =3D !xnthread=5Ftest=5Fstate(thread, XNDEBUG)=
;<br>                                   }<br> <br><br><br>-- <br> &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Gilles.<br>=
</tt><br><font size=3D"4">Sorry but I'm a novice.</font><br><br><font size=
=3D"4">As I understand, your patch is a kernel patch and I need to rebuild =
the kernel package.</font><br><font size=3D"4">Where can I find the cond-to=
rture-posix application to reproduce the problem with your test case ?</fon=
t><br><font size=3D"4">My PC is a very standard one (Xeon dual core and my =
distro an Ubuntu 10.10 so I think it's very easy to reproduce the test case=
.</font><br><font size=3D"4">Do you know if there is a bug tracker where ti=
ckets are logged to be informed when this point will be solved ?<br></font>=
<br><font size=3D"4">Thank you for you help.<br><br>Pierre Qu=E9lin<br></fo=
nt><BR>
</body></html>

--0__=4EBBF28CDFB914138f9e8a93df938690918c4EBBF28CDFB91413--


