Date: Fri, 11 May 2007 10:32:38 +0100 (BST)
From: somshekar kadam <som_kadam@domain.hid>
In-Reply-To: <1178726712.11688.26.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <707424.14519.qm@domain.hid>
Subject: [Xenomai-core] PPC context switch
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hi, 

I was understanding the context switch code of
Xenomai-2.3.0 for PPC, I got the point that once it
enters rthal_thread_switch , xnarch_thread_trampoline
function is executed, register 15 holds this address
of this function and register 2 holds the
rthal_thread_trampoline function, 
what I am not able to understand is how does
rthal_thread_switch function is called, 

I understand from rthal_thread_trampoline
xnarch_thread_trampoline is called by jumping to
function using mtlr and in link register has the
address of xnarch_thread_trampoline stored in reg 15
and uses blr to jump to it and executes new thread. 

what I dont understand is how it excutes
rthal_thread_trampoline, may be some pointers on this,
as I am designing the MIPS context switch code for
threads port for xenomai. 

Thanks In advance 
Neelu



      Office firewalls, cyber cafes, college labs, don't allow you to download CHAT? Click here: http://in.messenger.yahoo.com/webmessengerpromo.php

