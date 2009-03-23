Message-Id: <D0AF8C6A-CE07-4F45-A9E3-E82CB93F8500@domain.hid>
From: Steven Seeger <steven.seeger@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Mon, 23 Mar 2009 15:59:27 -0400
Subject: [Xenomai-core] irq0 usage
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

We are still running into issues where irq0 is using a lot of CPU  
time. The same threads on an RTAi system on the same hardware used  
about 13% of the CPU but are using closer to 60% on Xenomai. I know  
there is some overhead with userspace calls but hte irq0 handler alone  
accounts for 20% of it. Are there any options that can speed things up?

We've tried both one shot and periodic modes. I confirmed that the ISA  
i/o timing is 1.3usec per outb as expected.

Steven


