MIME-Version: 1.0
Date: Thu, 4 Feb 2010 21:21:51 +0530
Message-ID: <1aa9845a1002040751o549d86efh19c7c0c033dae2c1@domain.hid>
From: Saravanan S <sarans1987@domain.hid>
Content-Type: multipart/alternative; boundary=0016367f93723f4ec0047ec850d1
Subject: [Xenomai-help] User interrupt handling in Xenomai running into probs
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

--0016367f93723f4ec0047ec850d1
Content-Type: text/plain; charset=ISO-8859-1

Hi,

    I tried to implement the hardware interrupt handling feature of xenomai
in user space.I read the native-api document and ran the user_irq.c program
with one change ,i tried to intercept the eth0 interrupt on my system(using
interrupt number from cat /proc/interrupts).When i ran the program the
system froze!!!!!

What am i doing wrong??

What  is the purpose of this feature of allowing user space handling of
interrupts.Can a user space driver be written using this???

Thanks in advance.

With regards,

S Saravanan

--0016367f93723f4ec0047ec850d1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>=A0=A0=A0 I tried to implement the hardware interrupt handling f=
eature of xenomai in user space.I read the native-api document and ran the =
user_irq.c program with one change ,i tried to intercept the eth0 interrupt=
 on my system(using interrupt number from cat /proc/interrupts).When i ran =
the program the system froze!!!!!<br>
<br>What am i doing wrong??<br><br>What=A0 is the purpose of this feature o=
f allowing user space handling of interrupts.Can a user space driver be wri=
tten using this???<br><br>Thanks in advance.<br><br>With regards,<br><br>
S Saravanan<br>

--0016367f93723f4ec0047ec850d1--

