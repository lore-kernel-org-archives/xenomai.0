From: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
Date: Thu, 30 Jun 2011 12:12:47 -0300
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201106301212.47433.carlosnov@domain.hid>
Subject: [Xenomai-help] Writing a new driver,
	shoud use message pipes or shared memory?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello all!
Hope this question fits to the scope of the list.

I got a PCI acquisition board and wish to write a xenomai driver for it. I had 
did this before with an old ISA board and used memory heaps to exchange data 
from kernel (configuration and mainly acquisition routines) and the real time 
processing task.

Now, I would like to know if I can use only message pipes for this kind of 
application. I would like to use it so the entire proccess became more "unix 
like", using memory heaps I think that the internals of the driver are exposed 
and the any misfuncion can arise due to bad data passed from programmers. Is 
this right?

Can message pipes provide hard real time timings, about 1K/10K samples per 
second and about 100 bytes on each sample?

Thanks

Carlos Novaes.

