From: Peter Soetens <peter.soetens@domain.hid>
Date: Mon, 14 Jan 2008 16:27:31 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200801141627.32289.peter.soetens@domain.hid>
Subject: [Xenomai-help] Is rt_task_set_mode( T_PRIMARY, 0, 0 ) temporary ?
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

Is it possible that this call only clears the T_PRIMARY flag temporary, and 
that after 'some' rt_ call, the flag is set again ? 

I tried to check this with rt_task_inquire(	task, &info ) and check  
info.status & XNRELAX but that always returned false.

Peter
-- 
Peter Soetens -- FMTC -- <http://www.fmtc.be>

