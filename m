Message-ID: <53E3CD23.5040909@xenomai.org>
Date: Thu, 07 Aug 2014 21:01:55 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <AE39D2A4-ECC3-481B-AF3B-8A67FA23D2BF@tuebingen.mpg.de>
 <44BE6908-E639-421F-B556-E7B3871402CF@gmail.com>
 <67B7E374-C4D2-4F83-BA40-B289B15867B9@tuebingen.mpg.de>
 <53E3B5E3.3090006@xenomai.org> <oqtx5om90q.fsf@merlin.sez.to>
In-Reply-To: <oqtx5om90q.fsf@merlin.sez.to>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] real-time guarantee issues on xenomai 2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul Janzen <pcj@xenomai.sez.to>, xenomai@xenomai.org

On 08/07/2014 08:47 PM, Paul Janzen wrote:
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:
> 
>> And it also probably happens in some conditions only (with a large
>> number of Xenomai threads for instance)
> 
> This is not quite correct. I experience large latencies (~1ms) during
> "watch cat /proc/xenomai/stat", just running xeno-test (stat lists two
> application tasks, two ROOTs and two IRQ-timers.)
> 
> x64, SMP, Linux 3.4.6, ipipe-core-3.4.6-x86-4.patch, xenomai 242a6e4. 
> 

1 ms is definitely pathological. This cannot be related to
/proc/xenomai/stat or whatever vfile under /proc/xenomai, we would have
noticed.

This is more likely a I-pipe issue (3.4.6/x86 is outdated, although 1 ms
is really above usual issues), a kernel configuration issue (e.g.
CONFIG_CPU_FREQ, or other latency killer), or maybe a SMI problem. Or
maybe an issue induced by a graphic card driver if you happen to run
with a GUI.

-- 
Philippe.

