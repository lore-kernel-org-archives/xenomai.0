MIME-Version: 1.0
In-Reply-To: <0d060e3cb01fa61faf28a22cf770bfd7@grandegger.com>
References: <CANdzn7OYs4n0qjvpdKXM72cZM=AMy_1sBEVP7_P8S-56FJot3A@mail.gmail.com>
 <0d060e3cb01fa61faf28a22cf770bfd7@grandegger.com>
Date: Mon, 29 Sep 2014 15:09:04 +0300
Message-ID: <CANdzn7PYpjy-4h5upYf=39L-t+5dSQ0W1h6oW+UOHGJ+2=XJcg@mail.gmail.com>
From: Jason Sarantopoulos <jasonsaras@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai and CAN
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: xenomai@xenomai.org

>Only the Linux or Xenomai CAN driver can grab the device. If Linux already
>occupies the device you can unbind it before loading the Xenomai driver.

Hi Wolfgang Grandegger,

I think I didn't understand your response. What I wanted to ask was what I
need to do to use xeno-can. I followed the instructions for building and
installing a kernel from here:
http://xenomai.org/2014/06/building-debian-packages

I configured the kernel disabling what xenomai.org recommends and enabling
Real time support for Socket CAN.

Then (booted on new kernel) I installed the user space support with this:
./configure
make
make install

What is not working is when I use the /usr/xenomai/bin/rtcansend I cannot
communicatie through CANbus. I have a PEAK PCAN-PCI adapter installed and I
used the following commands in order to send some CAN messages to a robot
to open a channel:

./rtcanrecv rtcan0

But I have this response:

rt_dev_ioctl GET_IFINDEX: No such device

My system does not see the PCI card for a reason.

Regards,

-- 
*Jason Sarantopoulos*
