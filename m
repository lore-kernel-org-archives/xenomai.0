Message-ID: <458A8B8A.8060401@domain.hid>
Date: Thu, 21 Dec 2006 14:26:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: A fairly small rtnet/Xenomai application that
	freezes the
References: <458A4DE0.5030005@domain.hid>	
	<7145056.1166514841031.JavaMail.ngmail@domain.hid>	
	<4970132.1166516081275.JavaMail.ngmail@domain.hid>	
	<2579704.1166520394117.JavaMail.ngmail@domain.hid>	
	<4383100.1166529856857.JavaMail.ngmail@domain.hid>	
	<13529671.1166621136153.JavaMail.ngmail@domain.hid>	
	<15069404.1166690889417.JavaMail.ngmail@domain.hid>	
	<2890274.1166696466862.JavaMail.ngmail@domain.hid>	
	<458A67B6.8000207@domain.hid> <458A7185.8070803@domain.hid>
	<b647ffbd0612210450r4e515046v4eb69da0f6c6c0b3@domain.hid>
In-Reply-To: <b647ffbd0612210450r4e515046v4eb69da0f6c6c0b3@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai help <xenomai@xenomai.org>

Dmitry Adamushko wrote:
> On 21/12/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> 
>>Gilles Chanteperdrix wrote:
> 
> ...
> 
>>>>static void realtimetask(void *arg)
>>>>{
>>>>    system("ls -l");
>>>
>>>If you want to use system (or any function calling fork, eg popen or
>>>vfork) with Xenomai, you have to make sure to fault all pages mapped
>>>with write permission after the fork before trying to use services in
>>>priimary mode, because fork write protects all pages with write
>>>permission and notably the threads stacks. A piece of code that faults
>>>all pages follows.
>>
>>Let me check if I got this correctly: fork calls mark all pages
>>write-protected - also those of the father process, or only those of the
>>new child?
> 
> 
> It's copy-on-write policy. fork() creates a separate address space for
> a child (vm_struct, vm_area(s), all the page tables) but it still
> points to the same physical pages as parent's address space. Now what
> if either a child or parent want to modify writeable pages? That's why
> copy-on-write. A new page will be allocated when a write request is
> commited. And yep, to address this issue, the vm areas of (in fact,
> related areas in page tables) both parent and child are marked as
> copy-on-write.
> 
> But I don't think this is an issue here :
> 
> 1) by the moment system() returns -> the child has finished and there
> is no need to allocate new pages on parent's write requests (not sure
> how linux handles it - have to check);

After the fork and the child has returned, the pages remain write
protected. A fault that would occur after that would do almost nothing,
but still causes a migration to secondary mode.

> 
> 2) (I'd expect logically) the parent did mlockall() in advance for
> even future allocations, so I'd expect copy-on-write is not applicable
> fot it -> all the pages should have been duplicated for a child. Well,
> it's a brief idea. Have to check.

I have checked, mlockall has no effect on copy-on-write.

> 
> so it's likely that it's just a side - effect.
> 
> Mathias: if printf() helps (after system()) so could you try e.g.
> fopen(), fclose() instead? Also, please, do what previously was
> suggested with rt_task_delete(NULL) at the end.
> 
> Another situation would be if one does fork() in real-time app. and
> then both parent and child continue their execution (worth checking).
> 
> p.s. vfork() is a different beast. Here a child is supposed to call
> exec*() rigth after fork() so it's allowed to "borrow" parent's
> address space (vm_struct -> all vm_area(s)) and the parent is blocked
> in the mean time. As a result, no need for copy-on-write.

I think to remember that glibc vfork is just fork.

-- 
                                                 Gilles Chanteperdrix

