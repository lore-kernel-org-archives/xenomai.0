MIME-Version: 1.0
Message-ID: <OF93679C8E.0A3964BD-ONC1257822.002C1829-C1257822.0052304C@LocalDomain>
Date: Mon, 24 Jan 2011 15:57:41 +0100
From: Pierre.QUELIN@solystic.com
Content-type: multipart/alternative; 
	Boundary="0__=4EBBF2B1DFBF9EB98f9e8a93df938690918c4EBBF2B1DFBF9EB9"
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


--0__=4EBBF2B1DFBF9EB98f9e8a93df938690918c4EBBF2B1DFBF9EB9
Content-Transfer-Encoding: quoted-printable
Content-type: text/plain; charset=US-ASCII



>Gilles Chanteperdrix wrote:
>
>Pierre.QUELIN@solystic.com wrote:
>>
>>> Kolja Waschk wrote:
>>>>>> file cond-torture-posix
>>>>> Ok. On my side: I call set solib-absolute-prefix to where the debug
>>>>> binaries for the target filesystem are. And I call
>>>>> handle SIG34 nostop noprint pass.
>>>>>
>>>>> Coud you try and do the same?
>>>> Is SIG34 the same on blackfin? I do not remember ever having seen
SIG34,
>> only
>>>> SIG32 ("Real-time event 32")
>>>>
>>>> Independent of that, the result is always the same SEGV. I cannot use
>> the absolute-prefix currently, as the directory layout is different on
the
>> target. So my script is now
>>>> set solib-absolute-prefix notexistent
>>>> set
>>
solib-search-path /opt/uClinux/blackfin-linux-dist/staging/usr/lib:/opt/uCl=
inux/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib
>>
>>>> file cond-torture-posix
>>>> handle SIG34 nostop noprint pass
>>>> target remote 10.0.10.9:2222
>>>>
>>>> And regardless whether I add an "break main", the SEGV will occur
>> immediately after telling gdb to "cont".
>>>> Does my "try.c" always succeed (all errbits=3D0x0010) in your
environment?
>>> Ok, I get the failure if I set up a breakpoint right after the call to
>>> pthread=5Fcond=5Fwait, as noted by Pierre. After some debugging, it app=
ears
>>> that the syscall is restarted whereas it should return to user-spacce
>>> and let the user-space skin do its job. So, it seems that somehow, the
>>> behaviour is different for gdb signals than for usual signals.
>>>
>>> Working on it now, will tell you when we have a status.
>>
>> The following patch seems to fix the issue, but I am not yet sure
>> whether it is really correct:
>>
>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
>> index d27494c..717a8a0 100644
>> --- a/ksrc/nucleus/shadow.c
>> +++ b/ksrc/nucleus/shadow.c
>> @@ -770,7 +770,7 @@ static inline void request=5Fsyscall=5Frestart
(xnthread=5Ft
>> *thread,
>>                          if (=5F=5Fxn=5Finterrupted=5Fp(regs)) {
>>                                      =5F=5Fxn=5Ferror=5Freturn(regs,
>>                                                                (sysflags
&
>> =5F=5Fxn=5Fexec=5Fnorestart) ?
>> -
>> -ERESTARTNOHAND : -ERESTARTSYS);
>> +                                                              -EINTR :
>> -ERESTARTSYS);
>>                                      notify =3D !xnthread=5Ftest=5Fstate
(thread,
>> XNDEBUG);
>>                          }
>>
>>
>>
>> --
>>                                                                 Gilles.
>>
>> Sorry but I'm a novice.
>>
>> As I understand, your patch is a kernel patch and I need to rebuild the
>> kernel package.
>
>Yes.
>
>> Where can I find the cond-torture-posix application to reproduce the
>> problem with your test case ?
>
>It is part of Xenomai installation.
>
>> My PC is a very standard one (Xeon dual core and my distro an Ubuntu
10.10
>> so I think it's very easy to reproduce the test case.
>> Do you know if there is a bug tracker where tickets are logged to be
>> informed when this point will be solved ?
>
>No. We use the mailing list for this. From our point of view, however,
>the point is solved.

I have not done a lot of tests but it seems to work fine for me in my basic
test case.

Result :
      Thread [3] 2905 (Suspended : Container)
            =5F=5Fkernel=5Fvsyscall() at 0xb7fe1424
            =5F=5Fwrap=5Fpthread=5Fcond=5Fwait() at 0xb7fc4815
            =5F=5Fwrap=5Fpthread=5Fcond=5Fwait() at 0xb7fc479e
            bodyB() at /home/generation/Projets/PosixTest/src/Main.cpp:55
0x8048c11
            0xb7fc30b2
            start=5Fthread() at pthread=5Fcreate.c:304 0xb7fa4cc9
            clone() at ../sysdeps/unix/sysv/linux/i386/clone.S:130
0xb7df869e
      Thread [2] 2904 (Suspended : Container)
            =5F=5Fkernel=5Fvsyscall() at 0xb7fe1424
            =5F=5Fwrap=5Fpthread=5Fcond=5Fwait() at 0xb7fc4815
            =5F=5Fwrap=5Fpthread=5Fcond=5Fwait() at 0xb7fc479e
            bodyA() at /home/generation/Projets/PosixTest/src/Main.cpp:21
0x8048b21
            0xb7fc30b2
            start=5Fthread() at pthread=5Fcreate.c:304 0xb7fa4cc9
            clone() at ../sysdeps/unix/sysv/linux/i386/clone.S:130
0xb7df869e
      Thread [1] 2900 (Suspended : Signal : SIGINT:Interrupt)
            =5F=5Fkernel=5Fvsyscall() at 0xb7fe1424
            =5F=5Fwrap=5Fpthread=5Fcond=5Fwait() at 0xb7fc4815
            =5F=5Fwrap=5Fpthread=5Fcond=5Fwait() at 0xb7fc479e
            main() at /home/generation/Projets/PosixTest/src/Main.cpp:131
0x8048f42


I don't know if this is the same problem but when I launch the real
application, I have some other troubles link with the debug mode.
I investigate about that and I'll inform you later.

Thank you very much.

>
>Also note that I did not replied to you personally, only to the list,
>because otherwise I receive spam from you.
>

I'm sorry about this.

>--
>                                                                Gilles.

--0__=4EBBF2B1DFBF9EB98f9e8a93df938690918c4EBBF2B1DFBF9EB9
Content-Transfer-Encoding: quoted-printable
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body><p><tt>&gt;Gilles Chanteperdrix wrote:</tt><br><tt>&gt;</tt><br=
><tt>&gt;Pierre.QUELIN@solystic.com wrote:</tt><br><tt>&gt;&gt; </tt><br><t=
t>&gt;&gt;&gt; Kolja Waschk wrote:</tt><br><tt>&gt;&gt;&gt;&gt;&gt;&gt; fil=
e cond-torture-posix</tt><br><tt>&gt;&gt;&gt;&gt;&gt; Ok. On my side: I cal=
l set solib-absolute-prefix to where the debug</tt><br><tt>&gt;&gt;&gt;&gt;=
&gt; binaries for the target filesystem are. And I call</tt><br><tt>&gt;&gt=
;&gt;&gt;&gt; handle SIG34 nostop noprint pass.</tt><br><tt>&gt;&gt;&gt;&gt=
;&gt;</tt><br><tt>&gt;&gt;&gt;&gt;&gt; Coud you try and do the same?</tt><b=
r><tt>&gt;&gt;&gt;&gt; Is SIG34 the same on blackfin? I do not remember eve=
r having seen SIG34,</tt><br><tt>&gt;&gt; only</tt><br><tt>&gt;&gt;&gt;&gt;=
 SIG32 (&quot;Real-time event 32&quot;)</tt><br><tt>&gt;&gt;&gt;&gt;</tt><b=
r><tt>&gt;&gt;&gt;&gt; Independent of that, the result is always the same S=
EGV. I cannot use</tt><br><tt>&gt;&gt; the absolute-prefix currently, as th=
e directory layout is different on the</tt><br><tt>&gt;&gt; target. So my s=
cript is now</tt><br><tt>&gt;&gt;&gt;&gt; set solib-absolute-prefix notexis=
tent</tt><br><tt>&gt;&gt;&gt;&gt; set</tt><br><tt>&gt;&gt; solib-search-pat=
h /opt/uClinux/blackfin-linux-dist/staging/usr/lib:/opt/uClinux/bfin-linux-=
uclibc/bfin-linux-uclibc/runtime/lib</tt><br><tt>&gt;&gt; </tt><br><tt>&gt;=
&gt;&gt;&gt; file cond-torture-posix</tt><br><tt>&gt;&gt;&gt;&gt; handle SI=
G34 nostop noprint pass</tt><br><tt>&gt;&gt;&gt;&gt; target remote 10.0.10.=
9:2222</tt><br><tt>&gt;&gt;&gt;&gt;</tt><br><tt>&gt;&gt;&gt;&gt; And regard=
less whether I add an &quot;break main&quot;, the SEGV will occur</tt><br><=
tt>&gt;&gt; immediately after telling gdb to &quot;cont&quot;.</tt><br><tt>=
&gt;&gt;&gt;&gt; Does my &quot;try.c&quot; always succeed (all errbits=3D0x=
0010) in your environment?</tt><br><tt>&gt;&gt;&gt; Ok, I get the failure i=
f I set up a breakpoint right after the call to</tt><br><tt>&gt;&gt;&gt; pt=
hread=5Fcond=5Fwait, as noted by Pierre. After some debugging, it appears</=
tt><br><tt>&gt;&gt;&gt; that the syscall is restarted whereas it should ret=
urn to user-spacce</tt><br><tt>&gt;&gt;&gt; and let the user-space skin do =
its job. So, it seems that somehow, the</tt><br><tt>&gt;&gt;&gt; behaviour =
is different for gdb signals than for usual signals.</tt><br><tt>&gt;&gt;&g=
t;</tt><br><tt>&gt;&gt;&gt; Working on it now, will tell you when we have a=
 status.</tt><br><tt>&gt;&gt; </tt><br><tt>&gt;&gt; The following patch see=
ms to fix the issue, but I am not yet sure</tt><br><tt>&gt;&gt; whether it =
is really correct:</tt><br><tt>&gt;&gt; </tt><br><tt>&gt;&gt; diff --git a/=
ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c</tt><br><tt>&gt;&gt; index d2=
7494c..717a8a0 100644</tt><br><tt>&gt;&gt; --- a/ksrc/nucleus/shadow.c</tt>=
<br><tt>&gt;&gt; +++ b/ksrc/nucleus/shadow.c</tt><br><tt>&gt;&gt; @@ -770,7=
 +770,7 @@ static inline void request=5Fsyscall=5Frestart(xnthread=5Ft</tt>=
<br><tt>&gt;&gt; *thread,</tt><br><tt>&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (=5F=5Fxn=
=5Finterrupted=5Fp(regs)) {</tt><br><tt>&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp;=5F=5Fxn=5Ferror=5Freturn(regs,</tt><br><tt>=
&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp;(sysflags &amp;</tt><br><tt>&gt;&gt; =5F=5Fxn=5Fexec=5Fnorestart) ?<=
/tt><br><tt>&gt;&gt; -</tt><br><tt>&gt;&gt; -ERESTARTNOHAND : -ERESTARTSYS)=
;</tt><br><tt>&gt;&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp;-EINTR :</tt><br><tt>&gt;&gt; -ERESTARTSYS);</tt><br><tt>&g=
t;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;notify =3D =
!xnthread=5Ftest=5Fstate(thread,</tt><br><tt>&gt;&gt; XNDEBUG);</tt><br><tt=
>&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp;}</tt><br><tt>&gt;&gt; </tt><br><tt>&gt;&gt; </tt>=
<br><tt>&gt;&gt; </tt><br><tt>&gt;&gt; --</tt><br><tt>&gt;&gt; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Gilles.</tt><=
br><tt>&gt;&gt; </tt><br><tt>&gt;&gt; Sorry but I'm a novice.</tt><br><tt>&=
gt;&gt; </tt><br><tt>&gt;&gt; As I understand, your patch is a kernel patch=
 and I need to rebuild the</tt><br><tt>&gt;&gt; kernel package.</tt><br><tt=
>&gt;</tt><br><tt>&gt;Yes.</tt><br><tt>&gt;</tt><br><tt>&gt;&gt; Where can =
I find the cond-torture-posix application to reproduce the</tt><br><tt>&gt;=
&gt; problem with your test case ?</tt><br><tt>&gt;</tt><br><tt>&gt;It is p=
art of Xenomai installation.</tt><br><tt>&gt;</tt><br><tt>&gt;&gt; My PC is=
 a very standard one (Xeon dual core and my distro an Ubuntu 10.10</tt><br>=
<tt>&gt;&gt; so I think it's very easy to reproduce the test case.</tt><br>=
<tt>&gt;&gt; Do you know if there is a bug tracker where tickets are logged=
 to be</tt><br><tt>&gt;&gt; informed when this point will be solved ?</tt><=
br><tt>&gt;</tt><br><tt>&gt;No. We use the mailing list for this. From our =
point of view, however,</tt><br><tt>&gt;the point is solved.</tt><br><br><t=
t>I have not done a lot of tests but it seems to work fine for me in my bas=
ic test case.</tt><br><br><tt>Result :</tt><br><tt>        Thread [3] 2905 =
(Suspended : Container)        </tt><br><tt>                =5F=5Fkernel=5F=
vsyscall() at 0xb7fe1424        </tt><br><tt>                =5F=5Fwrap=5Fp=
thread=5Fcond=5Fwait() at 0xb7fc4815        </tt><br><tt>                =
=5F=5Fwrap=5Fpthread=5Fcond=5Fwait() at 0xb7fc479e        </tt><br><tt>    =
            bodyB() at /home/generation/Projets/PosixTest/src/Main.cpp:55 0=
x8048c11        </tt><br><tt>                0xb7fc30b2        </tt><br><tt=
>                start=5Fthread() at pthread=5Fcreate.c:304 0xb7fa4cc9     =
   </tt><br><tt>                clone() at ../sysdeps/unix/sysv/linux/i386/=
clone.S:130 0xb7df869e        </tt><br><tt>        Thread [2] 2904 (Suspend=
ed : Container)        </tt><br><tt>                =5F=5Fkernel=5Fvsyscall=
() at 0xb7fe1424        </tt><br><tt>                =5F=5Fwrap=5Fpthread=
=5Fcond=5Fwait() at 0xb7fc4815        </tt><br><tt>                =5F=5Fwr=
ap=5Fpthread=5Fcond=5Fwait() at 0xb7fc479e        </tt><br><tt>            =
    bodyA() at /home/generation/Projets/PosixTest/src/Main.cpp:21 0x8048b21=
        </tt><br><tt>                0xb7fc30b2        </tt><br><tt>       =
         start=5Fthread() at pthread=5Fcreate.c:304 0xb7fa4cc9        </tt>=
<br><tt>                clone() at ../sysdeps/unix/sysv/linux/i386/clone.S:=
130 0xb7df869e        </tt><br><tt>        Thread [1] 2900 (Suspended : Sig=
nal : SIGINT:Interrupt)        </tt><br><tt>                =5F=5Fkernel=5F=
vsyscall() at 0xb7fe1424        </tt><br><tt>                =5F=5Fwrap=5Fp=
thread=5Fcond=5Fwait() at 0xb7fc4815        </tt><br><tt>                =
=5F=5Fwrap=5Fpthread=5Fcond=5Fwait() at 0xb7fc479e        </tt><br><tt>    =
            main() at /home/generation/Projets/PosixTest/src/Main.cpp:131 0=
x8048f42        </tt><br><br><br><tt>I don't know if this is the same probl=
em but when I launch the real application, I have some other troubles link =
with the debug mode.</tt><br><tt>I investigate about that and I'll inform y=
ou later.</tt><br><br><tt>Thank you very much.</tt><br><br><tt>&gt;</tt><br=
><tt>&gt;Also note that I did not replied to you personally, only to the li=
st,</tt><br><tt>&gt;because otherwise I receive spam from you.</tt><br><tt>=
&gt;</tt><br><br><tt>I'm sorry about this.</tt><br><br><tt>&gt;-- </tt><br>=
<tt>&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp;Gilles.</tt><BR>
</body></html>

--0__=4EBBF2B1DFBF9EB98f9e8a93df938690918c4EBBF2B1DFBF9EB9--


