MIME-Version: 1.0
Date: Mon, 20 Sep 2010 22:42:13 +0200
Message-ID: <AANLkTi=HdW-g6KWHYbKiK5UiLb_SNOQrarfwj53ra4cd@domain.hid>
From: ronny meeus <ronny.meeus@domain.hid>
Content-Type: multipart/alternative; boundary=001636c5b45682e8f20490b6f2c0
Subject: [Xenomai-help] t_getreg / t_setreg undefined references in pSOS+
	skin
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

--001636c5b45682e8f20490b6f2c0
Content-Type: text/plain; charset=ISO-8859-1

Hello

I see in the psos.h file the function declaration for both the t_getreg and
the t_setreg functions.
Also in the psos kernel module I see functionality available.
What I miss it the references for both service calls in the syscall.c file.

This results in undefined references if I try to use the service call in my
application.

Is there any patch available that solves my problem?

Thanks
Ronny

--001636c5b45682e8f20490b6f2c0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello<br><br>I see in the psos.h file the function declaration for both the=
 t_getreg and the t_setreg functions.<br>Also in the psos kernel module I s=
ee functionality available.<br>What I miss it the references for both servi=
ce calls in the syscall.c file.<br>
<br>This results in undefined references if I try to use the service call i=
n my application.<br><br>Is there any patch available that solves my proble=
m?<br><br>Thanks<br>Ronny<br>

--001636c5b45682e8f20490b6f2c0--

