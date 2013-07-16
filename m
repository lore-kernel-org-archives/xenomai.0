Message-ID: <51E58DD1.7060909@xenomai.org>
Date: Tue, 16 Jul 2013 20:15:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51E4F63A.7080203@163.com> <51E55AB0.8070600@siemens.com>
	<51E562FD.90802@axelsw.it>
In-Reply-To: <51E562FD.90802@axelsw.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] imx28 high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roberto Bielli <roberto.bielli@axelsw.it>
Cc: xenomai@xenomai.org

On 07/16/2013 05:13 PM, Roberto Bielli wrote:

> Hi,
>
> i put xenomai 2.6.2.1 with patch 'ipipe-core-3.4.6-arm-4.patch' on a
> vanilla kernel 3.4.6 for a karo tx28 board (tx28 has imx28 processor
> that uses standard clock management to access the timer).
> I run the latency test but seems to have very high latency.
> (I saw always that every 5 records the 'lat avg' is higher than previous.


Well, it seems something is running every 5s and has adverse effects, 
thrashing cache maybe, you can use the I-pipe tracer to know exactly.

> Also when i run after some seconds the command 'ls -lR /' from a telnet
> console for increaseing interrupts the 'lat min' is raised to  54.200~ us )
> i read correcly the data below or i misunderstanding the behaviour ?


The imx28 is an arm926, not a cortex a-something. The figures you get 
are a bit low actually, I would expect the worst case latency to be 
above 100us.

> Are there some kernel features to disable ?


You can try to enable FCSE.
In "guaranteed" mode, you will be limited to at most 95 processes, every 
one of them with at most 32MB of virtual address-space, and improved 
worst case latency.
In "best-effort" mode, you do not have the limitations, but you only 
improve average latency.

-- 
                                                                 Gilles.

