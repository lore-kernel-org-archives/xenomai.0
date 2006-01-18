From: Stephan Zimmermann <s.zimmermann@domain.hid>
Date: Wed, 18 Jan 2006 14:44:51 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601181444.51484.s.zimmermann@domain.hid>
Subject: [Xenomai-help] Meassage Queue c++
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

Hello again,
still experimenting with Xenomai and C++, I did wrap a class aroud the 
rt_queue functions. This produces a suspicious bug wich I am unable to track 
down. Perhaps someone here can help.

I start two Tasks, both are instances of my Thread-class. Both Tasks call the 
constructor of my queue-class, creating an queue-object. The first one really 
creates it, the second one gets an -EEXIST error inside the constructor and 
does bind to the queue. Now both tasks have their own queue-object, 
describing the same rt_queue. (in proc everything seems good)

Now, I can write messages to the queue, wich works well. I also can read the 
queue from the other task without problems. Only if the queue is empty and 
the task attempts to read from it, my program crashes without any error- or 
log-message.

A Testprogram in plain C works well, so It must be s.th. with my C++ Classes.

Here is some Code (compiles without warnings):

Constructor:

BM_Queue::BM_Queue(const char* name, size_t size, size_t qlimit, int mode){
	name = name;
	size = size;
	qlimit = qlimit;
	mode = mode;	
	int err = rt_queue_create(&q,name,size,qlimit,mode);
	std::cout << "Constructor queue: create " << err << std::endl;
	if(err == -EEXIST){
		err = rt_queue_bind(&q,name,100000000);
		std::cout << "Konstruktor bm_queue: bind " << err << std::endl;
	}
	switch(err){
		case 0:				usecount++;
							break;
		default:				throw queue_exception(err);
							break;
	}
}


Recieve Function:

void* BM_Queue::rcv(unsigned long int timeout){	
	void* message;
	void* data;
	size_t size = rt_queue_recv(&q,&message,TM_INFINITE);	// blocking won't work!
	std::cout << "Recieve from queue: " << size << std::endl;
	if(size < 0){
		std::cout << "ERROR Q throwing exception: " << size << std::endl; 
		/*--- This exception is not thrown, it simply crashes ---*/
		throw queue_exception(size);
	}
	data = malloc(size);	//using operator new here (and delete there), does not 
change things
	memcpy(data,message,size);
	rt_queue_free(&q,message);
	return data;
}

Any Ideas?

