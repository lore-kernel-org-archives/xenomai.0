Message-ID: <529C4FAA.9080502@xenomai.org>
Date: Mon, 02 Dec 2013 10:15:22 +0100
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

For some reason, it looks like the program flow jumps to a weird 
location. Assuming this backtrace is right, the last location that would 
make sense seems to be frame #1 at 0x0ff98534 in libpthread_rt.so.1, 
which is Xenomai's POSIX interface library.

- could you please make a full disassembly of libpthread_rt.so.1 
accessible via pastebin?

- we already had these kinds of events a couple of times on different 
architectures with new gcc releases due to, either broken TLS code 
generation by gcc, or some weaknesses in our inline syscall trampoline 
code with respect to expressing constraints. Is --with-__thread enabled 
when configuring the Xenomai build for libaries and programs?

-- 
Philippe.

