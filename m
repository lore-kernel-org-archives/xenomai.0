Message-ID: <4E3AD80D.9080903@domain.hid>
Date: Thu, 04 Aug 2011 19:34:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1312478766.54971.YahooMailClassic@domain.hid>
In-Reply-To: <1312478766.54971.YahooMailClassic@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] clock problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philip Ha <philwman@domain.hid>
Cc: xenomai@xenomai.org


Would it be possible for you to send mails formatted correctly?

Then the bug is somewhere in between the serial line and the test
application, including possibly in the driver.

In order to know where it is, you should compute the latency at each
point on this path: when receiving the interrupt, when waking up the
task, etc...

-- 
                                                                Gilles.

