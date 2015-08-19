References: <55D36A9E.6030809@xenomai.org>
 <466299436.7725534.1440001753062.JavaMail.yahoo@mail.yahoo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55D4B0F0.3020003@xenomai.org>
Date: Wed, 19 Aug 2015 18:38:08 +0200
MIME-Version: 1.0
In-Reply-To: <466299436.7725534.1440001753062.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xeno 3-rc7 : rtcanconfig fails to set baudrate
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik_bayart@yahoo.co.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/19/2015 06:29 PM, Frederik Bayart wrote:
>> On Tuesday, 18 August 2015, 19:25, Philippe Gerum <rpm@xenomai.org> wrote:
>>> On 08/18/2015 06:26 PM, Frederik Bayart wrote:
>>
>>> I have build xeno-3.0.rc7 with kernel 3.18.12.
>>> I have a PEAK-PCIe CAN card in my system.
>>> Drivers are loaded and rtcan0 en rtcan1 are created in /proc/rtcan.
>>>
>>> However, I'm not able to set the baudrate when I'm execute 'rtcanconfig rtcan0 -v -b 1000000 start'
>>> By adding debug statements in rtcanconfig, I found that ioctl(can_fd, SIOCSCANBAUDRATE, &u.ifr); fails,
>>> errno gives : SIOCSCANBAUDRATE(errno=19): No such device
>>> Below the output of rtcan0/info and xeno-config --info
>>> Any suggestions ?
>>
>> This error is documented, I would check ->ifr_name in the request block:
>>
>> http://www.xenomai.org/documentation/xenomai-3/html/xeno3prm/group__rtdm__can.html#ga7c070037c218b40de849ebf4d299f977
>>
>> -- 
>> Philippe.
> 
> 
> The problem was that the interface name was overwritten by the baudrate. The problem is caused by use of
> 
> union {
> struct ifreq ifr;
> struct can_bittime bittime;
> can_baudrate_t baudrate;
> can_ctrlmode_t ctrlmode;
> can_mode_t mode;
> } u;
> 
> I think the intention was to put struct ifreq.ifr_ifru in the union. But I think the union above doesn't work because struct ifreq has first member ifr_ifrn

I broke this code:

commit 78e77431163e35a3dafb30c86cc71fa167c7faa2
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Thu Dec 1 19:02:42 2011 +0100

    utils/rtcanconfig: fix aliasing

But we can't just revert it, the data aliasing is wrong. I'll have a
look, thanks for the debug work.

-- 
Philippe.

