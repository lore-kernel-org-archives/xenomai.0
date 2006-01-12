From: Stephan Zimmermann <s.zimmermann@domain.hid>
Date: Thu, 12 Jan 2006 11:36:38 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601121136.38271.s.zimmermann@domain.hid>
Subject: [Xenomai-help] RT Heap in Userspace
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
based on your information about memory allocation, I tried out the following:

in main:
// creating the Heap
ret = rt_heap_create(&rt_heap,"Main-RT-Heap",rt_heapsize,H_FIFO);

global:
// overloaded operator new 
void* operator new(size_t size){
	void* newmem = NULL;
	int ret = rt_heap_alloc(&rt_heap,size,TM_INFINITE,&newmem);
	printf("new memory allocated: %i bytes, return %i\n",size,ret); fflush(NULL);
	return newmem;
}

This works fine, as long as I use a standard 'malloc' in my operator new. When 
executing the rt_... code, creating the heap returns 0 as expected. But 
trying to allocate some Memory insode of it using operator new fails with 
-EEINVAL.

Reading the API-Doc more thoroughly, I saw a statement that H_SHARED is 
implicitly set, when a heap is created from Userspace (where my program 
executes).
So, is ist possible to do what I try, or will I need to run in kernelspace for 
it? Maybe there is some 'trick' to do it?

Thaks for your help, Stephan

