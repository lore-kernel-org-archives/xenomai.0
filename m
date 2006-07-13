Message-ID: <44B60737.6050705@domain.hid>
Date: Thu, 13 Jul 2006 10:41:27 +0200
From: Khalil GHORBAL <kg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] handling threads within a pod
References: <44B51D2C.10508@domain.hid> <44B52214.7050009@domain.hid>
In-Reply-To: <44B52214.7050009@domain.hid>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:

>Khalil GHORBAL wrote:
>  
>
>>Hi,
>>
>>I'm trying to implement a new skin (IMA380) using xenomai framework.
>>    
>>
>
>Cool. Just learned that IMA380 is similar to ARNIC 653. Sounds quite
>interesting. Will there be real partitioning? Will we get the chance to
>see/use the result some day?
>  
>
Thank you for your answer Jan.

As I'm not the only concerned I can't give an answer rightnow,
but if it depends only on me, yes, I'll share my work with every body, 
hoping it'll be useful.

>  
>
>>When creating multiple xnthreads within a pod,
>>I didn't found a way to access or handle these threads.
>>Threads are linked to the global queue of a pod but how can I access to
>>the other fields of xnthread structure ?
>>
>>hope it was clear :)
>>    
>>
>
>Not really. Do you mean how to handle references to those threads, how
>to pass them to the user and accept them back? Or do you mean how to
>manipulate fields of the xnthread structure directly. The latter is
>risky as you bypass the nucleus interface. Better check if some service
>of the nucleus layer provide the required access. If not, elaborate what
>kind of access you need.
>  
>
I'll give an example to explain the issue:
Assuming having multiple threads in our active pod, these threads can be 
in different states.
The running thread have to get the *extinfo* field of thread named 
"COM_THREAD" (for example) if exists.

All services of the nucleus need a *xnthread_t* structure to identify 
the thread to treat, we can't have a list or something similar to sweep 
existing threads. All I've found is the global queue, doubly-linked and 
circular, which link all threads.
So all informations I have is the number of threads and a way to go from 
one holder to another
without really be able to identify the thread and read the other fields.

I still misunderstood the function of global queue and how the pod 
schedule existing threads.

>Jan
>
>  
>
Thank you in advance.

Best Regards,
--
Khalil

