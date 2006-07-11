Message-ID: <44B35CB7.8010708@domain.hid>
Date: Tue, 11 Jul 2006 10:09:27 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-help] memset of heap crashes Xenomai-Task
References: <5D63919D95F87E4D9D34FF7748CE2C2A3F9210@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A3F9210@domain.hid>
Content-Type: multipart/mixed; boundary="------------010907070406060003070004"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------010907070406060003070004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Roderik_Wildenburg@domain.hid wrote:
>> memset should work with Xenomai heaps, I suspect your problem 
>> is rather that the memory is not really allocated until you 
>> memset it, which fails when no memory is available. In this 
>> case, calling memset on memory allocated with malloc should 
>> segfault the same way when the system memory is exhausted. 
>> IIRC, this behaviour is documented in mlockall manual page.
>>
> 
> Mr. Denk told me about this strange (for RTOSs) behaviour of the 
> Linux kernel. Therefore I used the Xenomai heap mechanism, expecting
> allocated memory is allocated at once not some time later 
> (why do I allocate memory otherwise : to be shure memory is available).
> Does Xenomai use the Linux allocation mechanism ??
> 
> 
>> Be careful with sysconf(_SC_AVPHYS_PAGES), it may include the 
>> swap size, but when mlocking memory, your application can not 
>> use swap pages, so, you should substract the size of swap, if any.
>> Also, what is the value of /proc/sys/vm/overcommit_memory on 
>> your system ?
>>
> 
> Our System does not have a swap device\space.
> /proc/sys/vm/overcommit_memory = 0
> (whatever this means)

I gave your program a try on my MPC5200 and got the following output 
(after some corrections):

bash-2.05b# ./heap2
Start Heap
root_thread_init :
timer startedt
display task created
root_thread_init beendet
Available Memory 56238080 (Pagesize 4096)
heap 0 of size 16000000 created
Heap 0 allocated size 16000000
heap 1 of size 16000000 created
Heap 1 allocated size 16000000
heap 2 of size 16000000 created
Heap 2 allocated size 16000000
__alloc_pages: 0-order allocation failed (gfp=0x1f2/0)
Available Memory after allocation 8933376
__alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Heap 3 created with size 4218880
Heap 3 allocated size 4218880
Memory allocated in total : 52218880
Segmentation fault

The are some long delays (approx. 40 secs) around __alloc_pages. Finally 
it crashes in memset. With the attached xenomai patch, which touches the 
reserved page once, memset works fine. Let's wait what Philippe says. I 
remember that the "touch" was needed for RTAI shared memory as well.

Wolfgang.

--------------010907070406060003070004
Content-Type: text/x-patch;
 name="xenomai-heap-access.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-heap-access.patch"

+ diff -u xenomai/ksrc/nucleus/heap.c.OLD xenomai/ksrc/nucleus/heap.c
--- xenomai/ksrc/nucleus/heap.c.OLD	2006-06-30 10:29:34.000000000 +0200
+++ xenomai/ksrc/nucleus/heap.c	2006-07-11 09:46:30.000000000 +0200
@@ -1044,8 +1044,10 @@
 
 		vabase = (unsigned long)ptr;
 
-		for (vaddr = vabase; vaddr < vabase + size; vaddr += PAGE_SIZE)
+		for (vaddr = vabase; vaddr < vabase + size; vaddr += PAGE_SIZE) {
 			SetPageReserved(virt_to_page(__va_to_kva(vaddr)));
+			*(int *)vaddr = 0; /* touch page once */
+		}
 	} else {
 		/*
 		 * Otherwise, we have been asked for some kmalloc()

--------------010907070406060003070004--

