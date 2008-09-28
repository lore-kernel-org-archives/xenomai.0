Message-ID: <48DF9543.8010608@domain.hid>
Date: Sun, 28 Sep 2008 16:31:31 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48D6A80F.1080206@domain.hid> <48D75663.8000402@domain.hid>
	<48D7BA7F.6030801@domain.hid>
In-Reply-To: <48D7BA7F.6030801@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Handle SIGILL when kernel compiled without
	Xenomai.
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>> Gilles Chanteperdrix wrote:
>>> Hi,
>>>
>>> on some (all ?) platforms, we get a SIGILL when trying to emit the first 
>>> Xenomai syscall, instead of the -ENOSYS return value. This patches 
>>> handles the SIGILL by printing an error message and exiting.
>>>
>> This is an issue for archs that encode the syscall number into the trap opcode
>> like ARM using the OABI, others will get -ENOSYS as expected, so this should
>> move to the arch-specific code.
> 
> Actually, I get a SIGILL on ARM compiled with EABI as well.

It seems the ARM folks decided to send SIGILL with EABI to conform to the OABI
behaviour, despite they did not formally need that. Only invalid calls in the
9f00xx..9f07ff range are expected to return -ENOSYS. Too bad that our syscall
marker is out of that range.

 Moving this
> code to the arch dependent code looks hard, since we need to setup the
> jump buffer in the very function which issues the syscall (Ok, we could
> use a macro). But what would you think of a SIGILL handler which does
> not longjmp (like Jan suggested, simply print an error message and exit,
> even if xeno_bind_skin_opt was called) ?
> 

Fine with me.

-- 
Philippe.

