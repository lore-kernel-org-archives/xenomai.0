MIME-Version: 1.0
Date: Fri, 6 Nov 2009 08:44:13 -0800
Message-ID: <96eea0c80911060844q10526fc0qd17651dc09a1ba82@domain.hid>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/alternative; boundary=00151774177acf72830477b68d43
Subject: Re: [Xenomai-help] real-time parallel port communication
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, pierre.ficheux@domain.hid

--00151774177acf72830477b68d43
Content-Type: text/plain; charset=ISO-8859-1

Hey Pierre,

I need the parallel port driver to do input/output at a relatively high
frequency. In case your driver is suited for that, it would be cool if I
could try it out :)

Thanks,
 Peter

>Peter Pastor a ?crit :
>> Hello there,
>>
>> I need to get real-time communication over a parallel port working. I
>> got the serial port to run in real-time using the drivers provided by
>> xenomai. However, I haven't found similar drivers for the parallel port
>> yet. Does the new analogy branch contain real-time drivers for the
>> parallel port ??
>>
>> I would be happy for any hints. Also, would be cool if somebody could
>> point me to some example programs.
>>
>
>I wrote a sample RTDM driver based on outb (char, 0x378). What do you
>want to do with // port? input? output? interrupt? somthing like old
>style "Centronics" ?
>
>regards

--00151774177acf72830477b68d43
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hey Pierre,</div><div><br></div><div>I need the parallel port driver t=
o do input/output at a relatively high frequency. In case your driver is su=
ited for that, it would be cool if I could try it out :)=A0</div><div><br>
</div><div>Thanks,</div><div>=A0Peter</div><div><br></div><div>&gt;Peter Pa=
stor a ?crit :</div><div>&gt;&gt; Hello there,</div><div>&gt;&gt;</div><div=
>&gt;&gt; I need to get real-time communication over a parallel port workin=
g. I</div>
<div>&gt;&gt; got the serial port to run in real-time using the drivers pro=
vided by</div>


<div>&gt;&gt; xenomai. However, I haven&#39;t found similar drivers for the=
 parallel port</div><div>&gt;&gt; yet. Does the new analogy branch contain =
real-time drivers for the</div><div>&gt;&gt; parallel port ??</div><div>



&gt;&gt;</div><div>&gt;&gt; I would be happy for any hints. Also, would be =
cool if somebody could</div><div>&gt;&gt; point me to some example programs=
.</div><div>&gt;&gt;</div><div>&gt;</div><div>&gt;I wrote a sample RTDM dri=
ver based on outb (char, 0x378). What do you</div>



<div>&gt;want to do with // port? input? output? interrupt? somthing like o=
ld</div><div>&gt;style &quot;Centronics&quot; ?</div><div>&gt;</div><div>&g=
t;regards</div>

--00151774177acf72830477b68d43--

