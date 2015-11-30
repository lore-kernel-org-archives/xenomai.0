Date: Mon, 30 Nov 2015 13:09:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151130120930.GA19802@hermes.click-hack.org>
References: <565C2BAD.2040909@bmwedler.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <565C2BAD.2040909@bmwedler.de>
Subject: Re: [Xenomai] Alchemy periodic task and timer overruns
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Registrierungen <regist@bmwedler.de>
Cc: xenomai@xenomai.org

On Mon, Nov 30, 2015 at 11:57:49AM +0100, Registrierungen wrote:
> Hello,
> 
> i've got a problem using the periodic tasks.
> I am using the alchemy tasks running 10kHz and i get a lot of  (up ~ 
> 10)  timer overruns / sek calling rt_task_wait_period. (each overrung 
> has an amount of 1 ).
> 
> I extracted the task to a test program. In this example he is doing 
> nothing between the rt_task_wait_period calls.
> Ironically i get more (up ~ 100) timer overruns / sek calling 
> rt_task_wait_period.
> 
> I am running a AMD-G Series, x86_64 with SMP.
> I tested on xenomai 3rc2 and xenomai 3.0.1 (with optimized kernel, 
> following the documentation) with same results.
> 
> Any idea, what is going wrong?
> How can i find out where is the problem?

Do you observe the same problem with xenomai "latency" test? If yes,
then using the I-pipe tracer should help you. Note that all that is
documented in the "troubleshooting" guide:

http://xenomai.org/troubleshooting-a-dual-kernel-configuration/#the_latency_test_shows_high_latencies

-- 
					    Gilles.
https://click-hack.org

