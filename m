Message-ID: <47E9B406.8030407@domain.hid>
Date: Tue, 25 Mar 2008 22:25:10 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Direct access to I/O ports and physical memory from
	user-space
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

Hello,

is it possible to access I/O port on x86 solely from Xenomai user-space 
primary domain ? I assume that iopl() and then outb(), inb() should 
work. But, how to avoid switches to secondary domain ?

Similarly, for physical memory, there is an example in Xenomai 
distribution that mmaps /dev/mem. Is there a way to avoid switches here ?

Thanks,
Tomas


