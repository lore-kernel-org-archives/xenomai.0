MIME-Version: 1.0
Date: Tue, 22 Jan 2013 17:23:36 -0500
Message-ID: <CAD1EtogQBZ5f=7w5mZz19rrnQVB_BP=t-f4rKtq12wKn9cd1Yw@mail.gmail.com>
From: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] x86 Linux with xenomai and i915 graphics stall
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Gilles et al.,

> That is unusual, a typical latency on x86 is under 50us (and this is a
> conservative bound). In order to investigate this, enable the I-pipe
> tracer in the kernel configuration and run latency -f. Also set the
> number of backtrace points to a large value, say 1000 or 10000 and post
> the trace here.

Here is the trace before running glxgears. The worst latency is 32us.

https://gist.github.com/raw/4599095/203ce77b2bb8e1b2c797302d33ce1a7b0a18fbac/gistfile1

And here is the trace while running glxgears. The worst latency is 724us.

https://gist.github.com/raw/4599099/27054c46f246999375346ed942f76d0757c4fa0a/gistfile1

Thanks,
Daniel and Andy

