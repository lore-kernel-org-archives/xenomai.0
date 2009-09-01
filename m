From: Christoph Permes <christoph.permes@domain.hid>
Date: Tue, 01 Sep 2009 17:00:03 +0200
Message-Id: <1251817203.4304.12.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Subject: [Xenomai-help] Message queue flush
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

In my application I need to flush a queue if rt_queue_write returns
-ENOMEM to prevent the consumer process from reading old data.

Is there any function in the native api that flushes a message queue,
like rt_pipe_flush for pipes?

Thanks,
Christoph



