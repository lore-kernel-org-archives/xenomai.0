Subject: Re: [Xenomai-help] Three questions about RTDM
From: Alessio Igor Bogani <abogani@domain.hid>
In-Reply-To: <43E1D0D6.2020003@domain.hid>
References: <1138870064.8753.19.camel@domain.hid>
	<43E1D0D6.2020003@domain.hid>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 11:35:39 +0100
Message-Id: <1138876539.8753.60.camel@domain.hid>
Mime-Version: 1.0
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

Hi Jan,

Thank for your reply.

[...]
> > 1) Where may I find a more detailed documentation about RTDM? 
> 
> More detailed than what? Have you already discovered the online docs on
> www.xenomai.org?

Yes i have already discovered online docs.
IMVHO API Reference is indispensable but not sufficient.
I would be very happy to see for RTDM something similar to Xenomai's
Native-API-Tour.

> > 2) Now I'm attempting to write a simple device driver with RTDM: Can
> > someone show me a standard GNUMakefile/Makefile to compile it?
> 
> Take a look at the heartbeat example on
> 
> www.rts.uni-hannover.de/mitarbeiter/kiszka/rtaddon
> 
> This works for 2.6 kernels and Xenomai 2.0.x. I still need to update it
> for Xenomai 2.1, where compilation melts down to simple out-of-tree
> kernel module generation. Does anyone else here have a generic Makefile
> for all kernel and Xenomai versions at hand?

Google is a great friend. ;-)

I have already seen heartbeat example.
Mysteriously heartbeat.ko module resulted is dependent from
latency_rt.ko module (present in testsuite\klatency in Xenomai package)
for a reason that i don't understand. :-(
How can resolve this problem?

Thank you very much!

Bye,
Alessio


