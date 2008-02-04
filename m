Date: Mon, 04 Feb 2008 16:14:25 +0100
From: "Axel Beierlein" <belatronix@domain.hid>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-ID: <op.t5z9ycg9t06gyn@domain.hid>
Subject: [Xenomai-help] relationship of timestamp / timer functions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

Hello,

which corresponding functions do i have to use when i try to get the  
correct timediff between two events. Especially i get an timestamp with  
every CAN Message (wich is implemented with rtdm_clock_read())and on the  
other side i get a timestamp in my Userspace application with  
rt_timer_tsc(). Are they are running at the same base so that i can use  
the difference of both returned values of the functions?

Axel

