Message-ID: <45BE2346.3060700@domain.hid>
Date: Mon, 29 Jan 2007 17:39:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] BUG: unable to handle kernel paging request
References: <1169811995.462.13.camel@domain.hid>	<1169827668.3346.61.camel@domain.hid>	<b647ffbd0701261046m52172774lf5a7b4d08e090583@domain.hid>
	<1170087442.24120.6.camel@domain.hid>
In-Reply-To: <1170087442.24120.6.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Victor Shulyak <V.I.Shulyak@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Victor Shulyak wrote:
> Attached file contains objdump -D of my kernel image with
> __ipipe_handle_exception function.
> 
> 
> How could I locate the faulty routine containing eip=0xc7b84d51?

It is probably the address of a module, so getting the disassembly is a
little bit more complicated: you have to look into /proc/modules for the
load address of the modules. Then pass it to the --adjust-vma option of
objdump.

But you should try Philippe's patch first.

-- 
                                                 Gilles Chanteperdrix

