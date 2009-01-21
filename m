Message-ID: <49779319.5040500@domain.hid>
Date: Wed, 21 Jan 2009 22:26:49 +0100
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
	<49776313.2090403@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53407D@slcmail.slc.mew.int>
	<49777C1F.4040805@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D53408C@slcmail.slc.mew.int>
	<49779002.5080704@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D534095@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D534095@domain.hid>
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
> After I see init_fpu() called, this is what I see:
> 
> s4r6s4r6s4r6s4r7s4r7s4r6s4r6s4r6s4r6s4r6s4r6s4r6s4r6s4r6s4r6s4r6s4r6s4r6
> s4r6s4r6
> 
> "s4" is printed in xnarch_save_fpu() right after
> if(!wrap_test_fpu_used(task)) where it is false and causes the save
> function to quit
> 
> "r6" is printed in xnarch_restore_fpu() right after if(tcb->cr0_ts)
> evaluates to 1
> 
> "r7" is printed in xnarch_restore_fpu() right after if(tcb->cr0_ts)
> evalutes to 0
> 
> These calls are made from __xnpod_switch_fpu()
> 
> There are no calls to xnarch_enable_fpu()
> 
> It seems to me that we are missing an fpu init, and it seems that
> xnarch_save_fpu() never actually saves because fpu used is never set.

Ok. Please let me some time to try and understand. In the meantime,
could you put a printk in the kernel_fpu_begin function to see if it is
ever called?

-- 
					    Gilles.

