Message-ID: <5228FAE9.4000904@xenomai.org>
Date: Thu, 05 Sep 2013 23:43:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51CD5651.6030804@wanadoo.fr> <51D07B48.9060206@xenomai.org>
	<5228F853.7020002@wanadoo.fr>
In-Reply-To: <5228F853.7020002@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Thermal issue on iMX6q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: xenomai@xenomai.org

On 09/05/2013 11:32 PM, Thierry Bultel wrote:
> Hi,
> 
> I have noticed something really weird.
> I was using for months the 3.0.43 kernel from ipipe-gch.git
> 
> When the target is idle, I mean, with 4 CPUs at almost 0 % load,
> the temperature (/sys/class/thermal/thermal_zone0/temp) is about 66 degrees.
> (there is no heat spreader).
> 
> With each CPU at 100%, the temperature gets over 90 quickly and the 
> target reboots.
> 
> Since today, I was -at last- able to apply the latest available ipipe patch
> (adeos-ipipe-3.0.43) from xenomai-2.6.git head) on the 3.0.35_4.0.0
> kernel from Freescale.
> 
> With that kernel, in idle, the temperature is only 44 degrees,
> with 4 CPUs to 100% the temperature stabilizes at 60 degrees.
> 
> I am a little bit puzzled ... I am obviously using the same config in 
> both cases.
> Does anyone have an idea ?

Also, check the idle routine, maybe the mx6 specific patch removes some
parts of the idle routine because it causes high latencies, which the
mainline I-pipe patch can not do because it does not patch the mx6
specific code.


-- 
                                                                Gilles.

