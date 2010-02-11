MIME-Version: 1.0
In-Reply-To: <8b216e9e1002101128t1246a5deh28ca13229f1d688d@domain.hid>
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid> 
	<4B729B04.9010909@domain.hid>
	<8b216e9e1002100349y71f40d9ct9cbf496846f33f2e@domain.hid> 
	<8b216e9e1002100358u71d73d36xb851e59e23e069d1@domain.hid> 
	<4B72C18F.20903@domain.hid>
	<8b216e9e1002101128t1246a5deh28ca13229f1d688d@domain.hid>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Date: Thu, 11 Feb 2010 16:05:30 -0200
Message-ID: <8b216e9e1002111005h6b432bcby17d4127d3b9d385a@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd1446844c1eb047f5700d2
Subject: Re: [Xenomai-help] Problems when cross-compiling Xenomai
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

--000e0cd1446844c1eb047f5700d2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2010/2/10 Felipe Brand=E3o Cavalcanti <cavalkaf@domain.hid>

>
>
> 2010/2/10 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>
>> Felipe Brand=E3o Cavalcanti wrote:
>> > 2010/2/10 Felipe Brand=E3o Cavalcanti <cavalkaf@domain.hid>
>> >
>> >>
>> >> 2010/2/10 Gilles Chanteperdrix <
>> gilles.chanteperdrix@xenomai.org>
>> >>
>> >> Felipe Brand=E3o Cavalcanti wrote:
>> >>>> Hello,
>> >>>>
>> >>>> I am having some problems when trying to cross-compile the userspac=
e
>> >>> portion
>> >>>> of the latest Xenomai (2.5.1) for ARM. I am attempting to get Xenom=
ai
>> >>>> running on a IGEPv2 OMAP board (Beagleboard based), so I am
>> >>> cross-compiling
>> >>>> with bitbake on top of a poky Linux distribution.
>> >>> Do you have the same problem if you build Xenomai user-space portion
>> >>> running the standard build procedure without additional CFLAGS and
>> >>> LDFLAGS?
>> >>>
>> >>>
>> >> I have not tried this - the cross compiler automatically adds them, a=
nd
>> I
>> >> am not sure what I can remove. However, I will try removing them to s=
ee
>> what
>> >> works. One thing that I noticed using the -k option in the make comma=
nd
>> is
>> >> that compiling fails only in the testsuite.
>> >>
>> >> I found an old thread with a similar problem:
>> >> https://mail.gna.org/public/xenomai-help/2008-07/msg00141.html
>> >>
>> >>
>> >
>> > Just tried removing the LDFLAGS and CFLAGS, same error. I've attached
>> the
>> > configure and make logs.
>>
>> Ok. Made a diff between your configure log and mine. It seems the
>> problem is at some point configure does not find a compiler named
>> "arm-linux-gcc" and decides to use "gcc". So, your host compiler is
>> probably used to test whether shm_open/shm_unlink and a few other
>> functions exist for your target, and finds them whereas they are
>> probably not available.
>>
>> So, the cure is to pass --host=3Darm-none-linux-gnueabi instead of
>> --host=3Darm-linux.
>>
>> This looks a bit like a bug. Did you (or bit-bake, or poky, whatever)
>> re-run autoconf or are you using the original configure script?
>>
>>
> I am running the standard configure script, but I am not sure if bitbake
> runs autoconf again - probably not.
>
> However, I did get it to compile - I just havent had the chance the test =
it
> yet. In the end, I removed the -Wl,--as-needed, as well as a couple of ot=
her
> flags.
>
> I am attaching the logs of the latest compilation, in case you want to ta=
ke
> a look. I will send in the final results as soon as I get a chance to tes=
t
> it.
>
> Gilles, thanks very much for the help!
>    -Felipe Brandao Cavalcanti
>
>
OK, so I did test it - the programs seem to run, but Xenomai doesn't seem t=
o
be working.

When I run the latency test, I get the following output:

=3D=3D Sampling period: 1000 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds
warming up...
latency: failed to set periodic, code -110

Anyone has a clue on what's going on? I am tweaking the kernel options
hoping to make it work.

Thanks for the help,
      -Felipe Brand=E3o Cavalcanti

 --
>> Gilles Chanteperdrix, Free Electrons
>> Kernel, drivers, real-time and embedded Linux
>> development, consulting, training and support.
>> http://free-electrons.com
>>
>>
>
>
> --
>       -Felipe Brand=E3o Cavalcanti
>       LARA - Robotics and Automation Laboratory
>       Department of Electrical Engineering
>       UnB - University of Bras=EDlia, Brazil
>       http://www.lara.unb.br/~fbcavalcanti/<http://www.lara.unb.br/%7Efbc=
avalcanti/>
>



--=20
      -Felipe Brand=E3o Cavalcanti
      LARA - Robotics and Automation Laboratory
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/~fbcavalcanti/

--000e0cd1446844c1eb047f5700d2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/2/10 Felipe Brand=E3o Cavalcanti <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:cavalkaf@domain.hid">cavalkaf@domain.hid=
m</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"border-left:=
 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex=
;">

