Message-ID: <ac3922a00701290419q529f609h61c1c910711dbc5e@domain.hid>
Date: Mon, 29 Jan 2007 13:19:33 +0100
From: "Syed Amer Gilani" <amg@domain.hid>
Sender: groove.c@domain.hid
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] Some Input needed about latency and cyclictest
	results
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

I am currently in the process of writing a report about how well the
realtime results are with xenomai for a project. For this i am of
course using latency and cyclictest. But the results are somewhat odd.
With Load from dd and external ping -f, latency returns results i am
expecting: http://systec.de/dump/latency-load.png
But without Load there is a odd "hole" from 3us to 5us:
http://systec.de/dump/latency-noload.png
Can this somehow be explained?
cyclictest also has this hole: http://systec.de/dump/cyclictest.png
But i am not sure if i completely understand what cyclictest does. Is
it the same as latency just for the posix skin?

Thanks, Amer

