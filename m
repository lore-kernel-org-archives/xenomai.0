Message-ID: <2F8EE677D406514ABE53EF9C0934A666042ABE0C@anubis2.clb.tcfr.thales>
From: Laurent.POYART@fr.thalesgroup.com
Date: Wed, 12 Dec 2007 08:51:33 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [Xenomai-help] Pool Size of RT queues
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

I'm using xenomai 2.4-rc5 with a linux kernel 2.6.23. I have got a problem
with a simple test in which I try to create a RT queue using the native API:
 	RT_QUEUE theQueue;
	int err = rt_queue_create(&theQueue,"myRtQueue",2048,10,Q_FIFO); 
With the previous parameters, I get an error err=-EINVAL. I have
instrumented the xenomai code to find the problem.  rt_queue_create calls
the function xnheap_init_mapped with my poolsize of 2048 and with a
PAGE_SIZE of 4096. The xnheap_init_mapped function calls xnheap_init which
generates the EINVAL when running the following test (extrated from
ksrc/nucleus/heap.c): 
	if(hdrsize + 2 * pagesize > heapsize) return -EINVAL; 
I have extracted the values of the local variables: hdrsize=32, pagesize =
4096, heapsize = 8192. 
I succeed in creating the queue by using a big poolsize. I don't really
understand if there is a constraint when creating a queue or if I get the
error because of a bad configuration. I just find this strange to have to
create the queue with a big pool even if I just need a small one. 
Does anybody already encounter this kind of problem?

L.Poyart 


