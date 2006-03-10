Message-ID: <4411B23E.8000300@domain.hid>
Date: Fri, 10 Mar 2006 11:07:10 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai vs. RTLinux
References: <440F5F23.7000703@domain.hid> <44118EDC.2010003@domain.hid>
In-Reply-To: <44118EDC.2010003@domain.hid>
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
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
>> The worst-case scheduling latency for the xenomai user-space 
>> application was only a few microseconds worse than the kernel-space 
>> version.  Is this what you would expect?
>>
> Usually, yes. The gap may increase on low-end systems though, especially 
> for those exhibiting unfriendly cache behaviour for instance. But the 
> worst-case latency is still predictable, albeit higher.


Thanks.  That answer was very helpful.


>> Is RTLinuxPro's PSDD (user-space) development environment similar to 
>> xenomai's user-space real-time threads?  Any known 
>> advantages/disadvantages to either system?
> 
> My knowledge of PSDD being limited to the contents of the press 
> releases, which are the services PSDD provides to applications, roughly?


I received some documentation describing PSDD from FSMLabs yesterday that answers most of my questions.  In case anyone is interested, here is a brief description of PSDD, based on how I understand it.  (Of course, my understanding could be wrong on some points.)  

PSDD is basically a user-space implementation of the RTCore API (most of it, at least), which is used in the standard RTLinuxPro.  The main program and real-time tasks can reside in the same source file and share the same memory space, but there is still a strict separation between real-time and non-real-time code.  The real-time threads can call reentrant functions in various libraries (such as sprintf), but cannot make linux system calls.  Memory allocation and any changes to the memory map must be done before the first the first real-time thread is started.  When the real-time threads are running, the process memory-map remains fixed.  A real-time allocator is provided that basically pre-allocates memory for malloc calls, so that library routines that use dynamic memory allocation will still work.  PSDD also requires that all of the RTCore API calls be prefixed by 'rtl_' (e.g. pthread_create -> rtl_pthread_create) to distinguish them from the user-space versions.  This see
ms to go against the practice of adhering to the standard POSIX API, which FSMLabs promotes so much.

>From what I understand, it appears that Xenomai's approach offers better user-space functionality.  The transparent migration of tasks from the Xenomai domain to the Linux domain is fantastic.  The ability to make linux system calls is very powerful, provided that one is careful about where this is done.  Also having to prefix POSIX calls with rtl_ is an ugly drawback for the PSDD side (especially since this doesn't match their kernel-based API).

I'm not quite clear on the memory allocation question.  Does Xenomai have the same restriction on allocating memory after a real-time task has been created?  I had been thinking that memory allocation could be done from the linux context, or by a real-time task in secondary mode.  (I thought I saw some documentation on this, but can't find it at the moment.  I could certainly be mistaken.)  If so, that's a big advantage for Xenomai as well.

Anyway, it appears to me that Xenomai user-space has some major advantages over PSDD.


>> We currently use C and FORTRAN in our RTLinuxFree modules, and would 
>> like to be able to add C++ and FORTRAN as well.  Are there any 
>> problems you see with using these languages in xenomai user-space 
>> real-time programs?
> 
> None, provided your runtime environment can invoke callouts written in C 
> in order to start Xenomai system calls. Those syscalls use the very same 
> channel to re-enter the kernel than normal Linux system calls.


I'm glad to hear this.  This is a great advantage of Xenomai from my perspective.


> I would rephrase your question this way: "what would prevent Xenomai 
> from becoming a proprietary technology?". Short answer: critical pieces 
> of the Xenomai codebase bear various GPL copyrights from different 
> people or organizations having very little or no common interests, aside 
> of keeping Xenomai free, that is. Another form of the famous "divide and 
> conquer" approach.


Thank you so much for making this point.  The shared copyright is a major factor in my mind.


> My answer must be awfully biased, but:
> http://www.linuxdevices.com/news/NS7320885236.html


Thanks for taking the time to answer my questions.  You were most helpful.

-Jeff

