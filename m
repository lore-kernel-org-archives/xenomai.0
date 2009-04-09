Message-ID: <49DDBF4D.1060708@domain.hid>
Date: Thu, 09 Apr 2009 11:26:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <17B3FD74-07D0-4F36-9836-8E03943DF917@domain.hid>	
	<49D1EA0B.2020300@domain.hid>
	<67b6b3430904081529n36226987r3708908b974d8d1a@domain.hid>
In-Reply-To: <67b6b3430904081529n36226987r3708908b974d8d1a@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] geode gx1 latencies
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Mark Saiia <mark.saiia@domain.hid>
Cc: xenomai@xenomai.org

Mark Saiia wrote:
> Gilles and list,
> I have tested out your latest patch with 2.4maint, 2.627.19.  It
> appears to work fine, no crashes related to 3dnow and no floating
> point issues.  However, we are observing rather high latencies.  This
> is without the hack described in the above thread.
> /proc/xenomai/timer shows clockdev as tsc.  At around 2.5 minutes , I
> did an ls in a while loop over a telnet connection in order to raise
> cpu usage to 22%.  Appended are the latency results.

The latency results do not tell us much. Please send us traces made by
the I-pipe tracer.

-- 
                                                 Gilles.

