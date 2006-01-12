Message-ID: <43C67A80.40100@domain.hid>
Date: Thu, 12 Jan 2006 16:49:20 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT Heap in Userspace
References: <200601121136.38271.s.zimmermann@domain.hid>
In-Reply-To: <200601121136.38271.s.zimmermann@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai@xenomai.org

Stephan Zimmermann wrote:
> Hello again,
> based on your information about memory allocation, I tried out the following:
> 
> in main:
> // creating the Heap
> ret = rt_heap_create(&rt_heap,"Main-RT-Heap",rt_heapsize,H_FIFO);
> 
> global:
> // overloaded operator new 
> void* operator new(size_t size){
> 	void* newmem = NULL;
> 	int ret = rt_heap_alloc(&rt_heap,size,TM_INFINITE,&newmem);
> 	printf("new memory allocated: %i bytes, return %i\n",size,ret); fflush(NULL);
> 	return newmem;
> }
> 
> This works fine, as long as I use a standard 'malloc' in my operator new. When 
> executing the rt_... code, creating the heap returns 0 as expected. But 
> trying to allocate some Memory insode of it using operator new fails with 
> -EEINVAL.
> 
> Reading the API-Doc more thoroughly, I saw a statement that H_SHARED is 
> implicitly set, when a heap is created from Userspace (where my program 
> executes).
> So, is ist possible to do what I try, or will I need to run in kernelspace for 
> it? Maybe there is some 'trick' to do it?
>

Not yet. For the time being, user-space heaps are always built as single shared 
memory segments, which is a useless limitation. There is a plan to fix that in a 
reasonable future, by decoupling the mappable heap property from the 
single-segment one (i.e. which will allow in turn to create shared heaps which are 
not necessarily single-segment areas). If your application can bare higher 
execution latencies as a result of calling the allocator for a while, then you 
might consider sticking with malloc until this fix is available.

Sidenote: going for kernel-space with C++ always seemed to me a bad idea. It's not 
that it is impossible, it's just that it often turns out to be a maintenance hell 
  provided you want to keep your options reasonably open regarding your kernel+gcc 
combo of choice.

> Thaks for your help, Stephan
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

