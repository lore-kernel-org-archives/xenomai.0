References: <9dee4e70-9bce-2fac-2aba-f27e65a9c1ba@tuebingen.mpg.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <50805f15-f8c3-a47d-0b05-7b722d44a73e@xenomai.org>
Date: Wed, 28 Feb 2018 19:06:39 +0100
MIME-Version: 1.0
In-Reply-To: <9dee4e70-9bce-2fac-2aba-f27e65a9c1ba@tuebingen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Low latency under stress, otherwise high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Julian Viereck <jviereck@tuebingen.mpg.de>, xenomai@xenomai.org

On 02/26/2018 10:34 PM, Julian Viereck wrote:
> Hi folks,
> 
> after installing Xenomai 3.0.5/kernel 4.9.38 following [1] on our Dell
> Precision 5820 machine (Intel Xeon W-2145), there are high latencies
> when the system is at rest. When starting a stress test via `stress -v
> -c 8 -i 10 -d 8`, the latency goes down (see terminal output below).
> 
> Usually I would assume the latency increases with higher load and not go
> down. Does someone has an idea where to start in debugging / fixing the
> high latencies? Note that the cores are in C0 state 100% of the time
> (with and without the load on the machine).

Maybe a SMI issue [1]. You may want to boot your hardware with a vanilla
kernel (unpatched, no Xenomai), then run the hwlatdetect test from the
rt testsuite [2]. If SMIs are detected, you may want to ask your BIOS
vendor to fix their code (some do actually).

[1] http://xenomai.org/2014/06/dealing-with-x86-smi-troubles/
[2] git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git

-- 
Philippe.

