MIME-Version: 1.0
In-Reply-To: <CAJt3u5mVofHe6X3FfNO3RHmMusqiCd8gbf2WuTD=LNs1gsS98A@mail.gmail.com>
References: <20141111153745.GX24110@csclub.uwaterloo.ca>
 <20141111154611.GD17476@sisyphus.hd.free.fr>
 <20141111155212.GZ24110@csclub.uwaterloo.ca>
 <20141111155447.GE17476@sisyphus.hd.free.fr>
 <20141111155642.GA24110@csclub.uwaterloo.ca>
 <20141111160236.GF17476@sisyphus.hd.free.fr>
 <20141111161744.GB24110@csclub.uwaterloo.ca>
 <CAJt3u5=nBbiqOZ6kFsXujHtbGyz6GhQO10F-=rpc0WpXFj+zZw@mail.gmail.com>
 <20141112042250.GF24110@csclub.uwaterloo.ca>
 <CAPRPZsAHXt9cFWeduwziZ=iTpDg7KikrMw+HEuTi5eJ72gkztA@mail.gmail.com>
 <20141112141040.GR17476@sisyphus.hd.free.fr>
 <CAPRPZsCeJ1WtZneoKP1SYo5uzmwWyXGtn0EU45i2gb8VgDUhQQ@mail.gmail.com>
 <CAJt3u5mVofHe6X3FfNO3RHmMusqiCd8gbf2WuTD=LNs1gsS98A@mail.gmail.com>
Date: Wed, 12 Nov 2014 15:44:14 +0000
Message-ID: <CAEbDrgm5FLeitoXn+b=bCtQwgDU8=auC8fu2xNA8Ba0U2gQ0JA@mail.gmail.com>
From: Gregory Dymarek <gregd72002@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] USB3.0 drivers for xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Are you designing another wireless HDMI standard? Low latency and high
throughput :)

How low do you want the latency to be? Why not to separate TX from RX
and use different hardware for each?


On 12 November 2014 15:23, Madan Sondur <sondur.madan23@gmail.com> wrote:
> My requirement is basically for RF board which uses USB3.0 as interface for
> the PC. The best way to check USB3.0 throughput is to use data transfer
> check through SSDs. Th RF driver itself will have some latencies on its own
> before the USB3.0 driver is used. The RF tx needs to send bursts of data as
> quickly as possible hence low latency is required.  Where as for RF rx
> needs  consistent stream of data at high throughputs. Example 2Gbps.
>
> Madan
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

