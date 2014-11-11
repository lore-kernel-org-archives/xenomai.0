Date: Tue, 11 Nov 2014 12:09:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141111110937.GY17476@sisyphus.hd.free.fr>
References: <CAJt3u5nf_epaPjW=dAjqGMq85dgRYqwn-MKcRGFWby+MXtvong@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJt3u5nf_epaPjW=dAjqGMq85dgRYqwn-MKcRGFWby+MXtvong@mail.gmail.com>
Subject: Re: [Xenomai] USB3.0 drivers for xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Madan Sondur <sondur.madan23@gmail.com>
Cc: xenomai@xenomai.org

On Tue, Nov 11, 2014 at 09:03:27AM +0530, Madan Sondur wrote:
> Hi all,
> 
> Are there any USB 3.0 drivers for xenomai 2.6.2.1. If so where can i get
> them and how to install ? Can you please help?
> 
> Below is my system configuration:
> 
> Core i7 processor with Gigabyte motherboard having USB 3.0 using Intel
> Chipset 8 series. I have installed xenomai 2.6.2.1 on Ubuntu 12.04 64bit.

First of all, if you are starting to work with xenomai, you should
not install an old version such as 2.6.2.1, you should install the
latest stable version, which is 2.6.4.

As for support for USB 3.0 drivers, to my knowledge, there are none.
Note however that most USB3.0 devices are USB2.0 compatible, and if
you are after latency and not bandwidth, it should not matter that
much. If you are after bandwidth, then why looking for a Xenomai
driver?

-- 
					    Gilles.

