Message-ID: <5043F063.2020302@ebus.com>
Date: Sun, 02 Sep 2012 16:48:51 -0700
From: Doug Brunner <dbrunner@ebus.com>
MIME-Version: 1.0
References: <50405C4F.5030301@ebus.com> <50406A3D.4080801@xenomai.org>
In-Reply-To: <50406A3D.4080801@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Upgrading to Xenomai 2.6.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 08/31/2012 12:39 AM, Gilles Chanteperdrix wrote:
> On 08/31/2012 08:40 AM, Doug Brunner wrote:
>
>> I've been having a very hard time with the upgrade from Xenomai 2.6.0 to
>> 2.6.1--hoping someone might have a suggestion for me. My thinking was
>> that, to get the most possible bug fixes, I should also upgrade to the
>> latest kernel for which there is a stable I-pipe patch, which appears to
>> be 3.2.21 from examining the list of available patches distributed with
>> Xenomai.
>>
>> Unfortunately, 3.2.21 (even unmodified, using a vanilla Debian kernel
>> config, set for 586 cpu type) will not boot on my target platform
>> (Winsystems PPM-LX800-G, which has a Geode LX800 CPU). It immediately
>> resets after "Loading initial ramdisk", without even any early printk
>> output. I have no idea what could be causing that :(
>
> Ok. I have just booted my geode with 3.4, both with 586 cpu type without
> tsc and with geode cpu type with tsc. The kernel boots and the latency
> test starts. So, I guess you selected a kernel configuration option we
> do not support (such as CONFIG_KGDB).
>
> You can download the configuration which works for me here:
> http://xenomai.org/~gch/config-geode
>
Argh...the problem was apparently that I'd left SMP support selected. 
Thanks for your config! It's a nice bare-bones kernel and boots my Geode 
as well so I'm using it as a new starting point.

I saw an email from you on 8/3 referring to a regression connected to 
irq_hold that was fixed in your git. Should I get an I-pipe patch from 
there, or from git.denx.de/ipipe.git instead of using the one 
distributed with 2.6.1?

Thanks,
     --Doug Brunner

