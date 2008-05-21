MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18484.28025.505865.374746@domain.hid>
Date: Wed, 21 May 2008 20:44:09 +0200
In-Reply-To: <15059.81.252.86.91.1211386718.squirrel@domain.hid>
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
	<2ff1a98a0805190532i2fdb4267qc4566d98ab8cd57@domain.hid>
	<2ff1a98a0805190557j743680d4sb7d9f5c8e97072e@domain.hid>
	<12036.62.39.72.60.1211212126.squirrel@domain.hid>
	<2ff1a98a0805190857s1ad98139h9abe63b743dda35@domain.hid>
	<5481.62.39.72.60.1211293804.squirrel@domain.hid>
	<18483.10408.141546.420660@domain.hid>
	<2336.81.252.86.91.1211379896.squirrel@domain.hid>
	<2ff1a98a0805210733u39894a17tca5420ae8f7ce5ca@domain.hid>
	<15059.81.252.86.91.1211386718.squirrel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org

Fabien MAHOT wrote:
 > 
 > > I have debugged the sem_wait issue by running your program, unloading
 > > and reloading xenomai posix skin module many times, without any crash
 > > or any reboot.
 > >
 > > It shows one thing: there is an issue crashing your platform. Have you
 > > run the Xenomai testsuite to know if this is a general problem ?
 > >
 > > --
 > >  Gilles
 > >
 > 
 > I ran some Xenomai tests on my target because I haven't installed native
 > skin.
 > 
 > I ran cyclictest, and when I would to quit the execution with CTRL+C, I
 > had a kernel panic - not syncing: Aiee, killing interrupt handler.
 > 
 > what does it mean ? There is a probleme with SIGINT ?

Aha, a kernel panic is much better than a silent crash: at least we can
know what the kernel did not like.
Any chance to see the messages before the kernel panic ? If you have two
computers with serial ports and a serial cross-cable, you can use a
serial console. Otherwise, some users already sent us photographs of the
panic.

-- 


					    Gilles.

