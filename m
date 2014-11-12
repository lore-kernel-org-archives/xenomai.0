MIME-Version: 1.0
In-Reply-To: <20141112042250.GF24110@csclub.uwaterloo.ca>
References: <CAJt3u5nf_epaPjW=dAjqGMq85dgRYqwn-MKcRGFWby+MXtvong@mail.gmail.com>
 <20141111110937.GY17476@sisyphus.hd.free.fr>
 <20141111153745.GX24110@csclub.uwaterloo.ca>
 <20141111154611.GD17476@sisyphus.hd.free.fr>
 <20141111155212.GZ24110@csclub.uwaterloo.ca>
 <20141111155447.GE17476@sisyphus.hd.free.fr>
 <20141111155642.GA24110@csclub.uwaterloo.ca>
 <20141111160236.GF17476@sisyphus.hd.free.fr>
 <20141111161744.GB24110@csclub.uwaterloo.ca>
 <CAJt3u5=nBbiqOZ6kFsXujHtbGyz6GhQO10F-=rpc0WpXFj+zZw@mail.gmail.com>
 <20141112042250.GF24110@csclub.uwaterloo.ca>
Date: Wed, 12 Nov 2014 10:21:14 +0100
Message-ID: <CAPRPZsAHXt9cFWeduwziZ=iTpDg7KikrMw+HEuTi5eJ72gkztA@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
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
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> > Yes, I am looking for full bandwidth speeds offered by USB3.0 which is
> upto
> > 5Gbps. However the HDD portable device is recognising as only as USB 2.0
> > and the data speed is only upto 45MBps.
>
> Well to get USB3 you need a USB3 controller, USB3 device, USB3 cable,
> and USB3 driver running the port.  If any of those is missing, the speed
> drops to one of the older versions.


And you need to actually provide the data at these speeds too. I would be
surprised to see a SATA disk being able to keep up with 5 Gbps. We did not
observe a doubling of the disk transfer speeds when going from SATA I to
SATA II, did we ?

Incidentally, look at the fairly low performance drop (10..15%) when
running a PCIe Gen 3 x16 video card in Gen 2 x8 mode.

Low latency USB interrupt packets abort the normal asynchronous data flow.
The transmission of the affected packet must be rescheduled and I believe
it is up to the device and its driver to take care of this.


Jeroen.
