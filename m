Date: Mon, 28 Jan 2008 09:51:24 +0100
From: Juan Antonio Garcia Redondo <juan-antonio.garcia@domain.hid>
Message-ID: <20080128085123.GA7297@domain.hid>
References: <20080123065221.GB6573@domain.hid>
	<2ff1a98a0801230204s15e4eefaifdd2c946c44549df@domain.hid>
	<2ff1a98a0801230515i77f8c22bk866c4cd592a3a9b8@domain.hid>
	<20080124094150.GA7503@domain.hid>
	<2ff1a98a0801240202g83ca10esd2f7fc928946e3c1@domain.hid>
	<20080125100404.GA8833@domain.hid>
	<2ff1a98a0801250900if03294epded12290544d5480@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ff1a98a0801250900if03294epded12290544d5480@domain.hid>
Subject: Re: [Xenomai-help] AT91SAM9260 latency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: jagarcia@domain.hid, xenomai@xenomai.org

On 25/01/08 18:00, Gilles Chanteperdrix wrote:
> On Jan 25, 2008 11:04 AM, Juan Antonio Garcia Redondo
> <juan-antonio.garcia@domain.hid> wrote:
> > On 24/01/08 11:02, Gilles Chanteperdrix wrote:
> > Well, after several tests, (one of them 4 hours long), I can't see
> > latencies above 100 us. Anyway I'll do more tests this weekend. The
> > latency around 130us occurs with telnet activity.
> 
> This contradicts what you told us in previous posts. You told us that
> the maximum latency went up to 130us when starting the calibrator.

I guess that there has been a misunderstanding. In the mail
https://mail.gna.org/public/xenomai-help/2008-01/msg00108.html I
wanted to point to the fact that the telnet activity had a direct and
reproducible efect on lat_max field. So my test was:
1) From a minicom terminal run 'latency -t0 -p500'
2) From a telnet terminal launch calibrator, kill calibrator etc.

So, the lat_worst numbers I showed in that email has no value. I
launched the calibrator process during several minutes, and, while I
was doing the tests I saw the telnet behaviour and I thought that could be
interesting to report it.

I've done more tests this weekend. I've switched to at91sam9260_ek
development plattform because I can hold it doing xenomai tests without affect
my current work.  

My numbers:

o Test xenomai-2.4.0 + 5 * (dd if=/dev/sda of=/dev/null) + 5 * (calibrator 180
4M calibra) + ping -f -s2048

./latency -p 500 -t0 

RTD|      47.358|      67.976|      93.105|       0|      28.672| 122.422
RTD|      47.680|      68.298|      91.817|       0|      28.672| 122.422
RTD|      49.291|      68.298|      91.494|       0|      28.672| 122.422
RTD|      45.747|      68.621|      90.528|       0|      28.672| 122.422
RTD|      47.358|      68.621|      90.206|       0|      28.672| 122.422
RTD|      47.358|      68.621|      91.172|       0|      28.672| 122.422
RTD|      37.048|      68.621|      92.139|       0|      28.672| 122.422
RTT|  07:35:22  (periodic user-mode task, 500 us period, priority 99)

> 
> 
> > > No mystery: hitting a key on a telnet session causes an interrupt
> > > masking section of 110us, you see it as the maximum if you never
> > > observed longer masking sections, but it is not the maximum if you
> > > observed longer masking sections.
> >
> > OK, but why the masking section on linux side affects to xenomai side ?
> > Another thing I don't understand is why when the system has load (above
> > I'm talking about calibrator but the same occurs with dd if=/dev/zero
> > of=/dev/null), the effect seems to dissapear.
> 
> It is probably not a masking section on linux side but rather a
> masking section on I-pipe side. Anyway, the effect does not disappear:
> it means that the cache effects cause larger latencies than the
> ethernet interrupt, but maybe I did not understand what you explained.
> The results you obtain with no load are simply irrelevant.

I'll try to explain it better:

o Without load I run ./latency -t0 -p500.
RTD|      33.182|      53.479|      67.976|       0|      31.250| 77.319
RTD|      43.170|      53.479|      67.654|       0|      31.250| 77.319
RTD|      41.881|      53.479|      67.332|       0|      31.250| 77.319
RTT|  00:02:07  (periodic user-mode task, 500 us period, priority 99)

o Each time I press a key (over a telnet session) I can see the lat_max field increase on 40 to 50 us aprox.
RTD|      33.505|      53.479|      71.842|       0|      26.739| 77.319
RTD|      40.592|      62.177|     123.067|       0|      26.739| 123.067
                                   -------
                                      \_________: Key pressed 
RTD|      50.579|      53.479|      73.775|       0|      26.739| 123.067


o Stop the latency test.
o run dd if=/dev/zero of=/dev/null
o run ./latency -t0 -p 500
RTD|      44.780|      55.734|      89.884|       0|      36.082| 93.105
RTD|      45.425|      55.412|      89.561|       0|      36.082| 93.105
RTD|      44.458|      55.734|      90.206|       0|      36.082| 93.105
RTD|      45.103|      55.412|      90.206|       0|      36.082| 93.105
RTD|      45.425|      55.734|      88.273|       0|      36.082| 93.105
RTT|  00:02:07  (periodic user-mode task, 500 us period, priority 99)

o I can't see any effect on lat_max field when I press a key on the
telnet session.

RTD|      44.136|      55.734|      92.461|       0|      36.082| 94.394
                                   -------
                                      \_________: Key pressed 
RTD|      43.814|      55.734|      90.528|       0|      36.082| 94.394
                                   -------
                                      \_________: Key pressed 
RTD|      45.103|      55.412|      89.239|       0|      36.082| 94.394
                                   -------
                                      \_________: Key pressed 
RTT|  00:03:31  (periodic user-mode task, 500 us period, priority 99)

As you can see the lat_max numbers are under the 100 us while I can go
up 120 us easily whith the former test.

Regards,
	Juan Antonio

