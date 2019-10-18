Subject: Re: RTnet default behavior
References: <b89e46e4-45b8-1fc1-cb0d-2c4d44b07eb7@compador.de>
 <5b5bb644-2f40-dc2b-0414-a25c35ecffbd@siemens.com>
 <019c5a8c-edb1-2c8c-247e-e0fb3fb2d4fd@compador.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4aaaeafc-62f8-e37f-5235-8ad1479c30b1@siemens.com>
Date: Fri, 18 Oct 2019 16:57:29 +0200
MIME-Version: 1.0
In-Reply-To: <019c5a8c-edb1-2c8c-247e-e0fb3fb2d4fd@compador.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johannes Holtz <johannes.holtz@compador.de>, xenomai@xenomai.org

On 18.10.19 16:47, Johannes Holtz via Xenomai wrote:
> Am 18.10.19 um 16:33 schrieb Jan Kiszka:
>> On 18.10.19 16:10, Johannes Holtz via Xenomai wrote:
>>> Hi ,
>>>
>>> I inherited a project where the RTnet stack is loaded manually at boot
>>> time. To be specific. Instead of using the rtnet command line programs
>>> the rtnet.ko kernel object as well as the necessary drivers are loaded
>>> with insmod. The devices are then brought up with rtifconfig and
>>> rtroute.
>>>
>>> The network consist of 7 PCs (all with the same boot time mechanism)
>>> with pre-defined IPs. The setup works and initializes in an
>>> asynchronized way (like a typical non-RT network).
>>>
>>> I'm investigating some performance problems and I don't know whats is
>>> really going on since no config is used. How is determined which
>>> participant is acting as Master and how the slots are distributed? What
>>> are the default values?
>> You only mentioned rtifconfig and rtroute above, no rtcfg or tdmacfg.
>> Are you sure RTmac is involved?
> 
> This is the list of kernel object that are loaded:
> 
> rtnet.ko
> 
> rtipv4.ko
> 
> rtpacket.ko
> 
> rtudp.ko
> 
> rt_e100e.ko
> 
> rt_8139too.ko
> 
> rt_r8169.ko
> 
> subsequently rtifconfig and rtroute
> 
> Nothing else is done. I don't know id that satisfies for rtmac. How can
> I check?

Nope, there would be rtmac.ko, tdma.ko, possibly also rtcfg.ko in
addition. And you would see the script calling tdmacfg at least.

So, nothing of RTmac should prevent packets from being sent or add size
restrictions on them.

Maybe you can specify your performance problems in more details?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

