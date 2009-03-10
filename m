Message-Id: <9C50C711-0F23-4D77-BE25-DC160A0B474C@comcast.net>
From: Steven Seeger <steven.seeger@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Tue, 10 Mar 2009 06:51:02 -0400
Subject: [Xenomai-core] rtdm timers
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

Gilles believes he's on the track of our FPU issue when using kernel  
threads. Would using an RTDM timer to accomplish our need have the  
same issue? We would not use the FPU in the timer of course, because  
it is not allowed.

I just don't want to spend the time converting things if it won't  
help. Does the list think it would be a worthwhile effort?

Thanks,
Steven


