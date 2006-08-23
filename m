Message-ID: <75975c320608231401k79b60e4o7a53bc75b2149287@domain.hid>
Date: Wed, 23 Aug 2006 17:01:17 -0400
From: "Paul Ianna" <paulianna2002@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] scheduling of low priority primary mode Xenomai
	threads versus high priority secondary mode Xenomai threads
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

Greetings (again),

If a running primary mode high priority Xenomai thread drops to
secondary mode and ends up in a function that takes a "long" time,
what happens to primary mode low priority Xenomai threads that are (or
become) ready to run?

On the flip side, what happens if a high priority secondary mode
Xenomai thread is blocked and becomes ready to run while a low
priority primary mode Xenomai thread is executing?

I guess, asked another way, do Xenomai primary mode threads always
preempt/run with precedence over Xenomai secondary mode threads, even
though a secondary mode thread may have higher Xenomai priority?

Thanks in advance,
Paul

