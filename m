Message-ID: <4E1DDE43.3030000@domain.hid>
Date: Wed, 13 Jul 2011 20:04:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E1D8389.7050305@domain.hid> <4E1D84FD.7050307@domain.hid>
	<4E1D9A14.5040901@domain.hid>
In-Reply-To: <4E1D9A14.5040901@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Stack size of created task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jakub Nowacki <j.s.nowacki@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 07/13/2011 03:13 PM, Jakub Nowacki wrote:
> As I understand it is related 
> to the amounts of memory being used by a task, which is put on the stack 
> during task switching, am I right?

Not really. When a function starts, it reserves some room on stack,
mainly for local variables that can not be put in registers (because not
enough registers are available, or for other reasons, such as the fact
that the address of the variable needs to be passed to another function).

When this function calls another function, this other function reserves
room on top of the first stack reserved room, hence the name "stack".

The worst case is the highest level, it may be due to too many functions
reserving little space on stack, or to one function reserving too much
room on stack. For most functions, you can easily measure how much they
reserve on stack by looking at their disassembly. I guess there are perl
scripts around to edit a report of the stack usage of each function in a
binary.

-- 
                                                                Gilles.

