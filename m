Message-ID: <4CC309B6.8070505@domain.hid>
Date: Sat, 23 Oct 2010 18:13:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1287845650.32319352@domain.hid>
In-Reply-To: <1287845650.32319352@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Very high latencies under stress testing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: edward.robbins@domain.hid
Cc: xenomai@xenomai.org

edward.robbins@domain.hid wrote:
> Forgot to copy the list:
> 
> 
> Okay, so smi.c does not appear to contain my the PCI ID of my LPC
> chip. Motherboard has intel GS45 chipset, and "lspci -nn" says:
> 
> 00:1f.0 ISA bridge [0601]: Intel Corporation ICH9M-E LPC Interface
> Controller [8086:2917] (rev 03)
> 
> Is this what I'm looking for? (What has ISA got to do with this?)

The address of the register used to disable the SMIs is stored in the
PCI configuration space of this PCI peripheral. This address is an
io-port address, so, technically the ISA bus is used to disable the
SMIs. "LPC", means low pin count, which, I think refer to the wayq this
peripheral is wired somewhere.


-- 
                                                                Gilles.

