References: <SN1PR11MB06061A18733A417D16117719D1FB0@SN1PR11MB0606.namprd11.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ac133995-3f6e-a415-3d23-00d0963b456b@xenomai.org>
Date: Wed, 31 Jan 2018 10:06:37 +0100
MIME-Version: 1.0
In-Reply-To: <SN1PR11MB06061A18733A417D16117719D1FB0@SN1PR11MB0606.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] suspending kernel thread
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nihar Unadkat <Nihar@deltatau.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: Henry Bausley <hbausley@deltatau.com>

On 01/31/2018 02:09 AM, Nihar Unadkat wrote:
> Hi 
> 
> I am using ipipe-ipipe-core-4.1.18-arm-9 which is patched with xenomai-2.6.5
> 
> I am getting an error 
> Xenomai: suspending kernel thread 7f8c2cb8 ('xxxx') at 0x7f89d6e8 after exception #0x8
> 
> Where ('xxxx') is our function name.
> 
> So I searched for where this message comes from and  I found it in the file pod.c and the function that is causing this error is 
> 

[snip]

> The only way for me to bypass the error Xenomai: suspending kernel
> thread 7f8c2cb8 ('xxxx') at 0x7f89d6e8 after exception #0x8
> Was to comment out the section given below and everything works ok.

No, it certainly does not. Breaking the thermometer won't make the fever
go away. By commenting out this code, you merely told the rt kernel to
keep going with the execution without fixing up the situation, which is
hardly a good idea. You may want to find out why your in-kernel code
causes an alignment trap in the first place.

> 
> My question are
> 1) What does this function do? 

> /*!
>  * \fn void xnpod_trap_fault(xnarch_fltinfo_t *fltinfo);
>  * \brief Default fault handler.
>  *
>  * This is the default handler which is called whenever an uncontrolled
>  * exception or fault is caught. If the fault is caught on behalf of a
>  * real-time thread, the fault is not propagated to the host system.
>  * Otherwise, the fault is unhandled by the nucleus and simply propagated.
>  *
>  * @param fltinfo An opaque pointer to the arch-specific buffer
>  * describing the fault. The actual layout is defined by the
>  * xnarch_fltinfo_t type in each arch-dependent layer file.
>  *
>  */
>

> 2) why am I getting that error.

As mentioned in the inline documentation and the message issued by the
code you have just quoted, a rt thread running in kernel space received
a fault from the CPU. Specifically, an alignment fault:

#define IPIPE_TRAP_ALIGNMENT	 8	/* Unaligned access exception */

See /proc/xenomai/faults

> 3) What is your advice or suggestion on this.
> 

> Xenomai: suspending kernel thread 7f8c2cb8 ('xxxx') at 0x7f89d6e8
after exception #0x8

The real-time core pointed you at the IP of the offending instruction,
doing unaligned memory accesses. You may want to find out which code is
there by matching this IP with a disassembled output of the kernel
image, and fix it.

-- 
Philippe.

