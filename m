MIME-Version: 1.0
From: =?UTF-8?Q?Geber_Villa_Fern=C3=A1ndez?= <gebervf@gmail.com>
Date: Thu, 27 Apr 2017 11:17:31 +0200
Message-ID: <CAFjt0OkDDODSAjwBC6QJ4wMyae6RnzRhqKhgT7y0qqs1tPwc7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] RPi: Possible solution for freezes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: john.gwynne@matrixresearch.com

I was having the same problem of freezes in RPi (RPi3 in this case) for
quite some time as explained in the following topic (kernel 4.1.21 with
xenomai 3.0.3):
http://www.xenomai.org/pipermail/xenomai/2017-February/037090.html

I think that I achieved to solve the problem by disabling the FIQ
capabilities of the USB driver. There are problems by using the FIQ USB
driver with RT patches as shown in:
https://community.emlid.com/t/rpi-2-fiq-usb-driver-problems/508/8
https://www.raspberrypi.org/forums/viewtopic.php?f=29&t=39951&start=75

The solution is as simple as adding the following parameters in the
"cmdline.txt" file in the boot partition:
dwc_otg.fiq_enable=0 dwc_otg.fiq_fsm_enable=0 dwc_otg.nak_holdoff=0

If these parameters are loaded, introducing "dmesg | grep dwc_otg" in a
terminal (e.g. by SSH) will give you the following information:
[    0.511322] dwc_otg: FIQ disabled
[    0.511327] dwc_otg: NAK holdoff disabled
[    0.511331] dwc_otg: FIQ split-transaction FSM disabled

I was doing several tests which consist of copying several folders with
GBs of data from a PC to the RPi SD through WiFi (using rsync). With the
USB FIQ driver, RPi freezes after some time (less than an hour). Without
the USB FIQ driver, I have not had any freeze at the moment.

More info about this driver (USB FIQ) can be obtained in:
https://www.raspberrypi.org/forums/viewtopic.php?t=70437

Regards,
Geber

