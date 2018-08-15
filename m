References: <c3a3b15a-ea65-4051-55d8-b74a0a3aa4ad@visutechsystem.by>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <54569c93-a1e4-9e1e-2479-191532378dbf@xenomai.org>
Date: Wed, 15 Aug 2018 16:21:13 +0200
MIME-Version: 1.0
In-Reply-To: <c3a3b15a-ea65-4051-55d8-b74a0a3aa4ad@visutechsystem.by>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] xenomai 3.0.6 get stuck on AM335x after 4-16 hours
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stepan Kizim <Stepan.Kizim@visutechsystem.by>, xenomai@xenomai.org
Cc: Sergey Belevich <Sergey.Belevich@visutechsystem.by>

On 08/13/2018 03:17 PM, Stepan Kizim wrote:
> Hi there,
> 
> I'm working with BeagleBone Black with AM335x 1GHz ARM® Cortex-A8 on board.
> Due to hard real-time requirements, I've patched kernel 4.9.69 (from TI
> SDK v.04.03.00.05) by xenomai 3.0.6.
> Xenomai patch source:
> https://xenomai.org/downloads/ipipe/v4.x/arm/ipipe-core-4.9.51-arm-4.patch

FWIW, the Xenomai code base is tested against mainline kernels, vendor
kernels are out of scope.

> 
> Unfortunately, I've faced stability tests failure after 4-16 hours.
> Device get stuck, sometimes with kernel panic in debug console.
> Kernel .config and kernel panic logs are in attachment.
> KpaProxyServer is name of my application and SmConnection is name of the
> one of threads.
> 

Does the kernel survive a 24h long stress test with the following apps
running in parallel, excluding any other rt application?

- latency
- switchtest -s 200

-- 
Philippe.

