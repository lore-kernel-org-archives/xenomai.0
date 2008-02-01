Message-ID: <41f748550802010023q27d3f770s51b4358734b35a86@domain.hid>
Date: Fri, 1 Feb 2008 15:23:56 +0700
From: "Iwan Budi Kusnanto" <iwanbk@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] rt_sem_delete failed
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

Hello all.

i has created 5  semaphores in native skin, kernel space.
I think all semaphores work fine.
All semaphores can be deleted, except 1.
when i deleted that semaphore, Linux became crash (oops).
Unfortunatelly, there is no serial port in my box,  so i can't  take
oops message
After add some comment & printk  at rt_sem_delete,i knew that  oops
happened in removeq call.

I already turn on the "queue debug" option in make config.
But there is no additional error message.

whats wrong with my semaphore ?

I use linux 2.4.34 and xenomai 2.4.0 adeos-ipipe-2.4.34-i386-1.3-03

Thx.



-- 
Iwan Budi Kusnanto

http://iwanbk.org
http://blog.iwanbk.org

