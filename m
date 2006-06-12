Message-ID: <45045.155.98.4.39.1150149018.squirrel@domain.hid>
Date: Mon, 12 Jun 2006 15:50:18 -0600 (MDT)
From: "Brandt Erickson" <brandt@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] strange periodic behavior
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

Hey all,
I've been experimenting with writing a simple timer program using the
native API.  Basically, each loop, it writes the current timestamp into
shared memory which then gets read by a slower loop and written to disk. 
The weird thing is, the period I get seems to always be half of what I've
commanded.  That is, if I set the frequency to 1000 Hz, the difference
between each timestamp is a little over 2 ms (500 Hz).  It works the same
way for 10000 Hz and 20000 Hz.  Does anyone know what causes this or how
to fix it?  Thanks.
-Brandt


