References: <55E9C465.2020500@xenomai.org> <55ED3E6A.1090803@grandegger.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55ED4A7D.50706@xenomai.org>
Date: Mon, 7 Sep 2015 10:27:41 +0200
MIME-Version: 1.0
In-Reply-To: <55ED3E6A.1090803@grandegger.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [xenomai3] fixing the rtcan_raw ioctl argument issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>


Hi Wolfgang,

On 09/07/2015 09:36 AM, Wolfgang Grandegger wrote:
> Hi Philippe,
> 
> Am 04.09.2015 um 18:18 schrieb Philippe Gerum:
>>
>> We have a problem with CAN control requests piggybacking on struct ifreq
>> for passing arguments to the raw driver. This is unsafe, since we have
>> no mean to relate sizeof(ifr.ifr_ifru) to the actual size required to
>> pass the CAN-related arguments to the ioctl handler, so we are currently
>> hopping for the best.
>>
>> In addition, all rtcan utilities are causing recent compilers here to
>> complain loudly about potential aliasing issues when mapping those
>> arguments over the ifr_ifru area using casts, which is unfortunately
>> true.
>>
>> So I came up with a general fix, introducing struct can_ifreq for this
>> purpose. Applications passing struct ifreq should still work (well, that
>> is the plan) since sizeof(struct ifreq) >= sizeof(struct can_ifreq) and
>> all member offsets within ifr_ifru have been preserved. Could the CAN
>> maintainers please review this code and comment?
>>
>> Thanks,
>>
>> http://git.xenomai.org/xenomai-3.git/commit/?h=next&id=5460e09d0f990799fb2eed67fbb00358860ebcab
>>
> 
> Looks good at a first glance and you fixed a repeated patterns as well.
> Just "demo/posix/can_rtt.c" should be adapted as well. Has it been

Ok.

> tested on real CAN hardware? Unfortunately, I currently do not have
> usable CAN hardware at hand to do it myself, sorry.
> 

I will test this on imx6q flexcan hardware.

-- 
Philippe.

