Message-Id: <E9C841DC-A355-45F1-852A-3385DDF38885@domain.hid>
From: Steven Seeger <steven.seeger@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Tue, 24 Mar 2009 20:54:07 -0400
Subject: [Xenomai-core] tsc part 3
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

Things seem to be working ok so far. The problem was we had left the  
kernel CONFIG_OPT_TIMING_PERIODIC on by mistake after doing a test.

Numbers are a little nicer but still higher than I'd like. The sound  
driver which has a single rtdm timer running and doing nothing brings  
irq0 handler up from 0.2% to 3.5%. That isn't too bad considering it's  
8000 Hz! With a few threads but with the system idle irq0 is up to  
8.4%. That's more than I'd like, though. :( It didn't get all the way  
to the motor test, so maybe there is another issue.

Steven


