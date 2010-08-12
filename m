Date: 12 Aug 2010 16:00:06 -0000
MIME-Version: 1.0
Message-ID: <1281614789.S.4127.12121.H.TkVyaWMgTm91bGFyZABSZTogW1hlbm9tYWktaGVscF0gVGltaW5nIGNhbGN1bGF0aW9u.f4-234-118.old.1281628806.35988@domain.hid>
in-reply-to: <AANLkTik6rvKbm3JPQMpWQYzoqYA6RmwgLp7zFSDt5ECB@mail.gmail.com>
From: "prakash srinivasan" <asprakash_83@domain.hid>
Content-Type: multipart/alternative;
	boundary="=_c4e013f9bb80744c2bcb711881eaeb5a"
Subject: Re: [Xenomai-help] =?utf-8?q?Timing_calculation?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: eric.noulard@domain.hid
Cc: xenomai@xenomai.org

--=_c4e013f9bb80744c2bcb711881eaeb5a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"



>I was trying to check the exact type of RTIME (return type of rt_timer_read()) and SRTIME (expectted argument type and return type of rt_timer_ticks2ns) and RTIME unsigned long long

>

>

>so theoretically you would need the "%lld" (long long) format for



rt_timer_ticks2ns returned value.



>whereas you would need "%llu" for rt_timer_read() value.



>If you try to print unsigned value with a signed format you'll get



signed "print out" interpretation of the unsigned value, as you said:



"Early I gave (long)(start). The output was negative."

>

>

>

>May be it would be worth having some RTIME_FORMAT and STRIME_FORMAT macros in order to avoid that?



Now I modified (unsigned)(long)(long) as return format for start and end. The output is,

Starting Time : 4295048924899

End time : 4297258900362

(long)(long)rt_timer_ticks2ns(end-start)= -1790994340162556031 





-Prakash
--=_c4e013f9bb80744c2bcb711881eaeb5a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="UTF-8"

<br />
>I was trying to check the exact type of RTIME (return type of rt_timer_rea=
d()) and SRTIME (expectted argument type and return type of rt_timer_ticks2=
ns) and RTIME unsigned long long<br />
><br />
><br />
>so theoretically you would need the "%lld" (long long) format for<br />
<br />
rt_timer_ticks2ns returned value.<br />
<br />
>whereas you would need "%llu" for rt_timer_read() value.<br />
<br />
>If you try to print unsigned value with a signed format you'll get<br />
<br />
signed "print out" interpretation of the unsigned value, as you said:<br />
<br />
"Early I gave (long)(start). The output was negative."<br />
><br />
><br />
><br />
>May be it would be worth having some RTIME_FORMAT and STRIME_FORMAT macros=
 in order to avoid that?<br />
<br />
Now I modified (unsigned)(long)(long) as return format for start and end. T=
he output is,<br />
Starting Time : 4295048924899<br />
End time : 4297258900362<br />
(long)(long)rt_timer_ticks2ns(end-start)=3D -1790994340162556031 <br />
<br />
<br />
-Prakash<br><Table border=3D0 Width=3D644 Height=3D57 cellspacing=3D0 cellp=
adding=3D0 style=3D"font-family:Verdana;font-size:11px;line-height:15px;"><=
TR><td><A HREF=3D"http://sigads.rediff.com/RealMedia/ads/click_nx.ads/www.r=
ediffmail.com/signatureline.htm@domain.hid?" target=3D"_blank"><IMG SRC=3D"http=
://sigads.rediff.com/RealMedia/ads/adstream_nx.ads/www.rediffmail.com/signa=
tureline.htm@domain.hid"></A></td></TR></Table>
--=_c4e013f9bb80744c2bcb711881eaeb5a--

