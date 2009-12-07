From: Paolo Bernini <nihil84@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Mon, 7 Dec 2009 12:00:07 +0100
Message-Id: <94A6EC74-5941-40D6-9F99-6DF96D1FD006@domain.hid>
Mime-Version: 1.0 (Apple Message framework v1077)
Subject: [Xenomai-core] [i.MX27] imx serial driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello all,
first of all I introduce myself: I am Paolo Bernini and I am a student =
of University of Pisa.

While working on my thesis I wrote a real time driver for i.MX special =
serial devices based on current implementation of 16550A. It is very =
simple, it has several limitations and it is tested only for i.MX27 =
processors, but it should support any i.MX processor if supplied of =
their memory map of the devices.

Actually it allocate only one device and the only way to choose which, =
is by in code constraints definitions but it can be easily enhanced, I =
think.

If you are interested I can send it to you as is.


Thanks.

---=20
Paolo Bernini
B.Sc. in Information Technology Engineering

Scuola Superiore di Studi Universitari e Perfezionamento Sant'Anna
ARTS Lab - Advanced Robotics Technology and System Lab
Viale Rinaldo Piaggio, 34 - 56025 Pontedera (Pisa), Italy
Tel.     050 88-3410
e-mail    p.bernini@domain.hid