<br><br><div class=3D"gmail_quote"><div><div></div><div class=3D"h5">2010/2=
/10 Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.cha=
nteperdrix@domain.hid" target=3D"_blank">gilles.chanteperdrix@xenomai.org=
electrons.com</a>&gt;</span><br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div>Felipe Brand=E3o Cavalcanti wrote:<br>
&gt; 2010/2/10 Felipe Brand=E3o Cavalcanti &lt;<a href=3D"mailto:cavalkaf@domain.hid=
mail.com" target=3D"_blank">cavalkaf@domain.hid</a>&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; 2010/2/10 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chante=
perdrix@domain.hid" target=3D"_blank">gilles.chanteperdrix@xenomai.org=
ctrons.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Felipe Brand=E3o Cavalcanti wrote:<br>
&gt;&gt;&gt;&gt; Hello,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I am having some problems when trying to cross-compile the=
 userspace<br>
&gt;&gt;&gt; portion<br>
&gt;&gt;&gt;&gt; of the latest Xenomai (2.5.1) for ARM. I am attempting to =
get Xenomai<br>
&gt;&gt;&gt;&gt; running on a IGEPv2 OMAP board (Beagleboard based), so I a=
m<br>
&gt;&gt;&gt; cross-compiling<br>
&gt;&gt;&gt;&gt; with bitbake on top of a poky Linux distribution.<br>
&gt;&gt;&gt; Do you have the same problem if you build Xenomai user-space p=
ortion<br>
&gt;&gt;&gt; running the standard build procedure without additional CFLAGS=
 and<br>
&gt;&gt;&gt; LDFLAGS?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt; I have not tried this - the cross compiler automatically adds them=
, and I<br>
&gt;&gt; am not sure what I can remove. However, I will try removing them t=
o see what<br>
&gt;&gt; works. One thing that I noticed using the -k option in the make co=
mmand is<br>
&gt;&gt; that compiling fails only in the testsuite.<br>
&gt;&gt;<br>
&gt;&gt; I found an old thread with a similar problem:<br>
&gt;&gt; <a href=3D"https://mail.gna.org/public/xenomai-help/2008-07/msg001=
41.html" target=3D"_blank">https://mail.gna.org/public/xenomai-help/2008-07=
/msg00141.html</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt; Just tried removing the LDFLAGS and CFLAGS, same error. I&#39;ve attac=
hed the<br>
&gt; configure and make logs.<br>
<br>
</div>Ok. Made a diff between your configure log and mine. It seems the<br>
problem is at some point configure does not find a compiler named<br>
&quot;arm-linux-gcc&quot; and decides to use &quot;gcc&quot;. So, your host=
 compiler is<br>
probably used to test whether shm_open/shm_unlink and a few other<br>
functions exist for your target, and finds them whereas they are<br>
probably not available.<br>
<br>
So, the cure is to pass --host=3Darm-none-linux-gnueabi instead of<br>
--host=3Darm-linux.<br>
<br>
This looks a bit like a bug. Did you (or bit-bake, or poky, whatever)<br>
re-run autoconf or are you using the original configure script?<br>
<font color=3D"#888888"><br></font></blockquote></div></div><div><br>I am r=
unning the standard configure script, but I am not sure if bitbake runs aut=
oconf again - probably not.<br><br>However, I did get it to compile - I jus=
t havent had the chance the test it yet. In the end, I removed the -Wl,--as=
-needed, as well as a couple of other flags.<br>


<br>I am attaching the logs of the latest compilation, in case you want to =
take a look. I will send in the final results as soon as I get a chance to =
test it.<br>=A0<br>Gilles, thanks very much for the help!<br>=A0=A0 -Felipe=
 Brandao Cavalcanti<br>


<br></div></div></blockquote><div><br>OK, so I did test it - the programs s=
eem to run, but Xenomai doesn&#39;t seem to be working.<br><br>When I run t=
he latency test, I get the following output:<br><br>=3D=3D Sampling period:=
 1000 us<br>

=3D=3D Test mode: periodic user-mode task<br>=3D=3D All results in microsec=
onds<br>warming up...<br>latency: failed to set periodic, code -110<br><br>=
Anyone has a clue on what&#39;s going on? I am tweaking the kernel options =
hoping to make it work.<br>

<br>Thanks for the help,<br>=A0 =A0 =A0 -Felipe Brand=E3o Cavalcanti <br><b=
r></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid r=
gb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div clas=
s=3D"gmail_quote">

<div></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px soli=
d rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><font =
color=3D"#888888">
--<br>
</font><div class=3D"im"><div><div></div><div>Gilles Chanteperdrix, Free El=
ectrons<br>
Kernel, drivers, real-time and embedded Linux<br>
development, consulting, training and support.<br>
<a href=3D"http://free-electrons.com" target=3D"_blank">http://free-electro=
ns.com</a><br>
<br>
</div></div></div></blockquote></div><br><br clear=3D"all"><div><div></div>=
<div class=3D"h5"><br>-- <br> =A0 =A0 =A0 -Felipe Brand=E3o Cavalcanti<br> =
=A0 =A0 =A0 LARA - Robotics and Automation Laboratory<br> =A0 =A0 =A0 Depar=
tment of Electrical Engineering<br>

 =A0 =A0 =A0 UnB - University of Bras=EDlia, Brazil<br>
 =A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/%7Efbcavalcanti/" target=3D"=
_blank">http://www.lara.unb.br/~fbcavalcanti/</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br> =A0 =A0 =
=A0 -Felipe Brand=E3o Cavalcanti<br> =A0 =A0 =A0 LARA - Robotics and Automa=
tion Laboratory<br> =A0 =A0 =A0 Department of Electrical Engineering<br> =
=A0 =A0 =A0 UnB - University of Bras=EDlia, Brazil<br>

 =A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/~fbcavalcanti/">http://www.l=
ara.unb.br/~fbcavalcanti/</a><br>

--000e0cd1446844c1eb047f5700d2--

