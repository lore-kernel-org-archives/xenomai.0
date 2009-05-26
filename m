From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <9c789a000905260736t241467ax805c4823b0d58ff5@domain.hid>
References: <9c789a000905250446t78fd6b38x1a6f28e35b70d7d6@domain.hid>
	<878wkkzxba.fsf@domain.hid>
	<9c789a000905251435p6f851d21v617c7e26a971f143@domain.hid>
	<871vqczveh.fsf@domain.hid>
	<9c789a000905251516j5272ae7bpc60aea8fdc17d50c@domain.hid>
	<9c789a000905251532i4775d796x8f095503a203e5bb@domain.hid>
	<72cf3fb0905260655g3e6942c5va7bc032f1cb5f35@domain.hid>
	<9c789a000905260736t241467ax805c4823b0d58ff5@domain.hid>
Content-Type: text/plain
Date: Tue, 26 May 2009 23:48:44 +0200
Message-Id: <1243374524.22014.74.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Driver testing procedure ?!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Cristian Axenie <cristian.axenie@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2009-05-26 at 17:36 +0300, Cristian Axenie wrote:

> Unable to handle kernel paging request for data at address 0x0000001c
> Faulting instruction address: 0xc023923c
> Oops: Kernel access of bad area, sig: 11 [#1]
> MPC831x RDB
> Modules linked in:
> NIP: c023923c LR: c0249c2c CTR: c01bd8b4

Please compile your kernel with CONFIG_DEBUG_INFO enabled. Then, from
the root of your kernel tree, get a disassembly of the entire kernel:

# ppc_6xx-objdump -dl vmlinux > foo.s
(this may take a while)

NIP is the code location your ppc kernel was attempting to execute from
before jumping out of the window, so find the assembly line the NIP
register value points at (leftmost field of the output), and post back
the disassembly of the entire enclosing function. TIA,

-- 
Philippe.



