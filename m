From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17989.60118.643971.157109@domain.hid>
Date: Sat, 12 May 2007 18:27:02 +0200
In-Reply-To: <707424.14519.qm@domain.hid>
References: <1178726712.11688.26.camel@domain.hid>
	<707424.14519.qm@domain.hid>
Subject: Re: [Xenomai-core] PPC context switch
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: somshekar kadam <som_kadam@domain.hid>
Cc: xenomai@xenomai.org

somshekar kadam wrote:
 > Hi, 
 > 
 > I was understanding the context switch code of
 > Xenomai-2.3.0 for PPC, I got the point that once it
 > enters rthal_thread_switch , xnarch_thread_trampoline
 > function is executed, register 15 holds this address
 > of this function and register 2 holds the
 > rthal_thread_trampoline function, 
 > what I am not able to understand is how does
 > rthal_thread_switch function is called, 

rthal_thread_switch is called by xnarch_switch_to, which, in turn is
called when the scheduler decides that the task (the newly created one,
in this case) shoudl run.

 > 
 > I understand from rthal_thread_trampoline
 > xnarch_thread_trampoline is called by jumping to
 > function using mtlr and in link register has the
 > address of xnarch_thread_trampoline stored in reg 15
 > and uses blr to jump to it and executes new thread. 
 > 
 > what I dont understand is how it excutes
 > rthal_thread_trampoline, may be some pointers on this,

xnarch_init_thread prepares the stack and registers of the newly created
task so that rthal_thread_switch does the right thing. Perhaps Philippe
or Wolfgang will be able to give more details.


-- 


					    Gilles Chanteperdrix.

