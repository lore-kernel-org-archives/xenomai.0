Message-ID: <004a01c663c0$7db19ae0$1701a8c0@domain.hid>
From: "Kiichi Kameda" <k-kameda@domain.hid>
References: <009601c662f1$f164e700$1701a8c0@domain.hid> <4443AB94.50508@domain.hid>
Subject: Re: [Xenomai-help] Xenomai port to SH4
Date: Wed, 19 Apr 2006 23:49:41 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-15"
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi,

> If you are looking for real heavy load: cache benchmarks tend to stress
> your system most (e.g. http://www.cwi.nl/~manegold/Calibrator). Combine
> them with heavy i/o load (flood ping etc.).
>
> Anyway, 200 us for a 240 MHz system doesn't sound totally unrealistic.
> But I do not know the sh4 architecture to give a reliable estimation.
>
> What are your numbers when running latency in the other modes, i.e.
> without the need to switch to user space (mode 1, "-t1") or even without
> any context switch at all (mode 2, "-t2")?

The machine is a small embedded device that has various IOs, and I expect
my user space application program runs 1ms periodically.
So jitter is important  when I execute telnet login and run common linux
commands.

By the way,  the latency was improved a little.
I found linux system call handler run with interrupt masked.
By adding the code to enable interrupt to entry.S which is architecture
specific,
 the latency is no more than 150us  on the same conditions as in my last
mail.


Thanks,

Kiichi Kameda


