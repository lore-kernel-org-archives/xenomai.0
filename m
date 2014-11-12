From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Tue, 11 Nov 2014 23:22:50 -0500
Message-ID: <20141112042250.GF24110@csclub.uwaterloo.ca>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJt3u5=nBbiqOZ6kFsXujHtbGyz6GhQO10F-=rpc0WpXFj+zZw@mail.gmail.com>
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

On Tue, Nov 11, 2014 at 10:29:37PM +0530, Madan Sondur wrote:
> Yes, I am looking for full bandwidth speeds offered by USB3.0 which is upto
> 5Gbps. However the HDD portable device is recognising as only as USB 2.0
> and the data speed is only upto 45MBps.

Well to get USB3 you need a USB3 controller, USB3 device, USB3 cable,
and USB3 driver running the port.  If any of those is missing, the speed
drops to one of the older versions.  I have seen cases where a device
connected at boot time was grabbed by the EHCI driver before the
XHCI driver was done initializing, and hence became a USB2 device.
Unplugging it and plugging it back in again made it USB3.  Quite annoying.

> I have heard there are some in consisitencies in USB3.0 driver
> implementation in linux. The USB3.0 driver uses xHCI where as the USB2.0
> uses eHCI.

XHCI is the standard interface to a USB3 controller.  Most seem to
implement that standard.

EHCI is USB 2.0 standard interface.

OHCI and UHCI were two different standards for USB 1.x interfaces.
Some vendors used one, some used the other.

Some USB controllers of course have their own interfaces, although
I have never seen any that wasn't much worse than the ones using the
standard interfaces.

-- 
Len Sorensen

