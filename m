Message-ID: <2ff1a98a0710090232x2c671b0fu785d9f453c1d16a@domain.hid>
Date: Tue, 9 Oct 2007 11:32:59 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <305035a40710090209r3015b12fr84d11d3d29996fcc@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <515338.44993.qm@domain.hid>
	<80b317760709110456k2ef95162t19d833da7c5781de@domain.hid>
	<46E699C6.80609@domain.hid>
	<305035a40709140817q452ca77dude2af88ce6fc3dd9@domain.hid>
	<18186.42065.560821.557825@domain.hid>
	<305035a40710082339t16c75581sd07c7f05ed7df9c2@domain.hid>
	<18187.11479.59369.746670@domain.hid>
	<305035a40710090103n7f14377ema39ed8aab42207a6@domain.hid>
	<2ff1a98a0710090146h2684608bjc4d7b91ed7cc0d95@domain.hid>
	<305035a40710090209r3015b12fr84d11d3d29996fcc@domain.hid>
Subject: Re: [Xenomai-core] RTOS porting on ARM
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gregory CLEMENT <gclement00@domain.hid>
Cc: xenomai@xenomai.org

On 10/9/07, Gregory CLEMENT <gclement00@domain.hid> wrote:
> 2007/10/9, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> > You had latencies smaller than 100us already in user-space. So, the
> > fact that you get higher latencies in kernel-space is highly
> > suspicious.
>
> Where do you see it is in user space ? The latency are colected in
> kernel module, it is just display wich is in user space.

No, the first and third test mentions clearly "periodic user-mode
task", which means that you launched the latency test with no -t
option or with -t 0, in this case, latencies are collected in
user-space. If you want to collect latencies in kernel space, you
should run latency with the -t 1 (kernel-space thread) or -t 2
(kernel-space timer handler) option.

> Then the 100us I mentionned are under calibrator load, which is the
> application which give the worse resulats. On the result yout point
> the max lantency is 200us.

Ok, I missed this one because I did not see the RTT header.

> We reached 100us by set dbgu priority to 6, and maintain timer
> priority to 7. Indeed serial output on dbu give bad latency as it its
> peripheral ID is 0, so with the same level of priority in AIC, its
> interrupt are treated first. We change this in adeos fot both RTAI and
> Xenomai.
> Maybe this change can be done in adeos main tree.

Well, that is interesting. But it would have been nice to tell us
about this, so that we could have fixed the I-pipe patch.

-- 
                                               Gilles Chanteperdrix

