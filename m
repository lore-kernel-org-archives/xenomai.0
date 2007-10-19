Date: Fri, 19 Oct 2007 12:09:03 +0200
From: "Axel Beierlein" <belatronix@domain.hid>
Content-Type: text/plain; format="flowed"; delsp="yes"; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <op.t0fvtdsnt06gyn@domain.hid>
Subject: [Xenomai-help] array declaration of double values causes seg faults
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

Hello,

i try to use a simple function inside of an RT-Task in Userspace. Inside  
of this function i only declare three array´s of doubles with 5000 values  
in it.
When i run the program a seg fault was shown. When i replace the array  
declaration with an printf the seg fault is away.

Do i have memory limitations inside of an RT-Task?

I use Xeno 2.3.1 with an 2.4.25 Kernel

Axel

