MIME-Version: 1.0
In-Reply-To: <BANLkTik981j5a+85d7mniKG8K9S4zBqsmQ@mail.gmail.com>
References: <BANLkTi=tRb1bZ=ZSkzhvps62xt8PMzNb3A@mail.gmail.com>
	<BANLkTik981j5a+85d7mniKG8K9S4zBqsmQ@mail.gmail.com>
From: Ashish Budhiraja <ashishmach@domain.hid>
Date: Mon, 27 Jun 2011 12:00:14 +0200
Message-ID: <BANLkTinyk1rLpB3LLKV13+-D=9m_DYHvFg@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd1521e90cddc04a6aea0ae
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
To: Willy Lambert <lambert.willy@domain.hid>
Cc: xenomai@xenomai.org

--000e0cd1521e90cddc04a6aea0ae
Content-Type: text/plain; charset=ISO-8859-1

Hello Willy,

Thanks a lot, mine is showing the same I think it is working. Though I will
check on the website which are needed.


Regards,

Ashish

On Mon, Jun 27, 2011 at 11:46 AM, Willy Lambert <lambert.willy@domain.hid>wrote:

>
>
> 2011/6/27 Ashish Budhiraja <ashishmach@domain.hid>
>
>> Hello Everyone,
>>
>> I am Ashish, very new to this group, I don't know anything about Xenomai
>> but I want to have increased Real Time
>> support for my Roboard-100. So as per the tutorial on this
>> http://geonobot-wiki.toile-libre.org/doku.php?id=robotics:computing:xenomai_install_on_roboard
>> link I did everything right now when I boot I get this message saying
>> udevd: unknown 'Xenomai'  or something similar, and I can only boot to
>> text console i.e. if I try to go for my gui my keyboard gets jammed.
>>
>> I just want to know is there a possible way to check if Xenomai is
>> perfectly installed or not though I looked carefully I didn't find any
>> errors during the installation
>> process but now it is showing 'Xenomai' unknown.
>>
>> Please guide me how to proceed or tell me something to read.
>>
>>
> I personnally use this :
> dmesg | grep -i xenomai
>
> On my installation I have those printed :
> Xenomai : hal/x86_64 started.
> Xenomai: cheduling class idle registred
> Xenomai: scheduling class rt registred
> Xenomai: real-time nucleus v2.5.6 (Whormhole Wizards) loaded.
> Xenomai: starting native API services
> Xenomai: starting POSIX services
> Xenomai: starting RTDM services
>
> I think some are not required or depends from your kernel config. The
> correct test is on the wiki http://www.xenomai.org but I can't find it
> again.
>
>
>
>> Thanks All in Advance
>>
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>
>>
>

--000e0cd1521e90cddc04a6aea0ae
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Willy,<br><br>Thanks a lot, mine is showing the same I think it is wo=
rking. Though I will check on the website which are needed.<br><br><br>Rega=
rds,<br><br>Ashish<br><br><div class=3D"gmail_quote">On Mon, Jun 27, 2011 a=
t 11:46 AM, Willy Lambert <span dir=3D"ltr">&lt;<a href=3D"mailto:lambert.w=
illy@domain.hid">lambert.willy@domain.hid</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><br><br><div clas=
s=3D"gmail_quote"><div><div></div><div class=3D"h5">2011/6/27 Ashish Budhir=
aja <span dir=3D"ltr">&lt;<a href=3D"mailto:ashishmach@domain.hid" target=3D=
"_blank">ashishmach@domain.hid</a>&gt;</span><br>

<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
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
lockquote></div></div><div><br>I personnally use this :<br>dmesg | grep -i =
xenomai<br><br>On my installation I have those printed :<br>Xenomai : hal/x=
86_64 started.<br>


Xenomai: cheduling class idle registred<br>Xenomai: scheduling class rt reg=
istred<br>Xenomai: real-time nucleus v2.5.6 (Whormhole Wizards) loaded.<br>=
Xenomai: starting native API services<br>Xenomai: starting POSIX services<b=
r>


Xenomai: starting RTDM services<br><br>I think some are not required or dep=
ends from your kernel config. The correct test is on the wiki <a href=3D"ht=
tp://www.xenomai.org" target=3D"_blank">http://www.xenomai.org</a> but I ca=
n&#39;t find it again.<br>


<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt=
 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">Than=
ks All in Advance<br><br>
<br>_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid" target=3D"_blank">Xenomai-help@domain.hid.=
org</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
<br></blockquote></div><br><div style=3D"padding: 0px; margin-left: 0px; ma=
rgin-top: 0px; overflow: hidden; word-wrap: break-word; color: black; font-=
size: 10px; text-align: left; line-height: 130%;">
</div>
</blockquote></div><br>

--000e0cd1521e90cddc04a6aea0ae--

