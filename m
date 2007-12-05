Message-ID: <2F8EE677D406514ABE53EF9C0934A666042ABE04@domain.hid>
From: Laurent.POYART@fr.thalesgroup.com
Date: Wed, 5 Dec 2007 09:09:48 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Subject: [Xenomai-help] EINVAL error with rt_queue_create
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

I'm starting using xenomai (I use xenomai 2.4-rc5 with a linux kernel 2.6.23) and as a first example, I have used an example of the directory xenomai-2.4-rc5/examples/native/ (trivial-periodic.c). In this example, I have simply added a RT queue creation using the native API as follow:
	RT_QUEUE theQueue;
	int err = rt_queue_create(&theQueue,"myRtQueue",2048,10,Q_FIFO);

With the previous parameters, I get an error err=-EINVAL. As I didn't find a rational explaination, I have instrumented the xenomai code to find the problem. It seems that rt_queue_create calls the function xnheap_init_mapped with my poolsize of 2048 and with a PAGE_SIZE of 4096. The xnheap_init_mapped function calls xnheap_init which generates the EINVAL when running the following test (extrated from ksrc/nucleus/heap.c):
	if(hdrsize + 2 * pagesize > heapsize)
		return  -EINVAL;
My trace is : hdrsize=32, pagesize = 4096, heapsize = 8192.
I succeed in creating the queue by using a big poolsize.
I don't really understand if there is a constraint when creating a queue or if I get the error because of a bad configuration. 
I just find this strange to have to create the queue with a big pool even if I just need a small one.

Regards.
L.Poyart

