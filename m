Message-ID: <4802D528.5090404@domain.hid>
Date: Sun, 13 Apr 2008 23:53:12 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Suspended task resumed without rt_task_resume ?
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

Hi,

what can, besides an explicit call, resume a suspended task ? I created 
and started a child task, then shadowed the current thread with T_SUSP 
flag. The child was supposed to call rt_task_resume to wake-up the 
parent and let it terminate the process, but, the parent was resumed 
before this call. The call to rt_task_suspend in parent returned 0. The 
program uses SIGALRM signal. Could this be the cause ?

Thanks,

Tomas

