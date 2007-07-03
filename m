Message-ID: <468A1265.4000608@domain.hid>
Date: Tue, 03 Jul 2007 11:09:57 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <4688E0BD.40709@domain.hid>	 <1183377266.19565.14.camel@domain.hid>
	<4689092B.6020903@domain.hid>
	<1183387687.19565.56.camel@domain.hid>
In-Reply-To: <1183387687.19565.56.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Switch to secondary mode
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

Again, thank you for very extensive answer. It is starting to get 
clearer what is happening here but I still have some questions.

The first one is probably an easy one: what do you mean by COW? I did 
try to find what this means, but I was only able to find references to 
farm animals..... (and some references to lazy linking etc. but there 
COW was also not explained).

Philippe Gerum wrote:
> On Mon, 2007-07-02 at 16:18 +0200, Johan Borkhuis wrote:
>   
>> Philippe,
>>
>> Philippe Gerum wrote:
>>     
>>> Late binding to functions performed on behalf of the dynamic loader
>>> against shared libraries shall need the kernel during symbol resolution
>>> (internal syscalls) or execution (e.g. demand loading, COW), hence the
>>> switch. Unfortunately, the I-pipe patch for PPC does not support
>>> disabling all on-demand memory mappings for selected Linux tasks (only
>>> the x86 and ARM patches support this feature so far).
>>>   
>>>       
>> Thank you for you answer.
>>
>> Just for me to make sure I understand this correctly:
>> We are not using shared libraries for our application, our applications 
>> are linked against .a files, which are included in the final application
>>     
>
> In such a case, you have likely hit an illustration of the latter issue
> which the I-pipe/ppc implementation still suffers from: some page table
> entries are missed during real-time operations. As a consequence of
> this, the nucleus catches page faults on behalf of RT threads in primary
> mode, then switches these threads back to secondary in order to process
> the faults, and eventually wire the missing PTEs in. This is something
> calling mlockall() does not prevent the application from (like COW).
>   
As some PTE's are missed, does this mean that not the complete program 
was loaded into memory?

What I understand until now about this process is the following:
The program is executed. Not everything is loaded into memory by the 
dynamic loader. As the functions that are not in memory are accessed a 
page fault is created, and the page is made available. (Or is the page 
already in memory, but not made available to the application?)
Is my assumption correct that once a page is accessed mlockall will take 
care that this page stays active, or is it possible that the page is 
moved out, and that another page fault occurs for the same page?

> .....
>   
> That is expected. If you switch the nucleus debug option on, you should
> see Xenomai whining about secondary mode switches from code locations in
> kernel space. This would confirm the fact that you have been hitting
> this problem.
>   

When looking at the nucleus debug output, I see a number of switches 
coming from user space, like this one:

Jul  3 06:51:10 MVME3100-198 kernel: Xenomai: Switching testTask to 
secondary mode after exception #1025 from user-space at 0x10005f2c (pid 
1069)

I did try to find what exception 1025 is, but I could not find this 
reference. I expect indeed that this is a page-fault, but I am not sure.
The location 0x10005f2c is the start of a function in one of the 
statically linked objects from one of our archives. You are referring to 
kernel space, but these exceptions are generated from user space. Is 
this different from what you are referring to?
> There is not much to be done except improving the I-pipe/ppc support so
> that it provides a way to pin down any PTE an application might refer
> to. There might be other related issues beyond this one though.
> Fortunately, mode transitions for dealing for such faults normally don't
> lead to bad latencies on this arch. Do you confirm that, or are you
> unlucky regarding this?
>   

As this would normally happen only on startup it is not such a big deal. 
After the first couple of cycles this should not occur anymore, so 
operational RT performance is not compromised.
The only problem is that the application switches to secondary mode, and 
that I have to switch it back to primary mode manually (or by doing a 
Xenomai system call). Is there a possibility to automatically switch 
back to primary mode when such a fault occurs?

I would expect that this problem was popping up on other ppc platforms 
as well, but I did not find references to this. Is this something that 
specific to this architecture, this platform, or are other people just 
ignoring this problem?

And now for some personal thoughts.
To be honest, I am a bit surprised by this problem (but that is caused 
by my lack of knowledge in this area).
I am running this on a system without swap and with CONFIG_SWAP disabled 
in the kernel. My applications are linked statically (ldd gives: "not a 
dynamic executable"), so I would expect that everything is available in 
memory. But it looks like there are some things going on below the 
surface that I am not aware of (but that I am curious to find out).

Kind regards,
    Johan Borkhuis

