Message-Id: <AAEE17A8-87D3-4E86-8FE3-4425288722A9@domain.hid>
From: Steven Seeger <steven.seeger@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Sat, 7 Mar 2009 23:44:08 -0500
Subject: [Xenomai-help] geode tsc
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

So a while ago Philippe made us a little patch to turn TSC off on our  
geode. What this did do, I noticed, is greatly increase the CPU usage  
of the irq0 handler. I was wondering if there's any way we could get  
the TSC working again if we don't let the board suspend when idle? It  
uses so little power it's ok if it just spins at idle.

Thanks,
Steven


