Message-ID: <4875001F.10405@domain.hid>
Date: Wed, 09 Jul 2008 20:14:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <838862596@domain.hid> <4861F67F.7090805@domain.hid>
	<6132061f0807091038s38aad988w5493bd8f4b53adab@domain.hid>
In-Reply-To: <6132061f0807091038s38aad988w5493bd8f4b53adab@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] latency in kernel mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Breno Carneiro Pinheiro <brenodee@domain.hid>
Cc: xenomai@xenomai.org

Breno Carneiro Pinheiro wrote:
> Hi guys, I wonder do the same test as described below on my system.
> Where's the timerbench driver? I was looking for this option but I
> couldn't find it on my .conifg.

As documented in section 1.2 of README.INSTALL, all Xenomai options are
available under the menu "Real-time susbsytem" in Linux kernel
configuration.

> Is it necessary to do what Joachim said at previous email?:
> 
> " I enabled the timerbench module, and installed it with the other
> modules (IRQ Benchmark and Context Switch). The Switchtest test
> works, so I think the modules are correct installed and the tests are
> able to load them...."

If you mean install the modules then no, you do not need to install
Xenomai modules, but if you do not do so, you will have to pass their
full path to insmod, and Xenomai "run" scripts will not be able to find
them by themselves.

-- 


					    Gilles.

