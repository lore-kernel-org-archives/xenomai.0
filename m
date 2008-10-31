Message-ID: <490B32EF.8050503@domain.hid>
Date: Fri, 31 Oct 2008 17:31:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <857546.30206.qm@domain.hid>
In-Reply-To: <857546.30206.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] floating point (int 16) exception
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gabriele Moabiti <gabmoa@domain.hid>
Cc: xenomai@xenomai.org

Gabriele Moabiti wrote:
> Scenario: Xenomai 2.4.5, kernel 2.6.24-7 (x86) I have successfully
> trapped and restored int #0 (it is not reported in the example). Now
> I want to trap fpu exceptions (#16) of a Xenomai user task (ring 3).
> 
> xfpu_xcpt.c -> kernel module used to intercept and manage fpu (#16)
> exceptions. xfpu_user.c -> xenomai user task
> 
> The easiest way (it will not be so easy the final fpu exception
> manager of course!) to do this I knows was to do an fnclex but the
> example doesn't work (it hangs shortly). I have tried *many*
> solutions but nothing works. I think the problem is I can't do a
> simple fnclex but I can't figure how to solve the problem.

No, simply doing an fnclex will not do the trick.

If you do not know the details of Xenomai and Linux FPU handling on x86,
I advise you to let xenomai handle the fault, it does it without
switching to secondary mode, so, you can use it. I do not want to
explain you how it works because it is rather hairy, so, the only way to
understand, if you really want to, is to read the xenomai and linux
relevant sources.

-- 
                                                 Gilles.

