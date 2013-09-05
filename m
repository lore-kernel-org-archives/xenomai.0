Message-ID: <5228F853.7020002@wanadoo.fr>
Date: Thu, 05 Sep 2013 23:32:03 +0200
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
References: <51CD5651.6030804@wanadoo.fr> <51D07B48.9060206@xenomai.org>
In-Reply-To: <51D07B48.9060206@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Thermal issue on iMX6q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I have noticed something really weird.
I was using for months the 3.0.43 kernel from ipipe-gch.git

When the target is idle, I mean, with 4 CPUs at almost 0 % load,
the temperature (/sys/class/thermal/thermal_zone0/temp) is about 66 degrees.
(there is no heat spreader).

With each CPU at 100%, the temperature gets over 90 quickly and the 
target reboots.

Since today, I was -at last- able to apply the latest available ipipe patch
(adeos-ipipe-3.0.43) from xenomai-2.6.git head) on the 3.0.35_4.0.0
kernel from Freescale.

With that kernel, in idle, the temperature is only 44 degrees,
with 4 CPUs to 100% the temperature stabilizes at 60 degrees.

I am a little bit puzzled ... I am obviously using the same config in 
both cases.
Does anyone have an idea ?

Cheers
Thierry

Le 30/06/2013 20:39, Gilles Chanteperdrix a écrit :
> On 06/28/2013 11:24 AM, Thierry Bultel wrote:
>
>> I understand that the thermal management is disabled with xenomai,
>> because CPU_FREQ is forbidden.
>
>
> If you are using the Freescale kernel, CPU_FREQ should actually be 
> enabled. But it is true that the frequency should not be changed after 
> Xenomai is started, as Xenomai does not support it. However, if I 
> remember correctly, there was a kernel parameter allowing to select a 
> frequency at boot time.
>


