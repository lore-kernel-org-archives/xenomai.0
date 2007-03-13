Message-ID: <e45fe62b0703122328i4be24be3qa98f4f89673da081@domain.hid>
Date: Tue, 13 Mar 2007 11:58:33 +0530
From: "Preetam Joshi" <j.preetam@domain.hid>
Subject: Re: [Xenomai-help] Mach - LPC22xx Support
In-Reply-To: <17906.62022.298174.875008@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_17298_32557130.1173767313601"
References: <e45fe62b0703080135q7ec8865eg8cba0efe20102053@domain.hid>
	<45F00C03.7000604@domain.hid>
	<e45fe62b0703080608i7317ae60v8f261e17851cfd45@domain.hid>
	<45F01E0B.7010908@domain.hid>
	<e45fe62b0703080713x6e6bc227n86d9f026a6cb4015@domain.hid>
	<17906.62022.298174.875008@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_17298_32557130.1173767313601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Gilles,

i would like to know, the behavior of the following structure ! What do the
members imply?

static struct map_desc intcp_io_desc[] __initdata = {
 { IO_ADDRESS(INTEGRATOR_HDR_BASE),   INTEGRATOR_HDR_BASE,   SZ_4K,
MT_DEVICE },
 { IO_ADDRESS(INTEGRATOR_SC_BASE),    INTEGRATOR_SC_BASE,    SZ_4K,
MT_DEVICE },
 { IO_ADDRESS(INTEGRATOR_EBI_BASE),   INTEGRATOR_EBI_BASE,   SZ_4K,
MT_DEVICE },
 { IO_ADDRESS(INTEGRATOR_CT_BASE),    INTEGRATOR_CT_BASE,    SZ_4K,
MT_DEVICE },
 { IO_ADDRESS(INTEGRATOR_IC_BASE),    INTEGRATOR_IC_BASE,    SZ_4K,
MT_DEVICE },
 { IO_ADDRESS(INTEGRATOR_UART0_BASE), INTEGRATOR_UART0_BASE, SZ_4K,
MT_DEVICE },
 { IO_ADDRESS(INTEGRATOR_UART1_BASE), INTEGRATOR_UART1_BASE, SZ_4K,
MT_DEVICE },
 { IO_ADDRESS(INTEGRATOR_DBG_BASE),   INTEGRATOR_DBG_BASE,   SZ_4K,
MT_DEVICE },
 { IO_ADDRESS(INTEGRATOR_GPIO_BASE),  INTEGRATOR_GPIO_BASE,  SZ_4K,
MT_DEVICE },
 { 0xfc900000, 0xc9000000, SZ_4K, MT_DEVICE },
 { 0xfca00000, 0xca000000, SZ_4K, MT_DEVICE },
 { 0xfcb00000, 0xcb000000, SZ_4K, MT_DEVICE },
};

Ur inputs wud be valuable.

Thanks and Regards,

Preetam
On 3/10/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Preetam Joshi wrote:
> > Hi Gilles,
> >            Thanks a lot for your quick response. I am doing the same
> > activity. I am trying to port the xenomai patchfor LPC22xx on uClinux. I
> am
> > getting Undefined references for the symbols in ipipe-core.c,
> ipipe-root.c.
> > So i am trying to map and define the correct values  from those files to
> > LPC22xx related files in arch/arm/mach-lpc22xx and in arch/arm/kernel.
> Is
> > this right thing i am doing? If you have any idea about how to port ,
> Please
> > Let me know. It would be a great help from you.
>
> Yes, you are doing the right thing. A simple way to do it is to have a
> look at other machines. What needs to be written for a new ARM machine is:
> - the hardware timer interrupt handling and timestamp counter emulation,
>   if your timer hardware is based on a decrementer, have a look at the
>   integrator implementation, if your timer hardware is based on a
>   free-running counter with match register, have a look at the PXA
>   implementation;
> - if needed, the GPIOs interrupt demultiplexing, all implemented ARMs so
>   far have this, so have a look at any of them.
>
> --
>
>
>                                             Gilles Chanteperdrix.
>

