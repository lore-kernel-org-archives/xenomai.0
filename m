Date: Tue, 11 Nov 2014 16:46:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141111154611.GD17476@sisyphus.hd.free.fr>
References: <CAJt3u5nf_epaPjW=dAjqGMq85dgRYqwn-MKcRGFWby+MXtvong@mail.gmail.com>
 <20141111110937.GY17476@sisyphus.hd.free.fr>
 <20141111153745.GX24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141111153745.GX24110@csclub.uwaterloo.ca>
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

On Tue, Nov 11, 2014 at 10:37:45AM -0500, Lennart Sorensen wrote:
> On Tue, Nov 11, 2014 at 12:09:37PM +0100, Gilles Chanteperdrix wrote:
> > First of all, if you are starting to work with xenomai, you should
> > not install an old version such as 2.6.2.1, you should install the
> > latest stable version, which is 2.6.4.
> > 
> > As for support for USB 3.0 drivers, to my knowledge, there are none.
> > Note however that most USB3.0 devices are USB2.0 compatible, and if
> > you are after latency and not bandwidth, it should not matter that
> > much. If you are after bandwidth, then why looking for a Xenomai
> > driver?
> 
> Well USB3 is full duplex and can generate interrupt messages, while USB2
> is half duplex and polled.
> 
> Those might be good reasons to want USB3.

Ok for the duplex, but for the polling, I doubt very much USB
drivers do any polling themselves. Is not that polling handled by
the host controller? (host controllers definitely have interrupts).

-- 
					    Gilles.

