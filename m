From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <10023762.21237868208390.JavaMail.root@domain.hid>
References: <10023762.21237868208390.JavaMail.root@domain.hid>
Content-Type: text/plain
Date: Tue, 24 Mar 2009 09:59:37 +0100
Message-Id: <1237885177.6815.36.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Support for static APIs in uITRON skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ravikiran.saralaya@domain.hid
Cc: xenomai@xenomai.org

On Tue, 2009-03-24 at 00:16 -0400, ravikiran.saralaya@domain.hid wrote:
> Thanks Philippe for the clarification.
> 
> I am curious to know if there are any attempts being done to make uITRON skin compliant to uITRON Specification version 4.03.00.
> 

No idea.

> Regards,
> Ravikiran
> 
> -- Philippe Gerum wrote : 
> ravikiran.saralaya@domain.hid.... wrote:
> > Hello,
> > 
> > I am  planning to use Xenomai 2.4.7 for uITRON based application.
> > 
> > However it seems the uITRON skin doesn't support static creation of tasks, semaphores etc. Is there any specific reason for not supporting static APIs in Xenomai uITRON skin?
> 
> 
> None, aside of the fact that this implementation supports level E from the 
> uITRON spec, and it seems rather straightforward to get static object creation 
> at init time out of the existing dynamic object creation services.
> 
> > 
> > How can I go about in supporting static APIs for uITRON?
> >
> > Regards,
> > Ravikiran
> > 
> > 
> > 
> > --
> > This message was sent on behalf of ravikiran.saralaya@domain.hid.... at openSubscriber.com
> > http://www.opensubscriber.com/messages/xenomai@xenomai.org
> > 
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid....
> > https://mail.gna.org/listinfo/xenomai-help
> > 
> 
> 
-- 
Philippe.



