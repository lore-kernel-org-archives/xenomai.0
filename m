MIME-Version: 1.0
Date: Mon, 29 Sep 2014 11:52:37 +0300
Message-ID: <CANdzn7OYs4n0qjvpdKXM72cZM=AMy_1sBEVP7_P8S-56FJot3A@mail.gmail.com>
From: Jason Sarantopoulos <jasonsaras@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Xenomai and CAN
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I want to use the xeno-drivers and use the programs
/usr/xenomai/bin/rtcansend and rtcanrecv in order to communication via
CANbus. I got a PCAN-PCI card, ubuntu 12.04 32bit, xenomai: 2.6.3 and
kernel: 3.8.13.

My question is: should I make a special configuration before building the
kernel or should I just enable: "Real Time subsystem>Drivers>CAN drivers>
RT-Socket CAN" from menuconfig? The PCI support is already enabled.

Bear in mind that I copied the config file from my current vanilla kernel
3.11.0-26-generic inside linux-3.8.13 directory.

Best Regards

-- 
*Jason Sarantopoulos*
