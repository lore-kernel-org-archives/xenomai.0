From: Alessandro Pittaluga <xpit@domain.hid>
Date: Thu, 16 Mar 2006 21:15:19 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603162115.20077.xpit@domain.hid>
Subject: [Xenomai-help] rt_task_catch and rt_hook in user space?
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

Hi to everybody,

Anyone knows why the rt_task_catch and rt_hook is not available in the native
library?

rt_task_catch seems to me the only clean way to define signal handlers on 
per-thread basis, but it is not included in the user space lib, although the 
doc states that the service should be available to user space tasks.

The hooks (registered on context switch) are very useful to calculate number 
of switches, consumed cpu time and so on..

Is there any plan to implement them in user space?

 
Many Thanks

Alessandro


