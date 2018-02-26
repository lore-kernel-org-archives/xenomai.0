MIME-Version: 1.0
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Mon, 26 Feb 2018 16:29:02 +0530
Message-ID: <CAOuPNLjwrgQu2wEd+pcNrcka6J9PJZJceh6UvhaXZy_tZ=8C0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] [RTDM/rt-serial] How to verify 16550A on Ubuntu desktop
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@web.de>, Philippe Gerum <rpm@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>

Hi,

I have enabled RTDM serial driver 16550A in kernel and I am using it
with x86-64 Ubuntu 16.04 desktop.
CONFIG_XENO_DRIVERS_16550A=y
CONFIG_XENO_DRIVERS_16550A_PIO=y

Now I wanted to verify this driver using a sample application such as
: cross-link
But, when I check, the driver is not available under: /dev/rtdm/
(rtser0, rtser1)

Is it possible to use this RT serial driver on Ubuntu PC?
Please let me know how to install this driver and verify it.

I wanted to modify some part in the driver and verify it.

Need your initial support please!


Thanks,
Pintu

