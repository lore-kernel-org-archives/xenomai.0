Message-Id: <62046396-FE61-4DBB-9A7D-5CF6C2F9C8DE@comcast.net>
From: Steven Seeger <steven.seeger@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Tue, 21 Apr 2009 15:01:34 -0400
Subject: [Xenomai-core] syscalls
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

So our crappy geode does not have sep. I was wondering if syscalls are  
preemptible? If I call rt_task_wait_period() in prio50, but before it  
finishes prio60 schedules in and makes the same call, does it have to  
wait for 50 to finish? It probably doesn't have to wait but I'm just  
checking.

Steven


