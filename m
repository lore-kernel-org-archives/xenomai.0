Subject: Re: [Xenomai-help] Maximum number of realtime tasks
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <54b161f50610310051q2ec175a2vb3f5c90872ea0364@domain.hid>
References: <54b161f50610310051q2ec175a2vb3f5c90872ea0364@domain.hid>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 10:04:28 +0100
Message-Id: <1162285469.4996.35.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Frits de Klark <mailing.xenomai@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2006-10-31 at 09:51 +0100, Frits de Klark wrote:
> Hello everyone,
> 
> I'm thinking about implementing a tcp/ip socket server where I assign
> each incoming connection 2 realtime tasks; 1 one for transmitting data
> and 1 for receiving data. I'm aware of the fact that the tasks will
> lose their realtime capacities, but I want to do some tests
> nonetheless.
> I was wondering if there is a limit on the number of realtime tasks I
> can allocate and run at the same time. Is there any?

No limit on the number of concurrent tasks. Just make sure to have
enough TCB space available from the Xenomai system heap
(CONFIG_XENO_OPT_SYS_HEAP).

>  
> And may there be other problems to expect?

Depending on the runtime behaviour of your system, i.e. large number of
ready-to-run tasks or outstanding timers at any given time, you may want
to experiment with the scalability options from the nucleus
configuration section.

> Thanks very much for your help,
> 
> Frits
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



