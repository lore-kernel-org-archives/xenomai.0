Subject: Re: Posix periodic time first tick
References: <20200807171220.E090CB18@centrum.cz>
 <166391923.711496.1597041953464.JavaMail.zimbra@wolfram.com>
From: =?UTF-8?Q?Petr_=c4=8cervenka?= <grugh@centrum.cz>
Message-ID: <4baa56a0-13dc-08d7-79d4-00f63f85c2b0@centrum.cz>
Date: Mon, 10 Aug 2020 09:52:34 +0200
MIME-Version: 1.0
In-Reply-To: <166391923.711496.1597041953464.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: cs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Per Oberg <pero@wolfram.com>, xenomai <xenomai@xenomai.org>

Hello.

The problem is only when I use Xenomai linking flags and only with 
thestart time. Period is OK.

That aprox. 16s time delay can be "compensated" by substracting of any 
number of seconds from the start time.

     // Create timer
     timer_fd = timerfd_create(CLOCK_MONOTONIC, 0);

     // Get current time
     struct timespec start;
     clock_gettime(CLOCK_MONOTONIC, &start);

     // Set periodic
     struct itimerspec timer_conf;
     memset(&timer_conf, 0, sizeof (timer_conf));
     timer_conf.it_value = timespec_add(start, -15 * NANOSEC_PER_SEC); 
// compensation of the delay
     ...
     timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &timer_conf, NULL);

There is strange unexpected difference/time shift between product of 
clock_gettime and timerfd_settime. Only with Xenomai posix wrappers.

Best regards

Petr Cervenka


Dne 10.08.2020 v 8:45 Per Oberg napsal(a):
> ----- Den 7 aug 2020, på kl 17:12, xenomai xenomai@xenomai.org skrev:
>
>> Hello.
>> I have created small example of periodic task in posix.
>> If I compile it without xenomai it works fine.
>> When I add Xenomai linking flags, the first tick of periodic task take around
>> 16s. After that it continues as it should.
>> Used clock type for timer_fd is CLOCK_MONOTONIC. The example should in
>> attachment.
>> Do you have any suggestions?
> Just had a extremely quick look at it. Are you sure you don't get any rounding errors when doing your period arithmetics ?
>
>> Best regards
>> -------------- next part --------------
>> A non-text attachment was scrubbed...
>> Name: timer_test.cpp
>> Type: text/x-c++src
>> Size: 4351 bytes
>> Desc: timer_test.cpp
>> URL:
>> <http://xenomai.org/pipermail/xenomai/attachments/20200807/d4203f59/attachment.cpp>
> Per Öberg

