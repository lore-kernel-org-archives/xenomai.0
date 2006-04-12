Message-Id: <1144803396.21432.258890893@domain.hid>
From: "Saul" <xeno@domain.hid>
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
References: <1143612388.32703.257789950@domain.hid>
	<442A7D19.2000009@domain.hid>
	<1143694058.30209.257882137@domain.hid>
	<442C46EC.6000605@domain.hid>
	<1143790982.14016.257982746@domain.hid>
	<442CFCA3.4070704@domain.hid>
	<17453.19513.723459.198259@domain.hid>
	<1144724767.27088.258799393@domain.hid>
	<17467.39989.698322.9385@domain.hid>
Subject: Re: [Xenomai-help] Non-deterministic behaviour in primary mode
In-Reply-To: <17467.39989.698322.9385@domain.hid>
Date: Wed, 12 Apr 2006 10:56:36 +1000
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

Gilles Chanteperdrix wrote:
>  > >  > > I thought SMI was supposed to increase latencies, but I only
>  > >  > > see latencies < 60us at any load, unless I start video
>  > >  > > capture. Does the latency test absolutely rule out SMI as
>  > >  > > the cause?
>  > >  >
>  > >  > Not really, e.g. if the video capture device is USB-attached,
>  > >  > then SMI could possibly remain in the picture.
>  > >
>  > > I have used the bttv driver with xawtv or mythtv and nvidia
>  > > proprietary drivers on a dual pIII machine running latency and
>  > > the maximum latency was far less than 100 us. What produces large
>  > > spots, however, is switching virtual terminals or changing
>  > > resolution. Doesn't xawtv change resolution for full screen mode
>  > > ? Did not you use the 768x576 modeline hack ?
>  >
>  >
>  > The video capture is not USB, it's a PCI card. Since I don't see
>  > poor latencies I'm guessing my problem is *not* SMI related.
>
> The latencies above 100us that you observe when starting video capture
> are abnormal. I was suggesting that these latencies are not due to
> video capture but to the fact that xawtv change resolution. Big
> latencies when switching virtual terminal are a well-known issue, not
> related to SMI. So my question was: is xawtv configured on your
> machine to change resolution when starting capture ?

Oh, well xawtv starts up in a window and does not change the screen
resolution. The large latencies occur during program startup. I
have seen no other program produce poor latencies in the latency
test program.

Saul.

