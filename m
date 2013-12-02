Message-ID: <529C59D2.3030703@xenomai.org>
Date: Mon, 02 Dec 2013 10:58:42 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20131128143152.04ac3eab.norbert.bukuli@mediso.hu>	<5297BD30.4060007@xenomai.org>	<20131129094157.3d7202e1.norbert.bukuli@mediso.hu>	<52985E94.4070101@xenomai.org>	<20131129225320.5327838040F@gemini.denx.de>
 <20131202095057.175411b7.norbert.bukuli@mediso.hu>
In-Reply-To: <20131202095057.175411b7.norbert.bukuli@mediso.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] test suite programs crash with Illegal instruction on
 MPC5200
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bukuli Norbert <norbert.bukuli@mediso.hu>, Wolfgang Denk <wd@denx.de>
Cc: Xenomai <xenomai@xenomai.org>

On 12/02/2013 09:50 AM, Bukuli Norbert wrote:
>
>
> On Fri, 29 Nov 2013 23:53:20 +0100
> Wolfgang Denk <wd@denx.de> wrote:
>> Dear Philippe Gerum,
>>
>> In message <52985E94.4070101@xenomai.org> you wrote:
>>> On 11/29/2013 09:41 AM, Bukuli Norbert wrote:
>>>> (gdb) cont
>>>> Continuing.
>>>> warning: Could not load shared library symbols for
>>>> linux-vdso32.so.1. Do you need "set solib-search-path" or "set
>>>> sysroot"? warning: .dynamic section for
>>>> "/opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libpthread_rt.so.1"
>>>> is not at the expected address (wrong library or version
>>>> mismatch?) warning: .dynamic section for
>>>> "/opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libxenomai.so.0"
>>>> is not at the expected address (wrong library or version
>>>> mismatch?)
>>>
>>> These warnings may trigger with recent broken gdbserver releases,
>>> let's ignore them.
>>
>> I don't think this is a good idea.  The actual problem is in the
>> previous warning:
>>
>> warning: Could not load shared library symbols for linux-vdso32.so.1.
>> Do you need "set solib-search-path" or "set sysroot"?
>>
>> You must set solib-search-path.
>
> As Philippe Gerum asked it, I have used the Xenomai libraries provided
> by the ELDK 5.4 and kept my kernel. In the following test I set the
> solib-search path and the sysroot properly, however the
> powerpc-linux-gdb was unable to find linux-vdso32.so.1. I installed it
> from the kernel with vdso_install but it creates
> only /lib/modules/3.8.13/vdso/vdso32.so file.
>
> What is the proper way to make the gdb know the linux-vdso32.so.1 file?
> Shall I create a simlink to the vdso32.so file?
>
> Anyway, after I created the simlink on the target system like this :
> root@generic-powerpc:/lib# ln -s /lib/modules/3.8.13/vdso/vdso32.so linux-vdso32
>
> and on the host system like this:
> # cd $(POWERPC-SYSROOT)/lib/modules/3.8.13/vdso
> # ln -s vdso32.so linux-vdso32.so.1
>
> gdb found all libraries. However, there is no debugging info in the shared libraries, but I think the disassembled code around the crash point will be sufficient.
>
> GDB output (irrelevant parts are removed):
> $ powerpc-linux-gdb usr/xenomai/bin/powerpc-linux-clocktest
> ...
> Reading symbols from /srv/tftpboot/172.31.2.11/usr/xenomai/bin/powerpc-linux-clocktest...(nodebugging symbols found)...done.
>
> (gdb) set solib-search-path "/srv/tftpboot/172.31.2.11/lib/:/srv/tftpboot/172.31.2.11/usr/lib/:/srv/tftpboot/172.31.2.11/usr/xenomai/lib/:/srv/tftpboot/172.31.2.11/lib/modules/3.8.13/vdso/
> (gdb) set sysroot /opt/eldk-5.4/powerpc/sysroots/powerpc-linux
>
> (gdb) target remote 172.31.2.11:2001
> Remote debugging using 172.31.2.11:2001
> Reading symbols from /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/ld.so.1...Reading symbols from /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/.debug/ld-2.17.so...done.
> done.
> Loaded symbols for /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/ld.so.1
> 0x0ffd76e8 in ?? ()
>
> (gdb) cont
> Continuing.
> [New Thread 338]
>
> Program received signal SIGILL, Illegal instruction.
> [Switching to Thread 338]
> 0x4800ce74 in ?? ()
>
> (gdb) bt
> #0  0x4800ce74 in ?? ()
> #1  0x0ff98534 in ?? ()
> #2  0x0fe17a68 in ?? ()
> #3  0x480eba4c in ?? ()
>
> (gdb) info sharedlibrary
>  From        To          Syms Read   Shared Object Library
> 0x00001ff0  0x0001b014  Yes         /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/ld.so.1
> 0x00100360  0x00100648  No          /srv/tftpboot/172.31.2.11/lib/modules/3.8.13/vdso/linux-vdso32.so.1
> 0x0ff979b4  0x0ff9e948  No          /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libpthread_rt.so.1
> 0x0ff6fba0  0x0ff731d0  No          /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/usr/xenomai/lib/libxenomai.so.0
> 0x0fe14b84  0x0fe233fc  No          /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/libpthread.so.0
> 0x480225c0  0x48135844  No          /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/libc.so.6
> 0x0fdf1a94  0x0fdf599c  No          /opt/eldk-5.4/powerpc/sysroots/powerpc-linux/lib/librt.so.1
>
> (gdb) disass $pc-64,$pc+20
> Dump of assembler code from 0x4800ce34 to 0x4800ce88:
>     0x4800ce34:	.long 0x3894
>     0x4800ce38:	twi     31,r22,-18268
>     0x4800ce3c:	.long 0x80
>     0x4800ce40:	vaddfp  v16,v0,v0
>     0x4800ce44:	.long 0x19fb
>     0x4800ce48:	twi     31,r18,-26168
>     0x4800ce4c:	.long 0xa0
>     0x4800ce50:	vaddfp  v16,v0,v0
>     0x4800ce54:	.long 0x2742
>     0x4800ce58:	twi     31,r18,14172
>     0x4800ce5c:	.long 0x4c
>     0x4800ce60:	subfic  r16,r0,10
>     0x4800ce64:	.long 0x378a
>     0x4800ce68:	twi     31,r19,-31924
>     0x4800ce6c:	.long 0x58
>     0x4800ce70:	vaddfp  v16,v0,v0
> => 0x4800ce74:	.long 0x5a3e
>     0x4800ce78:	twi     31,r18,10348
>     0x4800ce7c:	.long 0x68
>     0x4800ce80:	vaddfp  v16,v0,v0
>     0x4800ce84:	.long 0x80e
> End of assembler dump.
>

While we are at it, could please you paste-bin a larger disassembly ( 
$pc-256, $pc + 256) of frame #1, just below this one? I'd like to see 
the call site.

Also, could you paste-bin the disassembly of libxenomai.so?

TIA,

-- 
Philippe.

