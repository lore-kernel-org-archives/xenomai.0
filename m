References: <trinity-3a616500-d86a-4f71-bb11-16fa1d6cf8a2-1448533977790@3capp-webde-bs12>
 <20151128064325.GC10399@hermes.click-hack.org>
From: Jochen Behnke <jk.behnke@web.de>
Message-ID: <565AC5C9.8090807@web.de>
Date: Sun, 29 Nov 2015 10:30:49 +0100
MIME-Version: 1.0
In-Reply-To: <20151128064325.GC10399@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] "RT throttling" issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hello Gilles,

in the meanwhile I added rt_timer_tsc as a second alternative to measure 
elapsed time. rt_timer_tsc returns values that are a somewhat greater 
than expected (around 39 ms instead of expected 20 ms), but still 
reasonable.

> On Thu, Nov 26, 2015 at 11:32:57AM +0100, JK.Behnke@web.de wrote:
>> Hello,
>>
>> in my xenomai 2.6.3 application I sporadically experience very long execution times of
>> a task that switches back and forth between secondary and primary mode.
>>
>> I added the following code to measure elapsed and cpu time
>> //------------- start code snippet ---------------
>> struct rusage rsgT1;
>> struct rusage rsgT2;
>> struct timeval tvT1;
>> struct timeval tvT2;
>> gettimeofday(&tvT1, NULL);
>
> Do you observe the same problem with Xenomai 2.6 git head, if you
> use clock_gettime(CLOCK_HOST_REALTIME) instead of gettimeofday, at
> least for threads running in primary mode ?
>

I'll give Xenomai 2.6 git head a try.
Thanks for your help.

Regards
Jochen


