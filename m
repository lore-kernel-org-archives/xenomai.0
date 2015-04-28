Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
From: Michael Haberler <haberlerm@gmail.com>
In-Reply-To: <553D4E9F.2060907@grandegger.com>
Date: Tue, 28 Apr 2015 16:01:24 +0200
Message-Id: <CA4FDA06-6595-4656-AE7A-A9092F103B98@gmail.com>
References: <CADvZd9a0UuoQx-g0N5YFbxEMajgSohyQ7U-8BbA+Ay9kpOrqGw@mail.gmail.com>
 <553D4E9F.2060907@grandegger.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RT-CAN driver for C_CAN,D_CAN cores ready
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: xenomai <xenomai@xenomai.org>


> Am 26.04.2015 um 22:46 schrieb Wolfgang Grandegger <wg@grandegger.com>:
> 
> Hi Michael,
> 
> thanks for your contribution. Could you please send it as inline patch
> to this mailing list to simplify the review and integration.
> 
> Thanks,
> 
> Wolfgang.

Here it is:

https://github.com/mhaberler/xenomai-2.6/commits/bbcan :

027e3551a4d6aeca201ce92c66a3808b332ff9da Merge remote-tracking branch 'xenocan/for-xenomai-2' into bbcan
8740cfe7fd960727ad3e993da5366c88e2280264 xeno_d_can: RTDM driver for Bosch CCAN and DCAN peripherals
fbe3b224501e091d26275b45e2cf0881d94997dd rename original files to match Steve's naming
84badf976ed149a352cbb34edc329685aaacb531 as from 3.8
fe59354a1ed2ee2cff65d17f2cb249292c647e57 drivers/analogy: remove unnecessary spinlock


-------------- next part --------------
A non-text attachment was scrubbed...
Name: xeno-c_can.patch
Type: application/octet-stream
Size: 224496 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150428/72323552/attachment.obj>
-------------- next part --------------


> 
> On 04/20/2015 01:01 AM, Michael Haberler wrote:
>> here is the RT-CAN driver by Steve Battazzo for (among others) the
>> Beaglebone: https://github.com/mhaberler/xeno_d_can/commits/for-xenomai-2
>> 
>> I've reconstructed the history as Steve based this on the 3.8 c_can driver.
>> The problems Steve originally noted are resolved.
>> 
>> Please let me know if anything is missing for a merge into Xenomai 2.
>> 
>> - Michael
>> 
>> 
>> Usage:
>> 
>> blacklist the Linux drivers in /etc/modprobe.d/can-blackist.conf:
>> 
>> blacklist c_can_platform
>> 
>> blacklist c_can
>> 
>> blacklist can_dev
>> 
>> 
>> enable the can pins using the universal overlay (
>> https://github.com/cdsteinkuehler/beaglebone-universal-io)
>> 
>> 
>> config-pin overlay cape-universal
>> 
>> config-pin P9.24 can
>> 
>> config-pin P9.26 can
>> 
>> 
>> # load the rtcan mods
>> 
>> modprobe xeno_can
>> 
>> modprobe rtcan_can
>> 
>> 
>> # start the rtcan interface
>> 
>> rtcanconfig rtcan1 -b 1000000 start
>> 
>> rtcansend rtcan1 --verbose --identifier=0x1  0x04 0x01 0x00 0x00 0x0f 0xff
>> 0xe7 0x00
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> http://www.xenomai.org/mailman/listinfo/xenomai
>> 
>> 

