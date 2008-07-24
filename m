Message-ID: <48884DA1.400@domain.hid>
Date: Thu, 24 Jul 2008 11:38:41 +0200
From: Antoine Nourry <nourry@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] RTDM & USB4RT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all,

I'm still working on a real-time port of an USB driver for a DAQ device. 
I looked at USB20RT real-time stack that proposed USB 2.0 support but it 
is not in activity anymore. Moreover it used an RTDM USB skeleton driver 
taken from a popular linux native one. My original device driver is 
written thanks to this skeleton, so the port would have been pretty simple.

Now i was wondering if USB4RT could use RTDM the same way, ie, with 
traditionnal FOPS (read, write, ioctl, etc) (original driver here :
https://mail.gna.org/public/xenomai-help/2008-07/msg00068.html ) since 
for the moment i don't really understand rt_usbping example.

Is anyone here has ever written a driver with this stack ?

Thanks,
Antoine


