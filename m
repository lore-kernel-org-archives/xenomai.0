Message-ID: <497751E3.3020301@domain.hid>
Date: Wed, 21 Jan 2009 16:48:35 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D533F9A@slcmail.slc.mew.int>
	<49757B25.8020500@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D533FB0@domain.hid>
	<4975E491.1040506@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D533FB6@domain.hid>
	<4975E612.9040708@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D534028@domain.hid>
	<4976EABD.3060505@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D534053@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D534053@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] fpu issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> In pod.c:
> 
> __xnpod_init_fpu() is not called ever. However, init_fpu is called once
> in i387.c

__xnpod_init_fpu is for kernel-space thread. For user-space threads, the
FPU initialization happens either in Linux code if the fault happens in
secondary mode, or in the fault handler if it happens in primary mode.

> 
> After the program runs, __xnpod_giveup_fpu is called twice (remember, I
> have two threads)
> 
> __xnpod_release_fpu() never called
> 
> I can't put a printk in __xnpod_switch_fpu() because it freezes
> (continues to print forever)

Which is why I suggested printing only if !strcmp(current->comm,
"double_test"), and why you should stop double_test as soon as you
detect an error. Furthermore, what interest me is what branches are
taken in the various ifs found in xnarch_save_fpu, xnarch_restore_fpu,
xnarch_enable_fpu.

-- 
                                                 Gilles.

