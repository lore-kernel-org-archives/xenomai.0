Message-Id: <BE4E1CF0-48F4-42EF-9C19-A4A01F43A597@domain.hid>
From: Steven Seeger <steven.seeger@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Thu, 26 Mar 2009 13:25:47 -0400
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

Using TSC really dropped us down. I don't know wh\y the timekeeper  
says tsc is unstable. We ran our system for an 8 minute cycle and  
timed it with a stopwatch, and it was accurate to the second.

On our test irq0 usage dropped from 19% to 13%. Thanks for the help,  
guys.

Steven


