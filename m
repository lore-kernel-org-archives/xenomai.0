MIME-Version: 1.0
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Mon, 26 Feb 2018 16:56:28 +0530
Message-ID: <CAOuPNLjTo8E7z=11ip8Dtjvt2dm=PU-+9urgwn8qgYCEcyxmMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] [RTDM] Converting existing Linux char driver to rtdm
	driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@web.de>, Jan Kiszka <jan.kiszka@siemens.com>, Greg Gallagher <greg@embeddedgreg.com>, Philippe Gerum <rpm@xenomai.org>

Hi,

I have a sample linux char driver which I am registering using normal
misc_register/deregister function.
In this driver, I have used, open, read, write, ioctl, release system calls.

Now I wanted to convert this driver to RTDM interface and compare it.
Later I wanted to add some more use cases related to interrupt
processing by connecting some external peripheral.

Firstly, please guide me how to easily convert an existing linux char
driver to RTDM model.


Thank You!

Regards,
Pintu

