Message-ID: <2ff1a98a0801240202g83ca10esd2f7fc928946e3c1@domain.hid>
Date: Thu, 24 Jan 2008 11:02:15 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <20080124094150.GA7503@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080123065221.GB6573@domain.hid>
	<2ff1a98a0801230204s15e4eefaifdd2c946c44549df@domain.hid>
	<2ff1a98a0801230515i77f8c22bk866c4cd592a3a9b8@domain.hid>
	<20080124094150.GA7503@domain.hid>
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
To: Juan Antonio Garcia Redondo <juan-antonio.garcia@domain.hid>
Cc: jagarcia@domain.hid, xenomai@xenomai.org

On Jan 24, 2008 10:41 AM, Juan Antonio Garcia Redondo
<juan-antonio.garcia@domain.hid> wrote:
>
> On 23/01/08 14:15, Gilles Chanteperdrix wrote:
> > On Jan 23, 2008 11:04 AM, Gilles Chanteperdrix
> > <gilles.chanteperdrix@xenomai.org> wrote:
> > > On Jan 23, 2008 7:52 AM, Juan Antonio Garcia Redondo
> > >
> > > <juan-antonio.garcia@domain.hid> wrote:
> > > > I see everything OK except for the first samples of cyclictests. Any comments ?
> > >
> > > The load you apply does not load the cache, which is a source of
> > > jitter. You should run the cache calibrator (I do not find the cache
> > > calibrator URL, but it is somewhere in Xenomai distribution or wiki).
> >
> > It is in the TROUBLESHOOTING guide, question "How do I adequately stress test".
> >
> > --
> >                                                Gilles Chanteperdrix
>
> Thanks Gilles, I've done more tests using the cache calibrator from
> http://www.cwi.nl/~manegold/Calibrator. The latency numbers are very
> similar althought I've found an strange behaviour related to telnet
> sessions.

Are you kidding ? In the first results you posted, the latency was
around 80us whereas now, you get a latency around 130us. And from I
read, you did not run the tests for long period. If you want reliable
results, you should let the test run, under load, for hours.

>
> Environment:
>         o Tests running from console over atmel serial port.
>         o A telnet session over on-chip ethernet.
>         o System without load.
>
> ./latency -p 500 -t0
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 500 us period, priority 99)
> RTH|-RTH----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
> worst
> RTD|      49.613|      52.190|      62.822|       0|      49.613| 62.822
> RTD|      42.203|      52.512|      66.365|       0|      42.203| 66.365
>
>
> Now If hit a key on the telnet session :
>
> RTD|      36.726|      57.989|     109.536|       0|      31.572| 109.536  <-------- Here I've hit the key.
> RTD|      36.404|      51.868|      69.587|       0|      31.572| 109.536
> RTD|      35.760|      51.868|      73.775|       0|      31.572| 109.536
>
> Now, I launch an script which executes four instances of cache
> calibrator.
>
> RTD|      45.103|      57.667|      75.708|       0|      32.538| 122.422
> RTD|      45.425|      57.023|      76.030|       0|      32.538| 122.422
> RTD|      46.069|      57.023|      75.708|       0|      32.538| 122.422
>
> Now, I can hit a key on the telnet session without effects over latency
> numbers:
>
> RTD|      44.136|      57.989|      75.386|       0|      27.384| 128.221
> RTD|      46.713|      57.345|      76.353|       0|      27.384| 128.221
> RTD|      44.780|      57.345|      76.675|       0|      27.384| 128.221
> RTD|      43.492|      56.701|      76.997|       0|      27.384| 128.221
>
> Now I stop the calibrator process and launch 'ping -f -s2048 192.168.2.82' from an external
> machine.
>
> RTD|      40.270|      68.621|      90.850|       0|      27.384| 128.221
> RTD|      36.082|      68.621|      88.273|       0|      27.384| 128.221
> RTD|      40.592|      67.976|      91.494|       0|      27.384| 128.221
> RTD|      41.237|      68.298|      89.239|       0|      27.384| 128.221
>
>
> Now If hit a key on the telnet session :
>
> RTD|      42.203|      67.976|      88.273|       0|      27.384| 128.221
> RTD|      32.216|      93.427|     128.543|       0|      27.384| 128.543 <---------- Here I've hit the key.
> RTD|      42.203|      68.298|      87.628|       0|      27.384| 128.543
>
> And again the calibrator execution results on eliminate the strange
> behaviour whith the telnet session.
>
> Any clues ?

No mystery: hitting a key on a telnet session causes an interrupt
masking section of 110us, you see it as the maximum if you never
observed longer masking sections, but it is not the maximum if you
observed longer masking sections.

>
> BTW, if finally the bad numbers on ARM are user-context switches related,
> are you considering the ipipe upgrading to 2.6.23 ?

No comment. I have already answered this question.

-- 
                                               Gilles Chanteperdrix

