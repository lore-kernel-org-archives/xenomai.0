MIME-Version: 1.0
Sender: hadrienstegosaure@domain.hid
Date: Mon, 21 Nov 2011 11:44:59 +0100
Message-ID: <CA+eKTkZ_ymqXx_Nc_9v1HRtYTqSjYqzdN56HCjzO+x14zcUwcg@domain.hid>
From: Hadrien Caron <hadrien.caron@domain.hid>
Content-Type: multipart/alternative; boundary=20cf307c9bfae0501004b23c609c
Subject: [Xenomai-help] [xenomai-help] Error return with a4l_sync_write
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

--20cf307c9bfae0501004b23c609c
Content-Type: text/plain; charset=ISO-8859-1

Hello to all !

I have a small problem using a4l_sync_write : I am using it inside a
program that should write on a digital port.
The function a4l_sync_write returns a value of -38.
But according to the documentation, there is only 3 possible error
possibles :
EINVAL = 22
EFAULT = 14
ENOMEM = 12

So what is error 38 ? Is it missing from the documentation ? Or am I doing
something wrong ?

Thank you very much !

Sincerely

Hadrien Caron

--20cf307c9bfae0501004b23c609c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello to all !<br><br>I have a small problem using a4l_sync_write : I am us=
ing it inside a program that should write on a digital port.<br>The functio=
n a4l_sync_write returns a value of -38. <br>But according to the documenta=
tion, there is only 3 possible error possibles :<br>
EINVAL =3D 22 <br>EFAULT =3D 14 <br>ENOMEM =3D 12<br><br>So what is error 3=
8 ? Is it missing from the documentation ? Or am I doing something wrong ?<=
br><br>Thank you very much !<br><br>Sincerely<br><br>Hadrien Caron<br><br>

--20cf307c9bfae0501004b23c609c--

