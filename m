Message-ID: <4B977F1F.8030304@domain.hid>
Date: Wed, 10 Mar 2010 12:14:39 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4B968538.7030204@domain.hid> <4B968BAC.5090205@domain.hid>
In-Reply-To: <4B968BAC.5090205@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Stefan Kisdaroczi wrote:
> Hi Daniele,
> 
> https://mail.gna.org/public/xenomai-core/2009-09/msg00016.html
> 
> regards, Stefan

Thanks Stefan for the pointer. Your link contains almost everything I
want to know. I agree that Comedi design is far from perfect and I
appreciate the effort of coding something better. However Comedi was a
functional solution, Analogy looks half backed. Even few drivers ported
from Comedi do not support all the functionalities of Comedi (my
application right now uses the TRIG_WAKE_EOS command functionality, that
the documentation report as not supported). And it does not cure all the
problems of Comedi (for example channel setup and data acquisition are
still coupled in a single operation in synchronous acquisitions).

I would like to have the possibility to use (the far from perfect but
working) Comedi over RTDM while Analogy is worked out. Would it be
possible to recover the early work done to port Comedi over RTDM and put
it to some use? Given enough informations I can try to do it myself.

Thanks. Best regards,
-- 
Daniele

