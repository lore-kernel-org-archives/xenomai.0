Message-Id: <A5692251-1B79-4E0A-9024-8A40AD22A44D@comcast.net>
From: Steven Seeger <steven.seeger@domain.hid>
In-Reply-To: <1240438664.6987.85.camel@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Wed, 22 Apr 2009 19:08:01 -0400
References: <49EF6591.7000802@domain.hid>
	<468CF57C-40DE-498B-9C2C-C73AE07CFE4F@comcast.net>
	<49EF7088.6070006@domain.hid>
	<4A05FD82-380E-4DBB-A848-CB2212F88C39@domain.hid>
	<1240438664.6987.85.camel@domain.hid>
Subject: Re: [Xenomai-core] [Xenomai-help] An answer to Steven's questions.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

> We do _not_ know what the heck your application does, whether it has
> problems or not. But, we could find out whether Xenomai has problems  
> or
> not on your particular hardware. You already confirmed that your
> RTAI-based implementation differed totally from your Xenomai-based  
> one,
> so comparing won't help either. Btw, do you really think that other
> users would settle for 3 digit latency figures on x86? Obviously  
> not, so
> what you see must be pathological. Therefore, the only question worth
> discussing is: who is causing this?

We have sent output from latency before, and the ones I have seen I  
think had a max of like 85us. We never ran it for an hour. We can do  
that with both latency -t1 and -t2.

It is probably our app that has problems, but I am trying to  
understand how the interactions work. The highest priority thread in  
our program does nothing but flip a bit and we're seeing that do weird  
things on a logic analyzer.

Nice angry email! :)

Steven


