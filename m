Message-ID: <4C19E5C8.8070802@domain.hid>
Date: Thu, 17 Jun 2010 11:07:20 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4C093C93.4000907@domain.hid> <4C0CEC7E.6080408@domain.hid>
	<4C0CF99F.1090700@domain.hid>
In-Reply-To: <4C0CF99F.1090700@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [comedi] NI 6251 "wrong" samples
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: comedi_list@domain.hid
Cc: xenomai@xenomai.org

Hello. Sorry for the long delay, I had some real work to get done with
the acquisition system and I had to implement a work-around for this
problem...

I have been investigating the issue further, but its random nature makes
this quite difficult.

> The observation that the "wrong" sample occurs on the last sample of the
> scan sounds useful.  Does it occur randomly or on every scan?

I must retire this statement. The "wrong" samples can occur on any
channel. Some are just more probable than other. The "wrong" samples do
NOT occur at each scan, and they look to be completely random in their
occurrence, I'm trying to find a pattern but without luck up to now.

> Also, are you using the TRIG_WAKE_EOS command flag (or equivalently,
> setting stop_arg to TRIG_COUNT and stop_count to 1)?  If so, does the
> wrong sample still occur when the TRIG_WAKE_EOS flag is not set?  (You
> might need to look harder for the wrong samples when TRIG_WAKE_EOS is
> not set, as they might occur much less frequently and they might occur
> at any position in the scan.

No. I'm running a continuous memory mapped acquisition. The only maybe
uncommon thing I'm doing is that I'm reading the mmapped buffer in fixed
chunks, rather than reading all the samples available each time. The
number of samples I read each time is larger than the 4095 samples after
which the hardware sends the FIFO half full trigger event.

Suggestions?

Thanks. Cheers,
-- 
Daniele

