Date: Wed, 12 Nov 2014 15:08:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141112140851.GQ17476@sisyphus.hd.free.fr>
References: <CADLCHMKp3ohhHQrstXOyf0ys1ev3CY=KQScYhvB=P9ANqy8agA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADLCHMKp3ohhHQrstXOyf0ys1ev3CY=KQScYhvB=P9ANqy8agA@mail.gmail.com>
Subject: Re: [Xenomai] Using RTDM module
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Seda Seda <seda9seda9@gmail.com>
Cc: xenomai@xenomai.org

On Wed, Nov 12, 2014 at 01:29:23AM +0200, Seda Seda wrote:
> Hello, I have a gpio module device and it creates dev/ttyACM0 file when I
> attach to my pc using a mini usb cable.Also I don't have source of
> devices.

I do not know what you mean by "I don't have source of devices", but
the sources of the driver which creates /dev/ttyACM0 are well known,
it is the drivers/usb/class/cdc-acm.c file in kernel sources, which
implements the driver for the USB communication device class.


> I want to code a rtdm driver for this device. To communicate with
> the device on real time, what should I do?

First you have to get the communication with this USB device to work
in real-time. For that you would use either of the two known USB
stacks for Xenomai:

http://sourceforge.net/projects/usb4rt.berlios/
http://sourceforge.net/projects/usb20rt.berlios/

And "port" the cdc-acm.c code to that stack, if it is not already
part of it.

When you have that working, I suppose you want a driver which sends
commands and receive answers from the ttyACM driver, to drive the
GPIOs (but you did not say). It is possible with RTDM using the 
rt_dev_open/rt_dev_close/rt_dev_read/rt_dev_write from a kernel
module.

Now, there is something I do not understand, from a previous post,
you said you already had a driver which created a ttyACM0 device,
but that that driver returned you a "Cannot allocate memory", which
is ENOMEM. 

But since you did not tell us what returns ENOMEM, if
happens when loading the module, or when opening it, or when writing
to it, my answer to you was that we did not have enough information.

Maybe you could follow up on that question instead of coming with a
completely new question? Answering questions you are asked with
other completely unrelated questions makes me want to simply ignore
your mails.

-- 
					    Gilles.

