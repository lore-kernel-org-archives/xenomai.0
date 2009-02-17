Message-ID: <499A8E53.303@domain.hid>
Date: Tue, 17 Feb 2009 10:15:47 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20090217094750.46fb937d@domain.hid>
In-Reply-To: <20090217094750.46fb937d@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] I.MXL won't boot after patching with
	adeos-ipipe-2.6.27-arm-1.12-00.patch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: "gwenhael.goavec" <gwen@domain.hid>
Cc: adeos-main@gna.org

gwenhael.goavec wrote:
> Hello,
> 
> I wish to test adeos and Xenomai on Arm9 I.MXL(MC9328) based
> platform. I have already tested with linux-2.6.26.5 and
> linux-2.6.24.3. Ipipe worked fine and the system has booted
> correctly.
> But with linux-2.6.27.13 and others 2.6.27.XX System
> won't boot. The last message I have is : 
> 
> BIOS> boot                                                                     
> ## Booting kernel from Legacy Image at 100a0000 ...
>    Image Name:   Linux-2.6.27.13                   
>    Created:      2009-02-16  21:03:08 UTC
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    1329204 Bytes =  1.3 MB              
>    Load Address: 08008000               
>    Entry Point:  08008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK                            
>   
> Starting kernel ...
>                    
> Uncompressing
> Linux.......................................................................................
> done, booting the kernel.
> 
> kernel_start() is never called.
> 	
> However, when CONFIG_IPIPE is not active, the system works
> well!
> 
> Do someone have the same problem ?
> What is the solution for having  linux-2.6.27 working
> with this processor ?
> Thank you very much.

What exactly is the support selected in the Linux kernel for this
processor? Could you try the printascii in printk trick to see exactly
where the boot fails?

-- 
                                                 Gilles.

