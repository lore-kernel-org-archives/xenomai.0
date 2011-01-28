Message-ID: <4D430050.9070401@domain.hid>
Date: Fri, 28 Jan 2011 18:43:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <22672536.41296203668390.JavaMail.SYSTEM@PC-MRINALDI>
In-Reply-To: <22672536.41296203668390.JavaMail.SYSTEM@PC-MRINALDI>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with rt_task_create and rt_task_join
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michel Rinaldi <automation.03@domain.hid>
Cc: xenomai@xenomai.org

Michel Rinaldi wrote:
>> Posted by Gilles Chanteperdrix on January 27, 2011 - 14:36:
> 
>> Strange, here, the LTP test takes only around 2 hours. Just to be
>> sure: you also generated disk and network activity in parallel to
>> LTP and latency? If yes, then this system has no issue with
>> Xenomai, and the problem you have with your application is in the
>> application itself.
> 
> I launch runltp command with -t flag (which specifies test duration)
> to run LTP tests for one day. I cannot run nettests and disk I/O
> tests from ltp battery because they require additional features
> (former requires another linux PC with ltp installed, latter requires
> floppy and CD player which aren't present on my pc). So, I create a
> script that downloads via network a larger (100Mb) file, and create,
> copy and delete some files on hard disk, all in a while loop, to
> generate network and disk I/O traffic. I re-run ltp and latency test
> running for 15 hours in parallel with this script also. I obtain:
> 
> RTD| 1.081| 8.000| 47.249| 0| 0| 14:58:34/14:58:34
> 
> Now I can assert that my xenomai works grat, I think. And then,
> problems are in my application.
> 
> The only thing that looks me strange is this: with
> ltp+my_I/O_stress_script+latency tests, I obtain a minimum latency
> value (1.081) that is more less than ltp+latency only tests (6.182).
>  So, lower latency was obtained with higher system load. Maybe
> there's some CPU frequency reductions in act during ltp+latency that
> isn't active during ltp+latency+my_I/O_stress_script, also if in my
> kernel configuration CPU frequency stepping was disabled? Or what
> could be happened?

The minimum path is a question of pure luck. If you are lucky that
everything needed to go from the interrupt to the user-space latency
task is in cache, this path takes a very short time. If you have one
process which occupies cpu for long periods of times without too much
impact on cache, chances are that you will get a lower minimum latency
than if you have many processes switching and thrashing the cache all
the time.

-- 
                                                                Gilles.

