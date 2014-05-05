Message-ID: <53679427.90603@xenomai.org>
Date: Mon, 05 May 2014 15:37:43 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53676902.5050405@xenomai.org>
In-Reply-To: <53676902.5050405@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] FreeRTOS skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/05/2014 12:33 PM, Philippe Gerum wrote:
> On 05/04/2014 06:59 PM, Matthias Schneider wrote:
>> Hi all,
>>
>> please find enclosed a patch with a FreeRTOS skin for xenomai-forge I
>> have
>> been  working on for some time. I would like to get some feedback and
>> advice
>> what still needs to be done to get it accepted in Xenomai. There is a
>> set of
>> unit tests included and the possibility to download the original
>> FreeRTOS package
>> in order to run most of its (platform independent) test suite. Until
>> now I have
>> been working under mercury only. Documentation is available in form of
>> a README
>> file in lib/freertos/README, which should also be a good starting point.
>
> Ok, thanks for this. Let's address issues gradually, starting with the
> task module.
>

In addition to the above, there are a few coding style items:

- Please always take the fastest possible path when exiting on error,
   so that we don't have to cripple the normal processing following the
   failure point with error-specific checks. e.g. what is done with the
   "task" variable in vTaskStartScheduler(), within the thread
   cancellation loop, ends up being convoluted and confusing, compared
   to unwinding and leaving the routine immediately after the error is
   detected.

- (void)function_call() is useless visual pollution and tells nothing
   about the only thing that matters to the reader: were you right in
   omitting the check? Instead, tagging the called routine with the
   ((warn_unused_result)) attribute when problems may likely arise from
   not checking the return value, seems a better way to detect
   potential bugs at build time, which would cause the (void) cast to
   be ignored when checking the call sites anyway.

- Prefer C-style comments over C++-style ones.

-- 
Philippe.

