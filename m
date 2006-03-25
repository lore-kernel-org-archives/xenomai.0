Message-Id: <1143280058.14325.257499491@domain.hid>
From: "Alessandro Pittaluga" <xpit@domain.hid>
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Date: Sat, 25 Mar 2006 10:47:38 +0100
Subject: [Xenomai-help] RT_TASK descriptor question
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

In the native skin rt_task_create receives a pointer to a RT_TASK struct
which must be allocated in permanent memory.
So I thought that the address of this struct would be the task
identifier used to be passed to the other rt_task functions.
And it works in this way.

The strange thing is that rt_task_self does not return the same value of
RT_TASK*, but allocates a new RT_TASK structure the first time it is
called in a new task context.

Why? 

Many thanks

Alessandro
-- 
  Alessandro Pittaluga
  al.pittaluga@domain.hid

-- 
http://www.fastmail.fm - A fast, anti-spam email service.


