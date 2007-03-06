From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
Date: Tue, 6 Mar 2007 17:21:15 +0100
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<45ED8FC8.4090103@domain.hid>
	<bc4264770703060811p41e0dff5s80d46c0d14314a15@domain.hid>
In-Reply-To: <bc4264770703060811p41e0dff5s80d46c0d14314a15@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HOcPS-0003Lb-5H@mailer.emlix.com>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

roland Tollenaar wrote:
> Ah. Will do so. But the problem I am having with the RTCAN gives
> latencies of the order of 0.2ms fluctuating heavily and visible
> immediately.

As Gilles pointed out, 0.2ms are 200 us so nothing special here.

> No matter what else I do with my system ,even downloading email to
> thunderbird while sending this email to you and compiling another
> program at the same time hardly disrupts my apps period times that
> much.

Could you run latency when receiving CAN messages? Please do it again with 
rtcansend/rtcanrecv without your app.

-- 
Sebastian

