Message-ID: <50FF1249.2070807@xenomai.org>
Date: Tue, 22 Jan 2013 23:27:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAD1EtogQBZ5f=7w5mZz19rrnQVB_BP=t-f4rKtq12wKn9cd1Yw@mail.gmail.com>
In-Reply-To: <CAD1EtogQBZ5f=7w5mZz19rrnQVB_BP=t-f4rKtq12wKn9cd1Yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] x86 Linux with xenomai and i915 graphics stall
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Cc: xenomai@xenomai.org

On 01/22/2013 11:23 PM, Daniel M. Drucker, Ph.D. wrote:

> Hi Gilles et al.,
> 
>> That is unusual, a typical latency on x86 is under 50us (and this is a
>> conservative bound). In order to investigate this, enable the I-pipe
>> tracer in the kernel configuration and run latency -f. Also set the
>> number of backtrace points to a large value, say 1000 or 10000 and post
>> the trace here.
> 
> Here is the trace before running glxgears. The worst latency is 32us.
> 
> https://gist.github.com/raw/4599095/203ce77b2bb8e1b2c797302d33ce1a7b0a18fbac/gistfile1
> 
> And here is the trace while running glxgears. The worst latency is 724us.
> 
> https://gist.github.com/raw/4599099/27054c46f246999375346ed942f76d0757c4fa0a/gistfile1


And you are sure that it is not an SMI issue? Could you post your kernel
configuration?

-- 
                                                                Gilles.

