From: Wojciech Domski <wojciech.domski@gmail.com>
Message-ID: <5526CD6D.5050500@gmail.com>
Date: Thu, 09 Apr 2015 21:05:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Writing RTDM driver for multiple PCI cards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear All,

I would like to write an another driver for a PCI card.
I have encountered an issue, however. I have some experience with
writing RTDM drivers but
for a single PCI card.

Now I would like to write a driver which would support multiple PCI
cards. How should I do that?

For example when writing a character device driver for standard Linux
kernel we can use something
like alloc_chrdev_region() or register_chrdev_region(). In those
functions one of the parameters is
count which refers to the number of devices. If I am not mistaken those
devices will be available
under /dev/device1, /dev/device2 and so on.

What kind of mechanic should I use to achieve similar result with RTDM.
One difference is that in RTDM I do not have those devices under /dev
but they
are registered under some device name space in Xenomai which handles this.
Is there a way to make one driver with name ex. MyDev for 3 devices
and access them by passing MyDev1, MyDev2 or MyDev3 to rt_dev_open()?

Best regards,

-- 
Wojciech Domski

Domski.pl

Wojciech.Domski.pl


