Message-ID: <44252103.2010604@domain.hid>
Date: Sat, 25 Mar 2006 11:52:51 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] gdb and heaps
References: <1143279446.13244.257499314@domain.hid>
In-Reply-To: <1143279446.13244.257499314@domain.hid>
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
To: Alessandro Pittaluga <xpit@domain.hid>
Cc: xenomai@xenomai.org

Alessandro Pittaluga wrote:
> Hi,
> 
> When trying to access with gdb to variables allocated on a shared heap,
> the following message is returned:
> (gdb) print mypointer
> $5 = (MYTYPE *) 0xb7dc4020
> (gdb) print *mypointer
> Cannot access memory at address 0xb7dc4020
> 
> All the applications (kernel and userland) are accessing correctly to
> the  heap-allocated memory. 
> 
> Is this the expected behaviour or there's something wrong in my
> installation?
>

Your installation is correct, GDB and Xenomai are too; unfortunately, 
the following explanation is still accurate, i.e. a restriction in the 
ptrace support:
http://sourceware.redhat.com/ml/gdb/2004-01/msg00152.html

Since you can call routines inside your program from the GDB cli, the 
best solution at hand would be to implement the suggestion found in this 
post: e.g.

void print_heap (void)
{
	... output the heap contents...
}

and,

(gdb) call print_heap()

You could even pass arguments to print_heap() for customizing your output.

A possible option to work around that would be to stop having heaps 
marked as I/O regions though, but the kernel-provided remapping helper 
we use currently forces this property. I'll look at this when time allows.

> Many Thanks
> Alessandro


-- 

Philippe.

