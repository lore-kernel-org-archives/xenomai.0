Date: Tue, 25 Jan 2011 11:15:27 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4D3E9D71.7040008@domain.hid>
Message-ID: <alpine.DEB.1.10.1101251103490.12329@domain.hid>
References: <alpine.DEB.1.10.1101251010320.12329@domain.hid>
	<4D3E97D5.3050609@domain.hid>
	<alpine.DEB.1.10.1101251049460.12329@domain.hid>
	<4D3E9D71.7040008@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] NULL pointer access on bfin when linking with
 xenomai and pthread
Reply-To: xenoka09@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

> First, you should print the stack pointer, and cat /proc/$pid/map while
> the process is stopped inside gdb, to see if you would not have a stack
> overflow.

(gdb) info registers
...
p5             0x15e8b40	0x15e8b40
sp             0x13bd330	0x13bd330
fp             0x13bd340	0x13bd340
...

cat /proc/$pid/maps says

...
013a0000-013c0000 rw-p 00000000 00:00 0          [stack]
...

So I assume the SP is okay

> If not, recompile xenomai with --enable-debug, try and put a breakpoint

I'll do. For now thanks for the good tips up to here!

Kolja


