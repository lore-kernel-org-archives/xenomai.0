From: ke zhou <zhou_ke2001@domain.hid>
Date: Wed, 3 Aug 2011 04:09:16 +0000 (UTC)
Message-ID: <loom.20110803T060604-81@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] latency: failed to set periodic, code -110
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

hello ,everyone!
I`m trying to patch the 2.6.25 kernel with Adeos Ipipe.And the xenomai
version is xenomai-2.4.4.tar.gz.
But when I execute " ./latency -t0 -T60 -p100 -h " on the s3c2440 board,there 
are some errors : 
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
latency: failed to set periodic, code -110
latency: failed to pend on semaphore, code -110

Any idea about that ?
Thank you!






