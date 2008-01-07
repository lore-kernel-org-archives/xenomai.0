Message-ID: <478286F5.4090708@domain.hid>
Date: Mon, 07 Jan 2008 21:09:25 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <f8f856500801070737s2934e741i99717c5b2a2d3d88@domain.hid>
In-Reply-To: <f8f856500801070737s2934e741i99717c5b2a2d3d88@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai latency tests on MPC8xx
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: fabien <fabien.fb@domain.hid>
Cc: xenomai@xenomai.org

fabien wrote:
> Here, there is some xenomai tests on a MPC855T, could you comment
> these results please ?
> Are they correct ?
> 
> # cat cpuinfo
> processor       : 0
> cpu             : 8xx
> clock           : 50MHz
> bus clock       : 50MHz
> revision        : 0.0 (pvr 0050 0000)
> bogomips        : 48.38
> 
> The kernel is a 2.6.23-6 (ppc branch) from DENX git repository,
> Xenomai 2.4.0, and adeo-ipipe patch :
> adeos-ipipe-2.6.23-ppc-1.6-00.patch.
> 
> I'm new in realtime system and xenomai so i have also some questions :
> First, what's the purpose of the cyclic and switchbench test ?

Cyclictest is a POSIX application measuring user space task scheduling
latencies. See also http://rt.wiki.kernel.org/index.php/Cyclictest.

> How could i interpret the results of switchtest ?
> And finaly, it's seem there is something wrong with irqloop test, but what ?

irqloop is not applicable for your hardware as it does not have a
parallel port or a 16550-compatible serial interface. Please check
http://www.rts.uni-hannover.de/xenomai/lxr/source/doc/txt/irqbench.txt.

FYI, I'm currently extending irqbench to work with GPIO port pins,
especially to measure latencies for PowerPC embedded boards.

Wolfgang.

