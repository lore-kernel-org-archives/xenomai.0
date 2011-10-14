Message-ID: <4E986EEA.40303@domain.hid>
Date: Fri, 14 Oct 2011 19:18:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2157_1308732935_4E01AE07_2157_14293_1_ECB646CBB62FD044927FDEDF0252D3E701E388AD6F15@domain.hid>
	<loom.20111014T181950-390@domain.hid>
In-Reply-To: <loom.20111014T181950-390@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.5.6 and 2.6.38.8 kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kunal Anand <erkunalanand@domain.hid>
Cc: xenomai@xenomai.org

On 10/14/2011 06:32 PM, Kunal Anand wrote:
> Case I:
> Linux kernel Src tree 2.6.38.8
> Xenomai Patch 2.5.6
> adeos-ipipe-2.6.38.8-x86-2.10-00.patch
> 
> I first faced the error faced above of the 
> UNDECLARED VARIABLES
> So i declared it myself as 
> "int nmi_watchdog =0" and same for the other.

You need to apply the patch which was posted in reply to Nicolas' mail.

> 
> [AS ABOVE]
> 
> It got compiled and installed but on boot-up it showed 
> " system init fail, code -19
> native skin init fail, code -19..." 
> and same message for POSIX skin and RTDM skin.
> 
> NO IDEA HOW TO SOLVE THIS!!

Read the kernel logs. If you see "Xenomai: Local APIC absent or
disabled", read the TROUBLESHOOTING guide, at the top of Xenomai kernel
sources.

> 
> CASE II:
> 
> I tried following Uwue and used a 
> previous kernel and same xenomai patch with
> the adeos patch for that particular
>  kernel but now it is giving me error in the
> same function but the error is 
> concerning a ")" near the declaration of the
> nmi_watchdog and NMI_IO_APIC.

See first answer.

-- 
					    Gilles.

