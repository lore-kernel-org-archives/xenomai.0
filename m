Message-ID: <492C108B.1090909@domain.hid>
Date: Tue, 25 Nov 2008 15:49:47 +0100
From: =?ISO-8859-1?Q?C=E9dric_Schaffter?= <cedric.schaffter@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: Quoted-Printable
Subject: [Xenomai-help] SMP issues
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi List!

I'm trying to compare Xenomai performances with and without SMP on my=20
Intel Core 2 duo.
So I built the linux kernel 2.6.25.11 (as described here :=20
http://xenomai.org/index.php/Xenomai_quick_build_quide),
and I disabled the SMP support.

When I used dmesg and as I wanted, only one processor was activated... I=20
performed some tests, increasing tasks
number and also their complexity...

And then, I rebuilt the kernel and specified SMP support and the dmesg=20
command informed me that I have two
processors working. I launched the same applications that I used to test=20
one core.

But the problem is that I get same results in both case... I thought=20
tasks were automatically dispatched between
cores or cpu. Did I forget something?

Best regards,
C=E9dric








