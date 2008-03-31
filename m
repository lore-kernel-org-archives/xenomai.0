MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18417.28104.771421.524613@domain.hid>
Date: Tue, 1 Apr 2008 01:03:36 +0200
In-Reply-To: <50566.74.57.109.247.1207002543.squirrel@domain.hid>
References: <50566.74.57.109.247.1207002543.squirrel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] freeze on system() call
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: vleves@domain.hid
Cc: xenomai@xenomai.org, jay@domain.hid

vleves@domain.hid wrote:
 > Hello,
 > 
 > A few months ago, my colleague Jerome Pasquero reported a problem with
 > calls to system() with the 2.4 branch of Xenomai
 > (https://mail.gna.org/public/xenomai-help/2008-01/msg00047.html). I am
 > experiencing the same problem with linux 2.6.24.4 and xenomai 2.4.2.
 > 
 > The problem occurs when calling system() or fork() in a realtime task. It
 > only seems to occur when the program is linked against other libraries
 > (e.g. -lxml2 or -lgtkmm-2.4). The mouse continues to function after the
 > call but the system becomes unresponsive and must be rebooted.

I see you are talking about the mouse, are you running under X-windows ?
If yes, could you try to run your example in the console ? This way you
could see some kernel oops if one occurs.

-- 


					    Gilles.

