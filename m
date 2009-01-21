Message-ID: <49776313.2090403@domain.hid>
Date: Wed, 21 Jan 2009 18:01:55 +0000
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
	<49775759.2090505@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D534064@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D534064@domain.hid>
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
> I have your output and it is repeatable every tiem.
> 
> Good case:
> 
> i387.c init_fpu()
> 
> xnarch_save_fpu() enters and takes the following path:
> 
> if(!tcb->is_root)
> if(task)
> if(!wrap_test_fpu_used(task)) return;
> 
> then, I see xnarch_restore_fpu take the following path:
> 
> tcb->is_root is set to 1, so it goes to else
> tcb->cr0_ts is true, so it calls stts() and returns;
> 
> bad case:
> 
> all the same, except tcb->cr0_ts is false. It leaves that if block,
> calls clts(), and then frstor instruction is called because I don't have
> fxsr
> 
> Is this helpful?
> 
> There are no calls to xnarch_enable_fpu or xnarch_init_fpu

Errr. Some things are missing, this is only one context switch (probably
the last ?). I would be interested in all the context switches since the
beginning of the process (hopefully, there should not be too much of them).

-- 
                                                 Gilles.

