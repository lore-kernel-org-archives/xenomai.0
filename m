Message-ID: <5055E11A.4000405@web.de>
Date: Sun, 16 Sep 2012 16:24:26 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <CC77AC90.21DF3%glen@jetsoftdev.com>
In-Reply-To: <CC77AC90.21DF3%glen@jetsoftdev.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] USB 3.0 on Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Glen Wernersbach <glen@jetsoftdev.com>
Cc: xenomai@xenomai.org

On 2012-09-13 21:30, Glen Wernersbach wrote:
> Hi All,
> =

> Back to this question.
> =

> If I wanted to write a very specific one trick pony RTDM driver for a USB
> 3.0 controller that would do basic read and writes to my vendor specific
> device where would I start?

Well, by reading the xHCI spec ;). Seriously, USB is not UART. There has
quite a lot of hard- and software between a serial data stream on the
device side and a potential rtserX RTDM interface for a Xenomai
application. To get an impression, you can study usb4rt [1].

We are about to add a cdc-acm driver to that stack, also "only" a simple
serial interface but still a bit of code. And we are reusing the
existing UHCI host controller + core stack.

Are you sure your device makes use of USB-3.0's super speed? Or does
your target only include an xHCI, and there is no way to add a good-old
UHCI to it?

Jan

[1] http://developer.berlios.de/projects/usb4rt

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20120916/d6b057f=
4/attachment.pgp>
