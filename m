Message-Id: <9D18FB1E-E6C2-4A25-8BF1-6BD3EE52416A@comcast.net>
From: Steven Seeger <steven.seeger@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Tue, 24 Mar 2009 19:24:44 -0400
Subject: [Xenomai-core] more on tsc/ticks
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

It seems that the real problem is that something is wrong with the  
TSC. We disabled the watchdog code that removes the TSC as the  
clocksource. Again, the kernel says timerdev is pit (which is right  
because there is no apic) and clockdev is tsc. I go back to emails  
with Jan and Phlippe from Feb 2008 regarding the differences in  
timebases between PIT and TSC. It seems that TSC is stable but I don't  
know. If I had one of those boards I'd be much better off.

Steven

