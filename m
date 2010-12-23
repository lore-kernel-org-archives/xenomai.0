MIME-Version: 1.0
Date: Thu, 23 Dec 2010 09:04:09 +0530
Message-ID: <AANLkTikSv9m0efGfxgcQ=0Bee5DPxZSC+4U=Csd4ccwM@mail.gmail.com>
From: Peter Warner <xenomai.start@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6dab18af09a1e04980b8af2
Subject: [Xenomai-help] rt_dev_read hangup
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0016e6dab18af09a1e04980b8af2
Content-Type: text/plain; charset=ISO-8859-1

Hi Xenomai Users,

first I Will Give the Details of My System:

Processor: core2duo
RAM: 4GB
Operating System: Ubuntu 10.04
kernel: 2.6.32.15 (Patched with xenomai)
Xenomai: 2.5.4

I am Using UART sample code Code Provided with xenomai. It is working fine
for about few minutes I am able to send and receive data accurately.
I am using rt_dev_read()  and rt_dev_write() from the user space to read and
write the data respectively. However the code is getting hanged after some
time I tried to debug and Finally I found the code is getting hanged every
time at rt_dev_read() it is not coming back from there.

What Might be wrong here I tried to find out the documentation of
rt_dev_read() but I did not get it.
Again I tried the same with xenomai-2.5.5.2 and I found it is getting hanged
Immediately i.e It is not running at all.

can any of you Please Suggest whats the Wrong Here.
any Suggestion?



Thank you.

--0016e6dab18af09a1e04980b8af2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Xenomai Users,<br><br>first I Will Give the Details of My System:<br><br=
>Processor: core2duo<br>RAM: 4GB<br>Operating System: Ubuntu 10.04<br>kerne=
l: 2.6.32.15 (Patched with xenomai)<br>Xenomai: 2.5.4<br><br>I am Using UAR=
T sample code Code Provided with xenomai. It is working fine for about few =
minutes I am able to send and receive data accurately. <br>
I am using rt_dev_read()=A0 and rt_dev_write() from the user space to read =
and write the data respectively. However the code is getting hanged after s=
ome time I tried to debug and Finally I found the code is getting hanged ev=
ery time at rt_dev_read() it is not coming back from there.<br>
<br>What Might be wrong here I tried to find out the documentation of rt_de=
v_read() but I did not get it.<br>Again I tried the same with xenomai-2.5.5=
.2 and I found it is getting hanged Immediately i.e It is not running at al=
l.<br>
<br>can any of you Please Suggest whats the Wrong Here.<br>any Suggestion?<=
br><br><br><br>Thank you.<br><br><br><br>

--0016e6dab18af09a1e04980b8af2--

