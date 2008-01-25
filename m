Message-ID: <2ff1a98a0801250900if03294epded12290544d5480@domain.hid>
Date: Fri, 25 Jan 2008 18:00:05 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <20080125100404.GA8833@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080123065221.GB6573@domain.hid>
	<2ff1a98a0801230204s15e4eefaifdd2c946c44549df@domain.hid>
	<2ff1a98a0801230515i77f8c22bk866c4cd592a3a9b8@domain.hid>
	<20080124094150.GA7503@domain.hid>
	<2ff1a98a0801240202g83ca10esd2f7fc928946e3c1@domain.hid>
	<20080125100404.GA8833@domain.hid>
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

On Jan 25, 2008 11:04 AM, Juan Antonio Garcia Redondo
<juan-antonio.garcia@domain.hid> wrote:
> On 24/01/08 11:02, Gilles Chanteperdrix wrote:
> Well, after several tests, (one of them 4 hours long), I can't see
> latencies above 100 us. Anyway I'll do more tests this weekend. The
> latency around 130us occurs with telnet activity.

This contradicts what you told us in previous posts. You told us that
the maximum latency went up to 130us when starting the calibrator.


> > No mystery: hitting a key on a telnet session causes an interrupt
> > masking section of 110us, you see it as the maximum if you never
> > observed longer masking sections, but it is not the maximum if you
> > observed longer masking sections.
>
> OK, but why the masking section on linux side affects to xenomai side ?
> Another thing I don't understand is why when the system has load (above
> I'm talking about calibrator but the same occurs with dd if=/dev/zero
> of=/dev/null), the effect seems to dissapear.

It is probably not a masking section on linux side but rather a
masking section on I-pipe side. Anyway, the effect does not disappear:
it means that the cache effects cause larger latencies than the
ethernet interrupt, but maybe I did not understand what you explained.
The results you obtain with no load are simply irrelevant.

-- 
                                               Gilles Chanteperdrix

