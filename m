Date: Fri, 14 Nov 2014 10:06:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141114090610.GY4656@sisyphus.hd.free.fr>
References: <20141111160236.GF17476@sisyphus.hd.free.fr>
 <20141111161744.GB24110@csclub.uwaterloo.ca>
 <CAJt3u5=nBbiqOZ6kFsXujHtbGyz6GhQO10F-=rpc0WpXFj+zZw@mail.gmail.com>
 <20141112042250.GF24110@csclub.uwaterloo.ca>
 <CAPRPZsAHXt9cFWeduwziZ=iTpDg7KikrMw+HEuTi5eJ72gkztA@mail.gmail.com>
 <20141112141040.GR17476@sisyphus.hd.free.fr>
 <CAPRPZsCeJ1WtZneoKP1SYo5uzmwWyXGtn0EU45i2gb8VgDUhQQ@mail.gmail.com>
 <CAJt3u5mVofHe6X3FfNO3RHmMusqiCd8gbf2WuTD=LNs1gsS98A@mail.gmail.com>
 <CAEbDrgm5FLeitoXn+b=bCtQwgDU8=auC8fu2xNA8Ba0U2gQ0JA@mail.gmail.com>
 <20141114090212.GX4656@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141114090212.GX4656@sisyphus.hd.free.fr>
Subject: Re: [Xenomai] USB3.0 drivers for xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gregory Dymarek <gregd72002@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Nov 14, 2014 at 10:02:12AM +0100, Gilles Chanteperdrix wrote:
> On Wed, Nov 12, 2014 at 03:44:14PM +0000, Gregory Dymarek wrote:
> > Are you designing another wireless HDMI standard? Low latency and high
> > throughput :)
> 
> Let us explain why you can not have the lowest latency with highest
> throughput with usual processor/hardware design (maybe some other
> designs exist allowing that, but with the range of processors with
> caches and MMU supported by Xenomai in the mix, I very much doubt
> it). 
> 
> The usual way of sending data with hardware connected to a processor
> with low latency is this. We split the data to send into "chunks" of
> data. Then, for each chunk, pass the chunk to the hardware. When the
> chunk is done transmitting, the hardware sends an irq to the
> processor, which can program the next chunk, etc...
> 
> If we define the latency as the time separating data being ready to
> be sent, and data having been sent. What is the worst case latency
> of this solution ? The worst case is when another chunk of data has
> just been programmed, in that case, the worst case latency is:
> worst case time to send one chunk + worst case irq latency.
> 
> Can this solution have the best possible throughput ? No, because
> there is a time during which the hardware does not send any data:
> that is the time separating the irq being signalled by hardware and
> the irq being handled by the processor.
> 
> Now, the usual way of sending data for best throughput is to pass
> several chunks of data to the hardware, so that when the first chunk
> is finished, it has another chunk ready to start sending. How many
> chunks of data do you need to send to the hardware ? Well, N must be
> such that the N * best case time to send one chunk is more than the
> worst case irq latency.
> 
> Now, what is the worst case latency of this solution ? The worst
> case is when N chunks have just been programmed. In that case the
> worst case latency is:
> (N + 1) * worst case time to send one chunk + worst case irq latency.
> 
> If chunks are of fixed size, and the underlying bus/protocol
> deterministic that is around:
> time to send one chunk + 2 * worst case irq latency.

And of course, the other obvious conclusion is that the better the
worst case irq latency, the better latency you get with maximum
throughput. 

-- 
					    Gilles.

