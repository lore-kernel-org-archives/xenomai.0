Message-ID: <505F234B.6070208@wanadoo.fr>
Date: Sun, 23 Sep 2012 16:57:15 +0200
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
References: <505EB99F.7050705@wanadoo.fr> <505EBD61.1050009@wanadoo.fr>
	<505F0D40.9030105@xenomai.org>
In-Reply-To: <505F0D40.9030105@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Target frozen with rtcan_virt
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

Gilles,

thanks for your advice.

I do not mind using the versatile express especially for emulation, I only want a board with a cortex A9
that boots in qemu, with a linux kernel >= 3.2, and an available ipipe patch.

Unfortunately qemu does not support the IMX6 yet, which is the board I aim, so I have to cope with another one.

If you have a board name that is already fully supported and that fits my needs,
please tell me and I will use it with pleasure.

Meanwhile I have set  CONFIG_SMP to "no", and my recv program now just works fine.

I have not been able to identify (in the CONFIG_SMP=y case) the difference between
"rtcanrecv" and my recv program, that may make behave differently (freeze or not) but
only the footprint.

cheers,
Thierry

Le 23/09/2012 15:23, Gilles Chanteperdrix a écrit :

> On 09/23/2012 09:42 AM, Thierry Bultel wrote:
>
>> Hi,
>>
>> My configuration is linux-3.2.21+ipipe-core-3.2.21-arm-1.patch,
>> running in qemu 1.2.0 for versatile express. I have CONFIG_SMP but
>> qemu is launched with 1 core only (else it does not boot, keeps hung
>> just after "booting the kernel", but that is not the point here).
>
> Basically, versatile express is not a board supported by the I-pipe
> patch, so, the first thing is to check that the I-pipe port is working
> correctly. For instance, I would run tsc -w first to see if the tsc
> emulation is working correctly. Then you can use this document:
>
> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting
>
> As a check list.
>
> Also, some modifications would be needed to get it working in SMP mode.
> This should be much easier to start with the I-pipe kernel for 3.4,
> except for the "global timer" which seems not to be present on versatile
> express, so, some code would be needed to skip the initialization in
> gt_setup when we detect a processor that does not have a global timer.
>


