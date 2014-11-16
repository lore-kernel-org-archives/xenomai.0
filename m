From: Mathew Benson <mathew.benson@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <9540924A-C2CD-4465-AA62-CD3E0DC6938D@gmail.com>
Date: Sun, 16 Nov 2014 16:16:51 -0600
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: [Xenomai] Remote debug question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

First, I'm sorry if this has been asked and answered here before.  I found a=
 link to a page to search the archives but the link was broken.  So, I'm not=
 sure how to search the archives without downloading them all.

I'm running xenomai 3 on a Beaglebone Black and my host is Mint 17.  All the=
 samples checkout.  I can build and run my own code using xenomai extensions=
, but remote debugging seems to be erratic.  First, I see two threads immedi=
ately at startup though I don't have symbols for the second read.  I didn't c=
reate this thread, so I'm not sure why its there or where it came from. =20

Second, the debugger (dbgserver) seems to lose itself.  I'll step through co=
de and it will suddenly and at random locations just not break on the next l=
ine.  Debugger says threads are still alive, but when I pause execution (tho=
ugh I shouldn't have to since I stepped) it appears all the threads are term=
inated. =20

Lastly, when I run without the debugger I get different behavior.  I never h=
ad a problem before I converted to xenomai, so I'm not sure if its a xenomai=
 or dbg problem.

Basically, are there known problems with dbg and dbgserver?  Is there someth=
ing xenomai specific that I should put in my gdbinit?

Sent from my Packard Bell 386=

