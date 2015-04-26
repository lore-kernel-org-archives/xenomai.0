Message-ID: <553D4E9F.2060907@grandegger.com>
Date: Sun, 26 Apr 2015 22:46:23 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <CADvZd9a0UuoQx-g0N5YFbxEMajgSohyQ7U-8BbA+Ay9kpOrqGw@mail.gmail.com>
In-Reply-To: <CADvZd9a0UuoQx-g0N5YFbxEMajgSohyQ7U-8BbA+Ay9kpOrqGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: Michael Haberler <haberlerm@gmail.com>, xenomai <xenomai@xenomai.org>

Hi Michael,

thanks for your contribution. Could you please send it as inline patch
to this mailing list to simplify the review and integration.

Thanks,

Wolfgang.


On 04/20/2015 01:01 AM, Michael Haberler wrote:
> here is the RT-CAN driver by Steve Battazzo for (among others) the
> Beaglebone: https://github.com/mhaberler/xeno_d_can/commits/for-xenomai-2
> 
> I've reconstructed the history as Steve based this on the 3.8 c_can driver.
> The problems Steve originally noted are resolved.
> 
> Please let me know if anything is missing for a merge into Xenomai 2.
> 
> - Michael
> 
> 
> Usage:
> 
> blacklist the Linux drivers in /etc/modprobe.d/can-blackist.conf:
> 
> blacklist c_can_platform
> 
> blacklist c_can
> 
> blacklist can_dev
> 
> 
> enable the can pins using the universal overlay (
> https://github.com/cdsteinkuehler/beaglebone-universal-io)
> 
> 
> config-pin overlay cape-universal
> 
> config-pin P9.24 can
> 
> config-pin P9.26 can
> 
> 
> # load the rtcan mods
> 
> modprobe xeno_can
> 
> modprobe rtcan_can
> 
> 
> # start the rtcan interface
> 
> rtcanconfig rtcan1 -b 1000000 start
> 
> rtcansend rtcan1 --verbose --identifier=0x1  0x04 0x01 0x00 0x00 0x0f 0xff
> 0xe7 0x00
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 
> 


