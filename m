Message-ID: <46B2E1B3.2020102@domain.hid>
Date: Fri, 03 Aug 2007 10:05:07 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <46B1A842.1090708@domain.hid>	
	<1186049556.6611.319.camel@domain.hid>
	<46B1B7DE.3080404@domain.hid>
	<1186053839.6611.326.camel@domain.hid>
In-Reply-To: <1186053839.6611.326.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Unexpected switch to secondary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai-help@domain.hid

Philippe,

(BTW: is this something that should be discussed in the Xenomai group, 
or would it be better to move this discussion to the Adeos mailing list?)

I do have question on this. We already discussed this problem earlier, 
and I managed to find a very dirty work around for my application: I 
added a lot of "dummy" functions to my application, which are spread 
over the whole application. By calling these after the mlockall, but 
before I switch to RT-mode I manage to eliminate most of the switches.

Philippe Gerum wrote:
> So it's unfortunately possible to experiment such switches on ppc hw for
> now. It is likely happening when the ns value is copied back to a user
> variable for which there is a PTE miss to handle in Linux kernel space
> first. Check the mail archive about "pte", "cow" (copy-on-write) and
> such things.
>   
As far as I know (but I can be incorrect here) an interrupt is generated 
due to a PTE-miss. This causes the Nucleus to switch to secondary mode, 
to allow Linux to process the PTE's. The total latency caused by this 
would not be very bad, as you also indicated earlier.

 From the earlier discussion:

    In such a case, you have likely hit an illustration of the latter issue
    which the I-pipe/ppc implementation still suffers from: some page table
    entries are missed during real-time operations. As a consequence of
    this, the nucleus catches page faults on behalf of RT threads in primary
    mode, then switches these threads back to secondary in order to process
    the faults, and eventually wire the missing PTEs in. This is something
    calling mlockall() does not prevent the application from (like COW).


Now for my question.
When looking at a situation where you have a system running multiple 
RT-tasks, when one of them hits an (unexpected) switch, it is possible 
that this task will never be switched in again, as the other RT-tasks 
might consume all the processor time.
Would it be possible to have the Nucleus, after the page-fault is 
processed and the "problem" is fixed, automagically switch the system 
back to primary mode?
It is not the real solution to the problem, but it would be a acceptable 
workaround for this moment, until a real solution is available.

Also another question on this issue: at this moment I am using kernel 
2.6.14(ppc), but I saw that there is now an adeos-patch for 
2.6.20(powerpc). Could using this version give an improvement in this 
area, or does this not make a difference?

Kind regards,
    Johan Borkhuis

