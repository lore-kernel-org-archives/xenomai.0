Subject: Re: rt_dev_send() stalls periodic task
References: <teAgyZ99MOeKTG05UuBn4VijhPdYtJNRN66uQyusOJmxjDgqW9fDkKNoil4CPJDiUnKWYQ9P5uk2c652s7XbmYDurUmjOzlZaYqPaVfjfK0=@codecraftsmen.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <965464f8-0976-364d-e07a-a5188b4bdf7b@siemens.com>
Date: Wed, 24 Apr 2019 16:36:05 +0200
MIME-Version: 1.0
In-Reply-To: <teAgyZ99MOeKTG05UuBn4VijhPdYtJNRN66uQyusOJmxjDgqW9fDkKNoil4CPJDiUnKWYQ9P5uk2c652s7XbmYDurUmjOzlZaYqPaVfjfK0=@codecraftsmen.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <w1@codecraftsmen.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 24.04.19 15:05, Jeff Webb via Xenomai wrote:
>> The only difference in the serial configuration between that cross-link.c
>> app and my app was :
>> struct rtser_config :
>>           .rx_timeout        = RTSER_DEF_TIMEOUT  // infinite ,  no stall for
>> many hours in cross-link.c
>> versus:
>>           .rx_timeout        = 500000   // 500us, stalls within an hour in my
>> app
>> I don't know why an RX setting affects TX behavior. I also can't use
>> RTSER_DEF_TIMEOUT in my application or it dies when it starts up - no clue
>> why.  But I did try setting
>>     .rx_timeout        = 5000000   // 5 ms. my app doesnt stall for several
>> hours
> 
> This may not be related, but this jogged my memory about a problem I had years ago regarding rx/tx timeouts affecting the other operation.  I just took a look at rt_16550_write(), and I see:
> 
>    rtdm_toseq_init(&timeout_seq, ctx->config.rx_timeout);
> 
>    /* Make write operation atomic. */
>    ret = rtdm_mutex_timedlock(&ctx->out_lock, ctx->config.rx_timeout,
>       &timeout_seq);
> 
> This is the same code as in *_read().  I am wondering if this is a cut and paste error.  It seems like these two lines should use tx_timeout instead, but I haven't looked into the code in detail.  Maybe this is related, or maybe another bug?

That is a good catch! Copy & paste would be my theory as well... Wanna write a 
patch?

I don't think it will change the picture for the stalled tx issue, though.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

