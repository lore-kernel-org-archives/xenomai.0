From: Konstantinos Chalas <konchalas@gmail.com>
Message-ID: <55ED7A9E.1080209@gmail.com>
Date: Mon, 7 Sep 2015 13:53:02 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] timer_create( ) example in Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hello everyone,

Does any of you have a working implementation of timer_create( ) in 
Xenomai-3?

According to the documentation /only thread-directed notification is 
supported (evp->sigev_notify set to//SIGEV_THREAD_ID//). The thing is 
that the use of //SIG/EV_THREAD_ID is not common, therefore it is hard 
to find any help.../

/By the way, the example provided at the end of 
http://www.softprayog.in/tutorials/alarm-sleep-and-high-resolution-timers, 
crashes my system. I understand that it doesn't comply with Xenomai 
documentation, but should it crash the whole system?

Thanks,
Konstantinos
/

/
