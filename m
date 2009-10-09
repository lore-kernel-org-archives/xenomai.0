From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <72cf3fb0910081500y7f22500erb1415a16ea402919@domain.hid>
References: <200910080126.13483.berlemont.hauw@domain.hid>
	<1255023424.2781.70.camel@domain.hid>
	<72cf3fb0910081500y7f22500erb1415a16ea402919@domain.hid>
Content-Type: text/plain
Date: Fri, 09 Oct 2009 10:04:07 +0200
Message-Id: <1255075447.2781.111.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Some thoughts on Analogy "kernel side" framework
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Fri, 2009-10-09 at 00:00 +0200, Alexis Berlemont wrote:

> If I understand well, I have gone too far too soon; the idea should be
> to keep the current framework as it is for 2.5.
> 
> However, my former mail was not a definitive plan. The first goal was
> to share ideas. So, do not worry too much. :)

Maintaining two different frameworks for the same purpose won't fly. I'm
worried because the future of Comedi/RTDM as merged in the 2.5 tree just
became unclear - to say the least - as from you introduced the idea of
changing its architecture.

Your potential user-base has to know whether using the current
Comedi/RTDM framework for new designs based on 2.5.x will still make
sense in six months from now, when Analogy eventually emerges. 

In other words, is there any upgrade path planned? What would this
entail?

Would one have to rewrite custom DAQ drivers to port them from
Comedi/RTDM to Analogy, or could rely on a some compat wrapper for
supporting legacy Comedi/RTDM Driver-Kernel interface on top of the
Analogy core?

Would that new architecture bring changes in the applications, i.e. what
about the impact of such changes on the way userland interfaces to the
acquisition framework and/or its drivers?

I would have thought that Comedi/RTDM in the 2.5 tree would become
Analogy as is, and evolve over time in a careful manner so that people
always have a reasonable upgrade path. But now, I'm unsure whether this
is going to be the case, or we would end up with two different
frameworks. So, what is the _exact_ plan?

-- 
Philippe.



