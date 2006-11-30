Subject: Re: [Xenomai-core] [RFC] Xenomai examples repository
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <456E122F.5030406@domain.hid>
References: <456D6451.3030705@domain.hid> <1164824900.4973.262.camel@domain.hid>
	<456E122F.5030406@domain.hid>
Content-Type: text/plain
Date: Thu, 30 Nov 2006 19:12:52 +0100
Message-Id: <1164910373.4952.34.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, xenomai-core <xenomai@xenomai.org>

On Thu, 2006-11-30 at 00:05 +0100, Jan Kiszka wrote:

[...]

> To give it a start (and finally establish the infrastructure), I
> copied/reformatted some existing examples and created a simple,
> self-contained build system around them. The directory structure would
> be as I suggested:
> 
> /examples/native/...
> /examples/posix/...
> /examples/...
> /examples/rtdm/generic/...
> /examples/rtdm/serial/...
> /examples/rtdm/...
> 
> I derived a generic Makefiles from my own one for tests (which was in
> turn derived from previous work by Hannes Mayer). It can compile a given
> list of user space applications and kernel modules (2.4 and 2.6) 

The 2.4 section looks x86-dependent. Compiling out-of-tree modules with
2.4 over ppc would require a bit more magic to find the actual flags
needed.

> against
> some Xenomai installation (make XENO=..., unless xeno-config is already
> in $PATH) or a Xenomai-kernel (make KSRC=...). Moreover, there is simple
> Makefile under /examples just to kick building/cleaning of all subdirs
> at once.
> 
> If it's OK for everyone, I would check this into trunk. We could then
> migrate existing demo code and snippets over and add new stuff as it
> pops up, both hopefully with the help of interested users.

Ok, let's merge this.

-- 
Philippe.