------=_Part_17298_32557130.1173767313601
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>Hi Gilles,<br><br>i would like to know, the behavior of the following structure ! What do the members imply?<br><br>static struct map_desc intcp_io_desc[] __initdata = {<br>&nbsp;{ IO_ADDRESS(INTEGRATOR_HDR_BASE),&nbsp;&nbsp; INTEGRATOR_HDR_BASE,&nbsp;&nbsp; SZ_4K,&nbsp; MT_DEVICE },
<br>&nbsp;{ IO_ADDRESS(INTEGRATOR_SC_BASE),&nbsp;&nbsp;&nbsp; INTEGRATOR_SC_BASE,&nbsp;&nbsp;&nbsp; SZ_4K,&nbsp; MT_DEVICE },<br>&nbsp;{ IO_ADDRESS(INTEGRATOR_EBI_BASE),&nbsp;&nbsp; INTEGRATOR_EBI_BASE,&nbsp;&nbsp; SZ_4K,&nbsp; MT_DEVICE },<br>&nbsp;{ IO_ADDRESS(INTEGRATOR_CT_BASE),&nbsp;&nbsp;&nbsp; INTEGRATOR_CT_BASE,&nbsp;&nbsp;&nbsp; SZ_4K,&nbsp; MT_DEVICE },
<br>&nbsp;{ IO_ADDRESS(INTEGRATOR_IC_BASE),&nbsp;&nbsp;&nbsp; INTEGRATOR_IC_BASE,&nbsp;&nbsp;&nbsp; SZ_4K,&nbsp; MT_DEVICE },<br>&nbsp;{ IO_ADDRESS(INTEGRATOR_UART0_BASE), INTEGRATOR_UART0_BASE, SZ_4K,&nbsp; MT_DEVICE },<br>&nbsp;{ IO_ADDRESS(INTEGRATOR_UART1_BASE), INTEGRATOR_UART1_BASE, SZ_4K,&nbsp; MT_DEVICE },
<br>&nbsp;{ IO_ADDRESS(INTEGRATOR_DBG_BASE),&nbsp;&nbsp; INTEGRATOR_DBG_BASE,&nbsp;&nbsp; SZ_4K,&nbsp; MT_DEVICE },<br>&nbsp;{ IO_ADDRESS(INTEGRATOR_GPIO_BASE),&nbsp; INTEGRATOR_GPIO_BASE,&nbsp; SZ_4K,&nbsp; MT_DEVICE },<br>&nbsp;{ 0xfc900000, 0xc9000000, SZ_4K, MT_DEVICE },<br>
&nbsp;{ 0xfca00000, 0xca000000, SZ_4K, MT_DEVICE },<br>&nbsp;{ 0xfcb00000, 0xcb000000, SZ_4K, MT_DEVICE },<br>};<br><br>Ur inputs wud be valuable.<br><br>Thanks and Regards,<br><br>Preetam<br><div><span class="gmail_quote">On 3/10/07, 
<b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Preetam Joshi wrote:<br> &gt; Hi Gilles,<br> &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Thanks a lot for your quick response. I am doing the same<br> &gt; activity. I am trying to port the xenomai patchfor LPC22xx on uClinux. I am<br> &gt; getting Undefined references for the symbols in 
ipipe-core.c,&nbsp;&nbsp;ipipe-root.c.<br> &gt; So i am trying to map and define the correct values&nbsp;&nbsp;from those files to<br> &gt; LPC22xx related files in arch/arm/mach-lpc22xx and in arch/arm/kernel. Is<br> &gt; this right thing i am doing? If you have any idea about how to port , Please
<br> &gt; Let me know. It would be a great help from you.<br><br>Yes, you are doing the right thing. A simple way to do it is to have a<br>look at other machines. What needs to be written for a new ARM machine is:<br>- the hardware timer interrupt handling and timestamp counter emulation,
<br>&nbsp;&nbsp;if your timer hardware is based on a decrementer, have a look at the<br>&nbsp;&nbsp;integrator implementation, if your timer hardware is based on a<br>&nbsp;&nbsp;free-running counter with match register, have a look at the PXA<br>&nbsp;&nbsp;implementation;
<br>- if needed, the GPIOs interrupt demultiplexing, all implemented ARMs so<br>&nbsp;&nbsp;far have this, so have a look at any of them.<br><br>--<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix.<br></blockquote>
</div><br>

------=_Part_17298_32557130.1173767313601--

