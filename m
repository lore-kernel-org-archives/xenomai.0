Message-ID: <40982.155.98.4.150.1154987920.squirrel@domain.hid>
Date: Mon, 7 Aug 2006 15:58:40 -0600 (MDT)
From: "Brandt Erickson" <brandt@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] mlockall?
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

I had a program that ran fine under xenomai-2.1.2, but I just upgraded to
xenomai-2.2.0 and when I try to run the program, I get:

  Xenomai: process memory not locked (missing mlockall?)

I saw this article (http://www.captain.at/xenomai-2.2.php) which says to
just add:

  mlockall(MCL_CURRENT | MCL_FUTURE);

I tried just putting this in main, but I get compiler errors.  Is there a
particular file I need to include to resolve this error or am I going
about solving this wrong?  Thanks.
-Brandt


