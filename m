From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4CB06CE9.9090204@domain.hid>
References: <4CB06CE9.9090204@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Oct 2010 17:42:18 +0200
Message-ID: <1287070938.1628.20.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [forge] irqbench removal
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Sat, 2010-10-09 at 15:23 +0200, Jan Kiszka wrote:
> Philippe,
> 
> irqbench does not inherently depend on a third I-pipe domain. It is a
> useful testcase, the only in our portfolio that targets a peripheral
> device use case. In fact, it was only of the first test cases for Native
> RTDM IIRC.
> 
> Please revert the removal and then cut out only the few parts that
> actually instantiate an additional domain (i.e. mode 3.

So, what do we do with this? Any chance we move to arch-neutral code for
this test?

> 
> Thanks,
> Jan
> 

-- 
Philippe.



