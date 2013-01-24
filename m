In-Reply-To: <OFC84FDBBF.88E9186F-ON85257AFC.007B4CC3-85257AFC.008309FB@LocalDomain>
References: <OF682F5C70.F8F7AA50-ON85257AF1.005F580A-85257AF1.005F580C@aanddtech.com>	<50F3DD9A.9050306@gmail.com>
	<OF5CF00330.868585F8-ON85257AFA.00801D57-85257AFB.00000E92@aanddtech.com>
	<50FE45E9.1040909@xenomai.org>	<OF518EBAA9.1B02356C-ON85257AFC.00002A9B-85257AFC.00028E23@aanddtech.com>
	<50FF4434.7030405@xenomai.org>
	<CAFVR4DVpsR026fvgybs91iC7-gDLVvBS8wsXBRO0XdzLBcXzpg@mail.gmail.com>
	<50FF8B16.3060100@xenomai.org>
	<OFC84FDBBF.88E9186F-ON85257AFC.007B4CC3-85257AFC.008309FB@LocalDomain>
MIME-Version: 1.0
Message-ID: <OF8154803F.C9215FAE-ON85257AFD.0000A47C-85257AFD.00012766@aanddtech.com>
From: mfornero@aanddtech.com
Date: Wed, 23 Jan 2013 19:12:36 -0500
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: [Xenomai] Porting Ipipe to new ARM SoC (Xilinx Zynq)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai@xenomai.org

Matthew Fornero/AandDTech wrote on 01/23/2013 06:51:17 PM:

> Here's /proc/interrupts on the running system (before xeno_nucleus 
> module is loaded)
> / # cat /proc/interrupts
>            CPU0       CPU1
>  29:        429        161       GIC  twd
>  40:          0          0       GIC  xdevcfg
>  43:          8          0       GIC  xttcpss clockevent
>  45:          0          0       GIC  pl330
>  46:          0          0       GIC  pl330
>  47:          0          0       GIC  pl330
>  48:          0          0       GIC  pl330
>  49:          0          0       GIC  pl330
>  51:          0          0       GIC  e000d000.ps7-qspi
>  53:          0          0       GIC  ehci_hcd:usb1
>  54:        815          0       GIC  eth0
>  56:        465          0       GIC  mmc0
>  72:          0          0       GIC  pl330
>  73:          0          0       GIC  pl330
>  74:          0          0       GIC  pl330
>  75:          0          0       GIC  pl330
>  82:         43          0       GIC  xuartps
> IPI0:          0          0  Timer broadcast interrupts
> IPI1:       1425       1551  Rescheduling interrupts
> IPI2:          0          0  Function call interrupts
> IPI3:         50         49  Single function call interrupts
> IPI4:          0          0  CPU stop interrupts
> Err:          0
> 
> Things of note:
> twd is the (per cpu) timer used by the ipipe
> xttcpss is a triple timer counter within the SoC, which appears to 
> only be used until the twd timer is setup-- this timer is *not* 
> ported to the Ipipe, which I assumed was okay because the twd is 
> used-- is this assumption correct?

Looking over the iMX6 ipipe code, I'm guessing maybe I need to do the 
ipipe porting for the xttcpss timer? The iMX6 is a Cortex-A9 processor 
that uses the twd timer in SMP mode, but it looks like the mxc timer is 
also registered with ipipe regardless of SMP mode.

Best Regards,

Matthew Fornero
