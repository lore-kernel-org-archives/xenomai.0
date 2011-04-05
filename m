Message-ID: <4D9B4EC0.5080701@domain.hid>
Date: Tue, 05 Apr 2011 19:17:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <COL122-W376680783697A8A880DC2BBDA20@domain.hid>
	<infaa9$eoe$1@domain.hid>
In-Reply-To: <infaa9$eoe$1@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Tiny Core Linux + xenomai/RTAI
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: gmane@domain.hid
Cc: xenomai@xenomai.org

Robert Berger wrote:
> Hi Krishna,
> 
> On 04/05/2011 04:48 PM, krishna m wrote:
>> Has anyone tried applying Xenomai or RTAI patch to the tiny core Linux?
> 
> No
> 
>> Will it give a better performance compared to the plain vanilla Linux
>> because the kernel footprint is small?
> 
> I guess the Linux Kernel is pretty much the same with the vanilla
> kernel. The reason it might offer better performance does most likely
> not come from the kernel, but because in such a small system less
> services are running, which might eat less CPU time.
> 
> Will performance be better?
> 
> Depends on what you mean with performance.
> 
> If you apply Xenomai/RTAI to a vanilla Linux kernel throughput and
> number crunching (performance) will get worse and determinism will get
> better.
> 
> Real-time is not about "performance" (speed, throughput), but about
> determinism and those are conflicting requirements.
> 
> You can have a look at an article of mine for a more detailed
> explanation of what I mean:
> http://www.eetimes.com/design/embedded/4204740/Getting-real--time--about-embedded-GNU-Linux

Ok, we are on Xenomai-core, so, let us discuss. If we admit that the OP
is indeed talking about latencies (a quantifiable measure of
determinism), suggesting that the effect on cache of the Linux kernel
might influence the latencies is not completely irrelevant: the
benchmark we make with Xenomai tend to consistently show that cache
thrashing by the Linux kernel has an effect on latencies.

Also, having shorter latencies means that we cover a larger range of
user-application needs. So, we try to have short latencies.

-- 
					    Gilles.

