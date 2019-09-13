Subject: Re: Warning from drvlib.c:1349 rtdm_mutex_timedlock
References: <297954754.5119650.1568386690979.JavaMail.zimbra@wolfram.com>
 <6073a207-1fd8-09dc-9604-ebc484dc0878@siemens.com>
 <13878366.5135445.1568390075224.JavaMail.zimbra@wolfram.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <dc984f9a-a7d2-c40e-f435-8ba1bacc80db@siemens.com>
Date: Fri, 13 Sep 2019 18:00:25 +0200
MIME-Version: 1.0
In-Reply-To: <13878366.5135445.1568390075224.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Per Oberg <pero@wolfram.com>
Cc: xenomai <xenomai@xenomai.org>

On 13.09.19 17:54, Per Oberg wrote:
> 
> ----- Den 13 sep 2019, på kl 17:02, Jan Kiszka jan.kiszka@siemens.com skrev:
> 
>> On 13.09.19 16:58, Per Oberg via Xenomai wrote:
>>> Dear all
> 
>>> I'm trying to figure out the significance and meaning of the following warning,
>>> see [1] below . It's from when using the peak-linux-driver for their CAN
>>> devices.
> 
>>> This warning happens every time my software opens or closes a rtdm/pcanx device.
>>> I briefly touched upon this when talking to peak about other issues and got the
>>> impression that they hadn't seen it themselves.
> 
>>> Everything is working just fine with full speed and real time performance so
>>> there is no major problems that I can see. I use Yocto and thus have a quite
>>> complicated build setup which can perhaps make things slip through, so I was
>>> wondering if error in build flags could be the reason for this warning. The
>>> code calls a library (pcanlib) which in turn makes the syscall, so I was
>>> thinking that perhaps there be a problem with the linking of this library?
> 
>>> Any ideas?
> 
> 
>>> [1]
>>> ------------------------------------------------------------------------------------------------------------------------------------------------------
>>> [357740.718504] WARNING: CPU: 1 PID: 1993 at
>>> /usr/src/kernel/kernel/xenomai/rtdm/drvlib.c:1349
>>> rtdm_mutex_timedlock+0x43/0x2f0
>>> [357740.718505] Modules linked in: pcan(O) rtudp rtipv4 intel_powerclamp
>>> intel_rapl i915 coretemp rt_igb e1000e rtnet video fan thermal_sys [last
>>> unloaded: pcan]
>>> [357740.718516] CPU: 1 PID: 1993 Comm: pcanfdtst Tainted: G W O
>>> 4.9.90-xeno-cobolt #1
>>> [357740.718517] Hardware name: Default string Default string/SKYBAY, BIOS
>>> 5.0.1.1 04/18/2016
>>> [357740.718518] I-pipe domain: Linux
>>> [357740.718519] ffffc90005e0fd18 ffffffff81446e18 0000000000000000
>>> 0000000000000000
>>> [357740.718522] ffffffff81bb1370 ffffc90005e0fd58 ffffffff810785d1
>>> 0000054505e0fdb0
>>> [357740.718524] ffff880262a93000 ffff88024a342800 0000000000000002
>>> ffff880262a93380
>>> [357740.718527] Call Trace:
>>> [357740.718530] [<ffffffff81446e18>] dump_stack+0xbf/0xe7
>>> [357740.718533] [<ffffffff810785d1>] __warn+0xe1/0x100
>>> [357740.718534] [<ffffffff810786bd>] warn_slowpath_null+0x1d/0x20
>>> [357740.718536] [<ffffffff81170c43>] rtdm_mutex_timedlock+0x43/0x2f0
>>> [357740.718538] [<ffffffff81170f02>] rtdm_mutex_lock+0x12/0x20
>>> [357740.718542] [<ffffffffa06ab2ee>] pcan_open_nrt+0x6e/0x130 [pcan]
> 
>> You are taken a sleepy RT lock (mutex) over a non-RT context (open). That does
>> not work.
> 
>> Either use a rtdm_lock_t or a different context.
> 
> So, definitely something in the driver-code then?

Yes, the driver is broken.

> 
> I'm guessing that open is always non-rt and therefore a rtdm_lock should be used? (I remember seeing that in the peak-can code, but wrapped in ifdefs depending on build case....)

This depends. If the open code needs to synchronize only with other non-RT 
paths, normal Linux locks are fine. If there is the need to sync with the 
interrupt handler or some of the _rt callbacks, rtdm_lock & Co. is needed.

Do you need anything special from that driver, or would the standard CAN drivers 
with socket model that we have also for (some) Peak hardware work? From QA 
perspective, upstream is usually better than vendor drivers.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

