From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B977F1F.8030304@domain.hid>
References: <4B968538.7030204@domain.hid> <4B968BAC.5090205@domain.hid>
	<4B977F1F.8030304@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 10 Mar 2010 12:33:14 +0100
Message-ID: <1268220794.27899.50.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] COMEDI vs Analogy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2010-03-10 at 12:14 +0100, Daniele Nicolodi wrote:
> Stefan Kisdaroczi wrote:
> > Hi Daniele,
> > 
> > https://mail.gna.org/public/xenomai-core/2009-09/msg00016.html
> > 
> > regards, Stefan
> 
> Thanks Stefan for the pointer. Your link contains almost everything I
> want to know. I agree that Comedi design is far from perfect and I
> appreciate the effort of coding something better. However Comedi was a
> functional solution, Analogy looks half backed. Even few drivers ported
> from Comedi do not support all the functionalities of Comedi (my
> application right now uses the TRIG_WAKE_EOS command functionality, that
> the documentation report as not supported). And it does not cure all the
> problems of Comedi (for example channel setup and data acquisition are
> still coupled in a single operation in synchronous acquisitions).
> 
> I would like to have the possibility to use (the far from perfect but
> working) Comedi over RTDM while Analogy is worked out. Would it be
> possible to recover the early work done to port Comedi over RTDM and put
> it to some use? Given enough informations I can try to do it myself.
> 

Beats me. Why do you assume that Comedi/RTDM provides more support
compared to Analogy, since it is stated that Analogy started off from
the Comedi/RTDM code base, months ago?

The reasons why you can't put original Comedi drivers on top of Analogy
did exist with Comedi/RTDM: the internal layers and APIs have been
refactored.

If you do want to help, you may want investing your time in developing
and testing a better code base like Analogy with other people, instead
of re-opening a dead development effort all alone.

> Thanks. Best regards,


-- 
Philippe.



