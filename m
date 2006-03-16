Message-ID: <44196DD8.8040500@domain.hid>
Date: Thu, 16 Mar 2006 14:53:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] VxWorks skin improvement
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, xenomai@xenomai.org


I'm currently working on extending the VxWorks skin so that it is going to be 
callable from user-space directly, without needing the UVM environment. This will 
also make its functional extension easier in the future, especially with respect 
to bsp-related services.

While I'm at it, I'd also like to polish a few corner cases, so that we have the 
closest possible emulation of the original RTOS services. Unfortunately, the 
VxWorks documentation is rather terse on some behavioural aspects, and I have no 
VxWorks target at hand to test and check them. Therefore, I definitely need help 
from people reading this list who also happen to be VxWorks users, for providing 
the following missing bits of information:

- How does taskName() behave when passed a null task id? Is it equivalent to 
specifying taskIdSelf(), or does it lead to a NULL error return?

- How does msgQSend() behave when passed an invalid message priority, i.e. neither 
MSG_PRI_NORMAL nor MSG_PRI_URGENT?

- How does taskInit() behave when passed an invalid set of task options? Are the 
invalid flags ignored, or does the routine return an error status?

If you happen to have a VxWorks target at hand regardless of the architecture, and 
are willing to help improving the behavioural correctness of the VxWorks skin, 
then your input will be most welcome.

-- 

Philippe.

