Message-ID: <49AFE525.2080401@domain.hid>
Date: Thu, 05 Mar 2009 15:43:49 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A01872F90@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A01872F90@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org, wg@domain.hid

roderik.wildenburg@domain.hid wrote:
> On behalf of Thomas I would like to answer : 
> 
>> Do you have CONFIG_XENO_OPT_DEBUG_NUCLEUS enabled in your 
> 
> yes, we can aahhh have this option enabled.
> 
>> kconfig, and if so, do
>> you get any message in your kernel log when running fetest?
> 
> no, no message anywhere (/var/log/messages, console, dmesg).
> fetest runs and runs till I sent CTRL-C.
> 

Gilles sent you a patch affecting include/asm-powerpc/bits/pod.h a few weeks
ago, that fixed an FPU issue. Are you running with this patch applied?

> Roderik
> 
> --------------------------------------------------------
> manroland AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Rall, Paul Steidle   
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht Offenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933
> 


-- 
Philippe.

