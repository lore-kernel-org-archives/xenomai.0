Message-ID: <438D993E.7010904@domain.hid>
Date: Wed, 30 Nov 2005 13:21:18 +0100
From: Kai Moritz <kai.m.moritz@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060302080109090602020105"
Subject: [Xenomai-help] Problems with mutex
Reply-To: kai.m.moritz@domain.hid
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

This is a multi-part message in MIME format.
--------------060302080109090602020105
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello folks,

I'm using Xenomai 2.0.1 with Linux 2.6.14 and ipipe. I've a strange 
problem using mutex-locks. Repeted calls to rt_mutex_lock with 
TM_NONBLOCK on the same mutex return always 0, which means lock 
successfully aquired, if I understand the API-documentation right.
I've attached a small programm to test that behavior and the 
log-messages it produces on my machine. Perhaps anyone has a hint, what 
I'm doing wrong...

Greetings Kai Moritz

--------------060302080109090602020105
Content-Type: application/x-gtar;
 name="mutex.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="mutex.tgz"

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
--------------060302080109090602020105
Content-Type: text/plain;
 name="messages"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages"

Nov 29 19:35:47 localhost kernel: mutex: module initialization... mutex: creating mutex... done!
Nov 29 19:35:47 localhost kernel: mutex: initializing test thread... done.
Nov 29 19:35:47 localhost kernel: mutex: starting rt timer (one shot mode)... done.
Nov 29 19:35:47 localhost kernel: mutex: starting test thread... 
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the  0th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the  1th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the  2th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the  3th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the  4th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the  5th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the  6th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the  7th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the  8th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the  9th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the 10th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the 11th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the 12th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the 13th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the 14th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the 15th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the 16th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the 17th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the 18th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: locking mutex the 19th time...done: 0!
Nov 29 19:35:47 localhost kernel: mutex: all tests done!
Nov 29 19:35:47 localhost kernel: mutex: test thread successfully started.
Nov 29 19:35:47 localhost kernel: mutex: module initialization done.
Nov 29 19:35:47 localhost kernel: mutex: deleting mutex... done!
Nov 29 19:35:47 localhost kernel: mutex: module cleanup done.

--------------060302080109090602020105--

