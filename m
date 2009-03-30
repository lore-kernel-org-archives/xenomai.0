Message-Id: <5CF8D9FD-0628-4C6B-BF3D-9A8AF1F5667D@comcast.net>
From: Steven Seeger <steven.seeger@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Mon, 30 Mar 2009 18:46:20 -0400
Subject: [Xenomai-core] pipe issue
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

List,

We seem to have an issue where a rt_pipe_read with TM_NONBLOCK in a  
loop never receives data. We loop and wait on a period for 1 second.  
This used to work. If we just do a 1 second blocking read the data  
will be received. We will write a simple test and send it tomorrow  
morning. I figured I'd write this message in case it rang any bells.

Thanks,
Steven


