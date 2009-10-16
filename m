MIME-Version: 1.0
In-Reply-To: <1f3e02580910160156t4635216if9ac722304750d65@domain.hid>
References: <1f3e02580910132319v3ce08b2frb811d749def9f17@domain.hid>
	<4AD57CE3.4050206@domain.hid>
	<1f3e02580910152226h4fb94068kfce63fec4be38c3f@domain.hid>
	<4AD8241C.6090200@domain.hid>
	<1f3e02580910160130m69f35a2bl5ca2b40cabadbb56@domain.hid>
	<4AD832CB.20004@domain.hid>
	<1f3e02580910160156t4635216if9ac722304750d65@domain.hid>
Date: Fri, 16 Oct 2009 18:30:12 +0900
Message-ID: <1f3e02580910160230t20b1c77bu31103e55d6867064@domain.hid>
From: Didenko Sergey <didenkos@domain.hid>
Content-Type: multipart/alternative; boundary=00504502bfe9f5576404760a0a7f
Subject: Re: [Xenomai-help] Support for ARCH_MV88F6290
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
Cc: xenomai@xenomai.org, mohamad.sharifi@domain.hid

--00504502bfe9f5576404760a0a7f
Content-Type: text/plain; charset=UTF-8

Do you have any guide how to run all tests?And what kind of results of each
test should I expect?

2009/10/16 Didenko Sergey <didenkos@domain.hid>

> Thank a lot Gilles, it is working!
>
> 2009/10/16 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>
>> Didenko Sergey wrote:
>>
>> > Thank you very much Gilles, now I have this done with no
>> Warnings...good.
>> >
>> > Two things are remained:
>> >
>> > 1) warning message like "remember to run `libtool --finish
>> > /usr/xenomai/lib'" which are printed out when I do command
>> > make DESTDIR=/nfs/rootfs install
>> >
>> > How should I run it for the board's rootfs (located on /nfs/rootfs) ?
>> > Is this "libtool --finish /nfs/rootfs/usr/xenomai/lib" correct?
>> > Should I add this path to my board's environment variable?
>>
>> You can safely ignore these messages.
>>
>> >
>> > 2) I really need your help how to compile and run test-suit on my board.
>>
>> If for instance you want to run latency on your board, then boot your
>> board, log on your board, then type:
>>
>> cd /usr/xenomai/share/testsuite/latency
>> ./run -- -p 1000
>>
>> --
>>                                           Gilles
>>
>>
>

--00504502bfe9f5576404760a0a7f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Do you have any guide how to run all tests?<div>And what kind of results of=
 each test should I expect?<br><br><div class=3D"gmail_quote">2009/10/16 Di=
denko Sergey <span dir=3D"ltr">&lt;<a href=3D"mailto:didenkos@domain.hid">di=
denkos@domain.hid</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">Thank a lot Gilles, it is working!<div><br>=
<div><div><br><div class=3D"gmail_quote"><div class=3D"im">2009/10/16 Gille=
s Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdri=
x@domain.hid" target=3D"_blank">gilles.chanteperdrix@xenomai.org</a>&gt;</=
span><br>

</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><div>Didenko Sergey wrote:<div><div></=
div><div class=3D"h5"><br>
&gt; Thank you very much Gilles, now I have this done with no Warnings...go=
od.<br>
&gt;<br>
&gt; Two things are remained:<br>
&gt;<br>
&gt; 1) warning message like &quot;remember to run `libtool --finish<br>
&gt; /usr/xenomai/lib&#39;&quot; which are printed out when I do command<br=
>
&gt; make DESTDIR=3D/nfs/rootfs install<br>
&gt;<br>
&gt; How should I run it for the board&#39;s rootfs (located on /nfs/rootfs=
) ?<br>
&gt; Is this &quot;libtool --finish /nfs/rootfs/usr/xenomai/lib&quot; corre=
ct?<br>
&gt; Should I add this path to my board&#39;s environment variable?<br>
<br>
</div></div></div><div><div></div><div class=3D"h5">You can safely ignore t=
hese messages.<br>
<div><br>
&gt;<br>
&gt; 2) I really need your help how to compile and run test-suit on my boar=
d.<br>
<br>
</div>If for instance you want to run latency on your board, then boot your=
<br>
board, log on your board, then type:<br>
<br>
cd /usr/xenomai/share/testsuite/latency<br>
./run -- -p 1000<br>
<br>
--<br>
<font color=3D"#888888"> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Gilles<br>
<br>
</font></div></div></blockquote></div><br></div></div></div>
</blockquote></div><br></div>

--00504502bfe9f5576404760a0a7f--

