MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Sep 2014 11:26:39 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <CANdzn7OYs4n0qjvpdKXM72cZM=AMy_1sBEVP7_P8S-56FJot3A@mail.gmail.com>
References: <CANdzn7OYs4n0qjvpdKXM72cZM=AMy_1sBEVP7_P8S-56FJot3A@mail.gmail.com>
Message-ID: <0d060e3cb01fa61faf28a22cf770bfd7@grandegger.com>
Subject: Re: [Xenomai] Xenomai and CAN
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jason Sarantopoulos <jasonsaras@gmail.com>
Cc: xenomai@xenomai.org

On Mon, 29 Sep 2014 11:52:37 +0300, Jason Sarantopoulos
<jasonsaras@gmail.com> wrote:
> Hi,
> 
> I want to use the xeno-drivers and use the programs
> /usr/xenomai/bin/rtcansend and rtcanrecv in order to communication via
> CANbus. I got a PCAN-PCI card, ubuntu 12.04 32bit, xenomai: 2.6.3 and
> kernel: 3.8.13.
> 
> My question is: should I make a special configuration before building
the
> kernel or should I just enable: "Real Time subsystem>Drivers>CAN
drivers>
> RT-Socket CAN" from menuconfig? The PCI support is already enabled.
> 
> Bear in mind that I copied the config file from my current vanilla
kernel
> 3.11.0-26-generic inside linux-3.8.13 directory.

Only the Linux or Xenomai CAN driver can grab the device. If Linux already
occupies the device you can unbind it before loading the Xenomai driver.

Wolfgang.

