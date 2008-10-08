Message-ID: <48EC86BE.3010308@domain.hid>
Date: Wed, 08 Oct 2008 12:09:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <296620.67855.qm@domain.hid>
In-Reply-To: <296620.67855.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] trap exceptions in user
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gabriele Moabiti <gabmoa@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Gabriele Moabiti wrote:

Please do not drop the list from the CC.

> The asm x86 code is a "legacy" code developed in x86 plain binary asm
> (written with tasm and can't be re-written of course)

I do not understant the "of course". If this is assembly, then run a
disassembler and you will get the source.

> with fixed addresses for data and code (I'll call SIS in the follow).
>  When one of the follow exception occurred
> 
>      *  0x00    Divide by zero
>      *  0x01    Debug exception
>      *  0x03    Int3
>      *  0x04    Overflow
>      *  0x05    Array bounds check
>      *  0x06    Illegal Opcode
>      *  0x07    FPU not available
>      *  0x08    Double fault
>      *  0x09    Coprocessor segment overrun
>      *  0x0a    Invalid task state
>      *  0x0b    Segment not present
>      *  0x0c    Stack exception
>      *  0x0d    General Protection Fault
>      *  0x0e    Page fault
>      *  0x0f    Reserved
>      *  0x10    Coprocessor error
> 
> SIS expects some custom actions (set internal flags, save errors and so on).
> 
> I have mapped SIS in a kernel module and mapped to user space with xenomai.
> Now I though to execute SIS in ring 3 (as rt task) and trap the exceptions at ring 0 (always inside real time constraints).
> 
> The result should be
> 
> <C code>
> <set custom exceptions>
> <SIS code>
> <set default exceptions>
> <C code>
> 
> In the "C code" part I'll use rtnet.

I think you are traping yourself with impossible constraints.

Anyway, the only way is register a custom exception handler using rthal
functions. In your trap handler, you may wake up a user-space server
thread which role is to handle exceptions (in user-space). This means that:
- upon exception, you have a switch to the user-space server thread
context, this will be slow;
- you have to rewrite the exception handling code, you can not rely
on the exception handling code that was written in the assembly blob.

I do not think it is a good idea to simply override the exception
vectors, the kernel uses them, and you certainly want the kernel to
continue working.

-- 
                                                 Gilles.

