Date: 12 Aug 2010 11:32:44 -0000
MIME-Version: 1.0
Message-ID: <1281608211.S.7513.31575.F.H.TkVyaWMgTm91bGFyZABSZTogW1hlbm9tYWktaGVscF0gVGltaW5nIGNhbGN1bGF0aW9u.f4-234-227.old.1281612764.21936@domain.hid>
in-reply-to: <AANLkTimZDnDnofKR6Of1pfrysQgE7GexWXx1Ejeiv_tP@mail.gmail.com>
From: "prakash srinivasan" <asprakash_83@domain.hid>
Content-Type: multipart/alternative;
	boundary="=_89e4570b6ecc4dc017b340f7992e1034"
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

--=_89e4570b6ecc4dc017b340f7992e1034
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"





On Thu, 12 Aug 2010 15:46:51 +0530  wrote

>>2010/8/12 prakash srinivasan 

>>

>> Deal All,

>> I am executing a simple for() loop and like to calculate the time period for this loop. I used rt_timer_read(). As per the document, it mentioned that rt_timer_read() returns the current time expressed in clock ticks. I could not able to get an clear idea about it. Suppose if i convert it by using rt_timer_ticks2ns(), I am not getting the proper output. My code is,



>> RTIME start, end;

>> ...

>> ...

>> start=rt_timer_read();

>> for()

>> {}

>> end=rt_timer_read();

>> printf(TOTAL LOOP TIMING=%ld usn", (long)((rt_timer_ticks2ns(end-start))/1000);

>>

>> I would like to convert the ticks into nano seconds first and then into micro seconds. The final result is irrelevant. I am not sure, where is the issue. Help me to find the timings details properly.



>Irrelevant how? Not repeatable?



Early I gave (long)(start). The output was in negative.



>What are the printed values?

>Did you try without rt_timer_ticks2ns first?



Output without rt_time_ticks2ns()::



printf("Starting time: %ld\n",(long)start);

Starting time: 445465374

printf("End time: %ld\n",(long)end);

End time: 927680697

printf (Difference time:%ld\n",(long)(end-start))

Difference time: 482215323



Output with rt_timer_ticks2ns()::



printf("Starting time: %ld\n",(long)rt_timer_ticks2ns(start));

Starting time: -2090279950

printf("End time: %ld\n",(long)rt_timer_ticks2ns(end));

End time: -1168915612

printf (Difference time:%ld\n",(long)rt_timer_ticks2ns(end-start))

Difference time: 921364338



whether my call is correct, (long) rt_timerticks2ns(end-start)?



-Prakash
--=_89e4570b6ecc4dc017b340f7992e1034
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="UTF-8"

<br />
<br />
On Thu, 12 Aug 2010 15:46:51 +0530  wrote<br />
>>2010/8/12 prakash srinivasan <asprakash_83@domain.hid><br />
>><br />
>> Deal All,<br />
>> I am executing a simple for() loop and like to calculate the time period=
 for this loop. I used rt_timer_read(). As per the document, it mentioned t=
hat rt_timer_read() returns the current time expressed in clock ticks. I co=
uld not able to get an clear idea about it. Suppose if i convert it by usin=
g rt_timer_ticks2ns(), I am not getting the proper output. My code is,<br /=
>
<br />
>> RTIME start, end;<br />
>> ...<br />
>> ...<br />
>> start=3Drt_timer_read();<br />
>> for()<br />
>> {}<br />
>> end=3Drt_timer_read();<br />
>> printf(TOTAL LOOP TIMING=3D%ld usn", (long)((rt_timer_ticks2ns(end-start=
))/1000);<br />
>><br />
>> I would like to convert the ticks into nano seconds first and then into =
micro seconds. The final result is irrelevant. I am not sure, where is the =
issue. Help me to find the timings details properly.<br />
<br />
>Irrelevant how? Not repeatable?<br />
<br />
Early I gave (long)(start). The output was in negative.<br />
<br />
>What are the printed values?<br />
>Did you try without rt_timer_ticks2ns first?<br />
<br />
Output without rt_time_ticks2ns()::<br />
<br />
printf("Starting time: %ldn",(long)start);<br />
Starting time: 445465374<br />
printf("End time: %ldn",(long)end);<br />
End time: 927680697<br />
printf (Difference time:%ldn",(long)(end-start))<br />
Difference time: 482215323<br />
<br />
Output with rt_timer_ticks2ns()::<br />
<br />
printf("Starting time: %ldn",(long)rt_timer_ticks2ns(start));<br />
Starting time: -2090279950<br />
printf("End time: %ldn",(long)rt_timer_ticks2ns(end));<br />
End time: -1168915612<br />
printf (Difference time:%ldn",(long)rt_timer_ticks2ns(end-start))<br />
Difference time: 921364338<br />
<br />
whether my call is correct, (long) rt_timerticks2ns(end-start)?<br />
<br />
-Prakash<br><Table border=3D0 Width=3D644 Height=3D57 cellspacing=3D0 cellp=
adding=3D0 style=3D"font-family:Verdana;font-size:11px;line-height:15px;"><=
TR><td><A HREF=3D"http://sigads.rediff.com/RealMedia/ads/click_nx.ads/www.r=
ediffmail.com/signatureline.htm@domain.hid?" target=3D"_blank"><IMG SRC=3D"http=
://sigads.rediff.com/RealMedia/ads/adstream_nx.ads/www.rediffmail.com/signa=
tureline.htm@domain.hid"></A></td></TR></Table>
--=_89e4570b6ecc4dc017b340f7992e1034--

