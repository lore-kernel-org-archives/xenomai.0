Date: 12 Aug 2010 15:38:00 -0000
MIME-Version: 1.0
Message-ID: <1281614099.S.2522.62255.H.TldvbGZnYW5nIEdyYW5kZWdnZXIAUmU6IFtYZW5vbWFpLWhlbHBdIFRpbWluZyBjYWxjdWxhdGlvbg__.f4-234-118.old.1281627480.44273@domain.hid>
in-reply-to: <4C63E156.2020102@domain.hid>
From: "asprakash_83" <asprakash_83@domain.hid>
Content-Type: multipart/alternative;
	boundary="=_f009e83e98234a8339e36e696a300742"
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

--=_f009e83e98234a8339e36e696a300742
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"



>> printf(TOTAL LOOP TIMING=%ld us\n", (long)((rt_timer_ticks2ns(end-start))/1000);



>What does:



>printf(TOTAL LOOP TIMING=%lld us\n", rt_timer_ticks2ns(end-start)/1000);



>report.



TOTAL LOOP TIMING = 5377070 us 

In this case, the (unsigned) (long) (long)tart returns 1069623206

and (unsigned) (long) (long)end returns 2151726697



-Prakash








--=_f009e83e98234a8339e36e696a300742
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="UTF-8"

<br />
>> printf(TOTAL LOOP TIMING=3D%ld usn", (long)((rt_timer_ticks2ns(end-start=
))/1000);<br />
<br />
>What does:<br />
<br />
>printf(TOTAL LOOP TIMING=3D%lld usn", rt_timer_ticks2ns(end-start)/1000);<=
br />
<br />
>report.<br />
<br />
TOTAL LOOP TIMING =3D 5377070 us <br />
In this case, the (unsigned) (long) (long)tart returns 1069623206<br />
and (unsigned) (long) (long)end returns 2151726697<br />
<br />
-Prakash<br />
<br />
<br />
<br />
<br><Table border=3D0 Width=3D644 Height=3D57 cellspacing=3D0 cellpadding=
=3D0 style=3D"font-family:Verdana;font-size:11px;line-height:15px;"><TR><td=
><A HREF=3D"http://sigads.rediff.com/RealMedia/ads/click_nx.ads/www.rediffm=
ail.com/signatureline.htm@domain.hid?" target=3D"_blank"><IMG SRC=3D"http://sig=
ads.rediff.com/RealMedia/ads/adstream_nx.ads/www.rediffmail.com/signatureli=
ne.htm@domain.hid"></A></td></TR></Table>
--=_f009e83e98234a8339e36e696a300742--

