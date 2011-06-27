MIME-Version: 1.0
In-Reply-To: <BANLkTi=tRb1bZ=ZSkzhvps62xt8PMzNb3A@mail.gmail.com>
References: <BANLkTi=tRb1bZ=ZSkzhvps62xt8PMzNb3A@mail.gmail.com>
Date: Mon, 27 Jun 2011 11:46:47 +0200
Message-ID: <BANLkTik981j5a+85d7mniKG8K9S4zBqsmQ@mail.gmail.com>
From: Willy Lambert <lambert.willy@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba5bbc6d07b88404a6ae6e2f
Subject: Re: [Xenomai-help] Xenomai Unknown
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ashish Budhiraja <ashishmach@domain.hid>
Cc: xenomai@xenomai.org

--90e6ba5bbc6d07b88404a6ae6e2f
Content-Type: text/plain; charset=ISO-8859-1

2011/6/27 Ashish Budhiraja <ashishmach@domain.hid>

> Hello Everyone,
>
> I am Ashish, very new to this group, I don't know anything about Xenomai
> but I want to have increased Real Time
> support for my Roboard-100. So as per the tutorial on this
> http://geonobot-wiki.toile-libre.org/doku.php?id=robotics:computing:xenomai_install_on_roboard
> link I did everything right now when I boot I get this message saying
> udevd: unknown 'Xenomai'  or something similar, and I can only boot to
> text console i.e. if I try to go for my gui my keyboard gets jammed.
>
> I just want to know is there a possible way to check if Xenomai is
> perfectly installed or not though I looked carefully I didn't find any
> errors during the installation
> process but now it is showing 'Xenomai' unknown.
>
> Please guide me how to proceed or tell me something to read.
>
>
I personnally use this :
dmesg | grep -i xenomai

On my installation I have those printed :
Xenomai : hal/x86_64 started.
Xenomai: cheduling class idle registred
Xenomai: scheduling class rt registred
Xenomai: real-time nucleus v2.5.6 (Whormhole Wizards) loaded.
Xenomai: starting native API services
Xenomai: starting POSIX services
Xenomai: starting RTDM services

I think some are not required or depends from your kernel config. The
correct test is on the wiki http://www.xenomai.org but I can't find it
again.



> Thanks All in Advance
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>

--90e6ba5bbc6d07b88404a6ae6e2f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/6/27 Ashish Budhiraja <span dir=3D"=
ltr">&lt;<a href=3D"mailto:ashishmach@domain.hid">ashishmach@domain.hid</a>&g=
t;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex;">
Hello Everyone,<br><br>I am Ashish, very new to this group, I don&#39;t kno=
w anything about Xenomai but I want to have increased Real Time <br>support=
 for my Roboard-100. So as per the tutorial on this <a href=3D"http://geono=
bot-wiki.toile-libre.org/doku.php?id=3Drobotics:computing:xenomai_install_o=
n_roboard" target=3D"_blank">http://geonobot-wiki.toile-libre.org/doku.php?=
id=3Drobotics:computing:xenomai_install_on_roboard</a><br>


link I did everything right now when I boot I get this message saying udevd=
: unknown &#39;Xenomai&#39;=A0 or something similar, and I can only boot to=
 <br>text console i.e. if I try to go for my gui my keyboard gets jammed. <=
br>


<br>I just want to know is there a possible way to check if Xenomai is perf=
ectly installed or not though I looked carefully I didn&#39;t find any erro=
rs during the installation <br>process but now it is showing &#39;Xenomai&#=
39; unknown.<br>


<br>Please guide me how to proceed or tell me something to read.<br><br></b=
lockquote><div><br>I personnally use this :<br>dmesg | grep -i xenomai<br><=
br>On my installation I have those printed :<br>Xenomai : hal/x86_64 starte=
d.<br>
Xenomai: cheduling class idle registred<br>Xenomai: scheduling class rt reg=
istred<br>Xenomai: real-time nucleus v2.5.6 (Whormhole Wizards) loaded.<br>=
Xenomai: starting native API services<br>Xenomai: starting POSIX services<b=
r>
Xenomai: starting RTDM services<br><br>I think some are not required or dep=
ends from your kernel config. The correct test is on the wiki <a href=3D"ht=
tp://www.xenomai.org">http://www.xenomai.org</a> but I can&#39;t find it ag=
ain.<br>
<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt=
 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">Than=
ks All in Advance<br><br>
<br>_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
<br></blockquote></div><br><div style=3D"visibility: hidden; left: -5000px;=
 position: absolute; z-index: 9999; padding: 0px; margin-left: 0px; margin-=
top: 0px; overflow: hidden; word-wrap: break-word; color: black; font-size:=
 10px; text-align: left; line-height: 130%;" id=3D"avg_ls_inline_popup">
</div>

--90e6ba5bbc6d07b88404a6ae6e2f--

