Date: 12 Aug 2010 09:39:44 -0000
Message-ID: <20100812093944.14467.qmail@domain.hid>
MIME-Version: 1.0
From: "prakash srinivasan" <asprakash_83@domain.hid>
Content-Type: multipart/alternative;
	boundary="=_4be0a8905aac45e6a338203f06a49cc1"
Subject: [Xenomai-help] =?utf-8?q?Timing_calculation?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--=_4be0a8905aac45e6a338203f06a49cc1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"

Deal All,

       I am executing a simple for() loop and like to calculate the time period for this loop. I used rt_timer_read(). As per the document, it mentioned that rt_timer_read() returns the current time expressed in clock ticks. I could not able to get an clear idea about it. Suppose if i convert it by using rt_timer_ticks2ns(), I am not getting the proper output. My code is,



RTIME start, end;

...

...

start=rt_timer_read();

for()

{}

end=rt_timer_read();

printf(TOTAL LOOP TIMING=%ld us\n", (long)((rt_timer_ticks2ns(end-start))/1000);



I would like to convert the ticks into nano seconds first and then into micro seconds. The final result is irrelevant. I am not sure, where is the issue. Help me to find the timings details properly.



In the example program trivial-periodic.c, they mentioned 



"NOTE: printf may have unexpected impact on the timing of your program. It is used here in the critical loop only for demonstration purposes."



Why?

 



-Prakash 



  
--=_4be0a8905aac45e6a338203f06a49cc1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="UTF-8"

Deal All,<br />
       I am executing a simple for() loop and like to calculate the time pe=
riod for this loop. I used rt_timer_read(). As per the document, it mention=
ed that rt_timer_read() returns the current time expressed in clock ticks. =
I could not able to get an clear idea about it. Suppose if i convert it by =
using rt_timer_ticks2ns(), I am not getting the proper output. My code is,<=
br />
<br />
RTIME start, end;<br />
=2E..<br />
=2E..<br />
start=3Drt_timer_read();<br />
for()<br />
{}<br />
end=3Drt_timer_read();<br />
printf(TOTAL LOOP TIMING=3D%ld usn", (long)((rt_timer_ticks2ns(end-start))/=
1000);<br />
<br />
I would like to convert the ticks into nano seconds first and then into mic=
ro seconds. The final result is irrelevant. I am not sure, where is the iss=
ue. Help me to find the timings details properly.<br />
<br />
In the example program trivial-periodic.c, they mentioned <br />
<br />
"NOTE: printf may have unexpected impact on the timing of your program. It =
is used here in the critical loop only for demonstration purposes."<br />
<br />
Why?<br />
 <br />
<br />
-Prakash <br />
<br />
  <br><Table border=3D0 Width=3D644 Height=3D57 cellspacing=3D0 cellpadding=
=3D0 style=3D"font-family:Verdana;font-size:11px;line-height:15px;"><TR><td=
><A HREF=3D"http://sigads.rediff.com/RealMedia/ads/click_nx.ads/www.rediffm=
ail.com/signatureline.htm@domain.hid?" target=3D"_blank"><IMG SRC=3D"http://sig=
ads.rediff.com/RealMedia/ads/adstream_nx.ads/www.rediffmail.com/signatureli=
ne.htm@domain.hid"></A></td></TR></Table>
--=_4be0a8905aac45e6a338203f06a49cc1--

