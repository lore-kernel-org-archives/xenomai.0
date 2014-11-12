Date: Wed, 12 Nov 2014 15:10:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141112141040.GR17476@sisyphus.hd.free.fr>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPRPZsAHXt9cFWeduwziZ=iTpDg7KikrMw+HEuTi5eJ72gkztA@mail.gmail.com>
Subject: Re: [Xenomai] USB3.0 drivers for xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Nov 12, 2014 at 10:21:14AM +0100, Jeroen Van den Keybus wrote:
> > > Yes, I am looking for full bandwidth speeds offered by USB3.0 which is
> > upto
> > > 5Gbps. However the HDD portable device is recognising as only as USB 2.0
> > > and the data speed is only upto 45MBps.
> >
> > Well to get USB3 you need a USB3 controller, USB3 device, USB3 cable,
> > and USB3 driver running the port.  If any of those is missing, the speed
> > drops to one of the older versions.
> 
> 
> And you need to actually provide the data at these speeds too. I would be
> surprised to see a SATA disk being able to keep up with 5 Gbps. We did not
> observe a doubling of the disk transfer speeds when going from SATA I to
> SATA II, did we ?

There are very fast SATA SSD.

-- 
					    Gilles.

