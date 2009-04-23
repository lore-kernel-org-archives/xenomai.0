From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <A5692251-1B79-4E0A-9024-8A40AD22A44D@comcast.net>
References: <49EF6591.7000802@domain.hid>
	<468CF57C-40DE-498B-9C2C-C73AE07CFE4F@comcast.net>
	<49EF7088.6070006@domain.hid>
	<4A05FD82-380E-4DBB-A848-CB2212F88C39@domain.hid>
	<1240438664.6987.85.camel@domain.hid>
	<A5692251-1B79-4E0A-9024-8A40AD22A44D@comcast.net>
Content-Type: text/plain
Date: Thu, 23 Apr 2009 10:10:03 +0200
Message-Id: <1240474203.6990.19.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Steven Seeger <steven.seeger@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2009-04-22 at 19:08 -0400, Steven Seeger wrote:
> > We do _not_ know what the heck your application does, whether it has
> > problems or not. But, we could find out whether Xenomai has problems  
> > or
> > not on your particular hardware. You already confirmed that your
> > RTAI-based implementation differed totally from your Xenomai-based  
> > one,
> > so comparing won't help either. Btw, do you really think that other
> > users would settle for 3 digit latency figures on x86? Obviously  
> > not, so
> > what you see must be pathological. Therefore, the only question worth
> > discussing is: who is causing this?
> 
> We have sent output from latency before, and the ones I have seen I  
> think had a max of like 85us. We never ran it for an hour. We can do  
> that with both latency -t1 and -t2.

The latency figures we have for the GX1 were obtained when chasing the
TSC issue, so we are not going to base any reasoning on them. We need
fresh values from your very latest setup in use.

But yes, having -t0, -t1 and -t2 would make sense, because comparing
them would help understanding where the weak point might be, if the
issue is Xenomai related. If it is not, then at least we would not chase
wild gooses uselessly.

> 
> It is probably our app that has problems, but I am trying to  
> understand how the interactions work.

I understand that, but this is not the way to go; as Gilles pointed out,
speculating on various unrelated/obscure issues would make us miss the
big picture. We first have to find a stable ground to build our
reasoning on, that is decoupled from any application artefacts. Standard
latency tests do provide this information.

>  The highest priority thread in  
> our program does nothing but flip a bit and we're seeing that do weird  
> things on a logic analyzer.

This is step #2: as soon as we may rule out a general platform issue, we
may introduce additional application monitoring such as the I-pipe
tracer in the picture.

> 
> Nice angry email! :)
> 

I was not angry, just surprised that we already spent that much time on
discussing those issues in a scatterbrain way instead of following a
simple and consistent approach. It's easy to find out when I'm writing
angry e-mails actually, I'm using "damnit" as a punctuation mark.

> Steven
> 
-- 
Philippe.



