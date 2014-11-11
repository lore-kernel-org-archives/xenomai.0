Date: Tue, 11 Nov 2014 16:54:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141111155447.GE17476@sisyphus.hd.free.fr>
References: <CAJt3u5nf_epaPjW=dAjqGMq85dgRYqwn-MKcRGFWby+MXtvong@mail.gmail.com>
 <20141111110937.GY17476@sisyphus.hd.free.fr>
 <20141111153745.GX24110@csclub.uwaterloo.ca>
 <20141111154611.GD17476@sisyphus.hd.free.fr>
 <20141111155212.GZ24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141111155212.GZ24110@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] USB3.0 drivers for xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Tue, Nov 11, 2014 at 10:52:12AM -0500, Lennart Sorensen wrote:
> On Tue, Nov 11, 2014 at 04:46:11PM +0100, Gilles Chanteperdrix wrote:
> > Ok for the duplex, but for the polling, I doubt very much USB
> > drivers do any polling themselves. Is not that polling handled by
> > the host controller? (host controllers definitely have interrupts).
> 
> Well still you ought to get better response time if the device can send
> an interrupt, than if your controller polls 1000 times per second.

With periodic polling, you get bounded response time (and bounded
IRQ load), so, this is, in fact, the best situation for real-time.

-- 
					    Gilles.

