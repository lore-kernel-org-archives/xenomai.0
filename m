Message-ID: <188636.66895.qm@domain.hid>
Date: Tue, 16 Jun 2009 15:23:49 -0700 (PDT)
From: Guvenc Gulce <gulceg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Xenomai-help] Native API rt_pipe_monitor() call can not be called
	from an RT Task in linux userspace ?
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


Hello

I have the following questions regarding the rt_pipe behavior in Xenomai. 

-> Why is not possible to use rt_pipe_monitor() Native API call from an userspace RT Task ?

-> What is the solution if async notifications in rt-pipe context are needed in userspace RT Tasks ?

-> Is there any plan to implement something similar to linux's epoll system call for the rt-pipes used 
in userspace RT tasks ?

Thanks & Regards

Guvenc


      

