Subject: Re: [Xenomai-help] Three questions about RTDM
From: Alessio Igor Bogani <abogani@domain.hid>
In-Reply-To: <43E1E252.8090304@domain.hid>
References: <1138870064.8753.19.camel@domain.hid>
	<43E1D0D6.2020003@domain.hid>
	<1138876539.8753.60.camel@domain.hid>
	<43E1E252.8090304@domain.hid>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 16:27:22 +0100
Message-Id: <1138894042.8753.105.camel@domain.hid>
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

[RTDM Docs]
> > I would be very happy to see for RTDM something similar to Xenomai's
> > Native-API-Tour.
> 
> Would be nice - just takes /someone/ to write it... :-/

Ok :-)

> Maybe this paper can provide a few further hints meanwhile:
> 
> ftp://ftp.realtimelinuxfoundation.org/pub/events/rtlws-2005/JanKiszka.pdf

Wow! Can you put this document in Technical articles section in
Xenomai's site? I think that this document could be useful for others. 

[heartbeat example]
> > Mysteriously heartbeat.ko module resulted is dependent from
> > latency_rt.ko module (present in testsuite\klatency in Xenomai package)
> > for a reason that i don't understand. :-(
> > How can resolve this problem?
> 
> Due to which symbol? Which Xenomai version precisely? Indeed very
> strange. Something must be broken in your build.

Xenomai 2.0.3

Heartbeat.ko is loaded but not start and rtdm_task_init() return a -11
error code (EAGAIN?). If i load latency_rt.ko before to load
heartbeat.ko this work perfectly.
I suppose that heartbeat.ko should do start a timer, or not?

Bye,
Alessio


