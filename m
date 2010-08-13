Date: 13 Aug 2010 04:19:09 -0000
MIME-Version: 1.0
Message-ID: <1281640317.S.3646.40456.F.H.TldvbGZnYW5nIEdyYW5kZWdnZXIAUmU6IFtYZW5vbWFpLWhlbHBdIFRpbWluZyBjYWxjdWxhdGlvbg__.f4-235-209.1281673148.64164@domain.hid>
in-reply-to: <4C6447C2.1070001@domain.hid>
From: "prakash srinivasan" <asprakash_83@domain.hid>
Content-Type: multipart/alternative;
	boundary="=_bc4f6d7af7c4cd257fc3b55957042e5a"
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
To: wg@domain.hid
Cc: xenomai@xenomai.org

--=_bc4f6d7af7c4cd257fc3b55957042e5a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"

>>>> printf(TOTAL LOOP TIMING=%ld us\n", (long)((rt_timer_ticks2ns(end-start))/1000);



>>> What does:



>>> printf(TOTAL LOOP TIMING=%lld us\n", rt_timer_ticks2ns(end-start)/1000);



>>> report.





>> TOTAL LOOP TIMING = 5377070 us 



>> In this case, the (unsigned) (long) (long)tart returns 1069623206



>> and (unsigned) (long) (long)end returns 2151726697



>Are you happy with that result? Did really pass approx. 5 seconds



between start and end?



Definitely not and I am not confident about this output. Coz in this loop period I am sending datas from client to the server. Visibly noted that the server is getting all the datas within a second. So I am not sure the 5 sec is the right output. I just like to know all the above conversions are correct? and is it ok that the start ticks can be more than the end ticks?



-Prakash
--=_bc4f6d7af7c4cd257fc3b55957042e5a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="UTF-8"

>>>> printf(TOTAL LOOP TIMING=3D%ld usn", (long)((rt_timer_ticks2ns(end-sta=
rt))/1000);<br />
<br />
>>> What does:<br />
<br />
>>> printf(TOTAL LOOP TIMING=3D%lld usn", rt_timer_ticks2ns(end-start)/1000=
);<br />
<br />
>>> report.<br />
<br />
<br />
>> TOTAL LOOP TIMING =3D 5377070 us <br />
<br />
>> In this case, the (unsigned) (long) (long)tart returns 1069623206<br />
<br />
>> and (unsigned) (long) (long)end returns 2151726697<br />
<br />
>Are you happy with that result? Did really pass approx. 5 seconds<br />
<br />
between start and end?<br />
<br />
Definitely not and I am not confident about this output. Coz in this loop p=
eriod I am sending datas from client to the server. Visibly noted that the =
server is getting all the datas within a second. So I am not sure the 5 sec=
 is the right output. I just like to know all the above conversions are cor=
rect? and is it ok that the start ticks can be more than the end ticks?<br =
/>
<br />
-Prakash<br><Table border=3D0 Width=3D644 Height=3D57 cellspacing=3D0 cellp=
adding=3D0 style=3D"font-family:Verdana;font-size:11px;line-height:15px;"><=
TR><td><A HREF=3D"http://sigads.rediff.com/RealMedia/ads/click_nx.ads/www.r=
ediffmail.com/signatureline.htm@domain.hid?" target=3D"_blank"><IMG SRC=3D"http=
://sigads.rediff.com/RealMedia/ads/adstream_nx.ads/www.rediffmail.com/signa=
tureline.htm@domain.hid"></A></td></TR></Table>
--=_bc4f6d7af7c4cd257fc3b55957042e5a--

