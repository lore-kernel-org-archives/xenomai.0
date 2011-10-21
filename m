Message-ID: <4EA1D1F4.3010507@domain.hid>
Date: Fri, 21 Oct 2011 22:11:32 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <CAMwkeZxmX1dU-5d2zDiYqv_SRcFqyDF+gmp+i8t=q1G6NXrmbg@domain.hid>	<4EA19A9D.1080502@domain.hid>	<CAMwkeZwpNG9i0fGFRXQBOtpaaLZU6L2HvD=bBjM21em3dVCfZg@domain.hid>	<4EA1B033.6060707@domain.hid>	<CAMwkeZyTBkswrYe5TKaVZcY6Hm9FpefTSzLLABaN4HkgXFCa8g@domain.hid>	<4EA1BE4C.5030301@domain.hid>	<CAMwkeZzPDN5TFKiU05tuZdW4=yHT1XoWe2=xwceiimRw-rF4_w@domain.hid>	<4EA1C2FB.1050009@domain.hid>
	<CAMwkeZwXzXZrGoXxPxyisOCkekf3jzjWh5pp-Ddv5oj9kL4ZdQ@mail.gmail.com>
In-Reply-To: <CAMwkeZwXzXZrGoXxPxyisOCkekf3jzjWh5pp-Ddv5oj9kL4ZdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rt_task_wait_period returns an undocumented value
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On 21/10/11 21:15, Fernando Herrero Carr=C3=B3n wrote:
> Ok, thanks for the advice. The computations I will be doing will not be
> very expensive in principle, but I believe the analogy infrastructure i=
s
> the actual bottleneck. I have not been able to perform the acquisitions
> I want beyond 10kHz. At higher frequencies it looks like analogy does
> not have enough time to acknowledge all DMA interruptions. But this is =
a
> different issue.

I think you are doing something wrong then (and the fact that you need a
periodic task to perform such acquisitions smells like there is
something wrong in your code). I have acquisitions running at over 200
kHz for weeks without a glitch.

Cheers,
--=20
Daniele

