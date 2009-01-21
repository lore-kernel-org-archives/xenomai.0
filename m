Message-ID: <49775759.2090505@domain.hid>
Date: Wed, 21 Jan 2009 17:11:53 +0000
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
	<497751E3.3020301@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53405D@slcmail.slc.mew.int>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D53405D@slcmail.slc.mew.int>
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
>> __xnpod_init_fpu is for kernel-space thread. For user-space threads,
>> the
>> FPU initialization happens either in Linux code if the fault happens
> in
>> secondary mode, or in the fault handler if it happens in primary mode.
> 
> Interesting. Shouldn't rt_task_spawn() start up in primary mode even if
> it's called in user space? Is it normal to start in secondary mode? I
> know std::cout will migrate to secondary, but I do my fpu stuff before
> that.

When you first use fpu in primary mode, a fault happen, is trapped in
ksrc/nucleus/pod.c and directly calls xnarch_init_fpu, not
__xnpod_init_fpu. Now, the fact that xnarch_init_fpu is not called may
indeed be your problem, but we have to know exactly what happens before
to understand why this happens.

-- 
                                                 Gilles.

