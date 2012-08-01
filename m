From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Wed, 1 Aug 2012 09:57:20 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201208010957.20988.leo@alaxarxa.net>
Subject: [Xenomai] libusb devices with a xenomai kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hi,

we have a box that is running Xenomai 2.6.1 in a amd4 cpu. We have a usb 
camera with a program that reads an image as fast it cans. It's executed as a 
normal Linux task. 

We have also some tasks that use libxenomai within a realtime context. We have 
realized that the usb device has some kind of strange behavior and it's 
disconnected or simple sometimes spend too much time to acquire a image.

The question is, someone of you have experienced similar problems? or have we 
have to implement any special protection when we want to use a usb device 
(with libusb) using a Xenomai kernel? 

We don't pretend to have a realtime usb, just a "similar" use that if we use 
the same code in a normal Linux kernel.

Thanks in advance,

Leo

-- 
--
Linux User 152692
Catalonia

