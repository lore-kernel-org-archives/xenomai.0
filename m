Message-ID: <4C06953D.90003@domain.hid>
Date: Wed, 02 Jun 2010 19:30:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C0692A9.2080806@domain.hid>
In-Reply-To: <4C0692A9.2080806@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC] Break out of endless user space loops
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>, Tschaeche IT-Services <services@domain.hid>

Jan Kiszka wrote:
> Hi all,
> 
> here is the first apparently working prototype for getting hold of
> endless user space loops in RT threads. A simple test case of mine now
> receive a SIGDEBUG even if it does "while (1);".
> 
> The design follows Gilles' suggestion to force a SEGV on victim thread
> but restore the patched PC before migrating the thread after this fault.
> The only drawback of this approach: We need to keep track of the
> preempted register set at I-pipe level. I basically replicated what
> Linux does these days as well and exported it as ipipe_get_irq_regs()
> (the second patch).

You already have the regs in xnarch_fault_info.

-- 
					    Gilles.

