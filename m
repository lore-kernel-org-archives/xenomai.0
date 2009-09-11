From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1251817203.4304.12.camel@domain.hid>
References: <1251817203.4304.12.camel@domain.hid>
Content-Type: text/plain
Date: Sat, 12 Sep 2009 00:57:30 +0200
Message-Id: <1252709850.2820.493.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Message queue flush
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Christoph Permes <christoph.permes@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2009-09-01 at 17:00 +0200, Christoph Permes wrote:
> Hi,
> 
> In my application I need to flush a queue if rt_queue_write returns
> -ENOMEM to prevent the consumer process from reading old data.
> 
> Is there any function in the native api that flushes a message queue,
> like rt_pipe_flush for pipes?

http://git.xenomai.org/?p=xenomai-head.git;a=commit;h=ea4ad49cbf13ba3870351a9d3e301041af4c0279

> 
> Thanks,
> Christoph
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



