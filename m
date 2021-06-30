Sender: chensong_2000@189.cn
Subject: Re: [PATCH 1/2] y2038: cobalt/posix/mutex: try acquire mutex before
 checking timeout
References: <1625034731-29827-1-git-send-email-chensong_2000@189.cn>
 <073d25fa-3b8e-d91f-690e-7a5e5d67eddc@siemens.com>
 <94cd19a4ccd202be8552525f9ced1d33a8ff406a.camel@siemens.com>
From: "chensong_2000@189.cn" <chensong_2000@189.cn>
Message-ID: <3fbddfb5-7ca8-316c-c275-72f598716b13@189.cn>
Date: Wed, 30 Jun 2021 16:06:10 +0800
MIME-Version: 1.0
In-Reply-To: <94cd19a4ccd202be8552525f9ced1d33a8ff406a.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>



在 2021/6/30 下午2:59, Bezdeka, Florian 写道:
> On Wed, 2021-06-30 at 08:50 +0200, Jan Kiszka wrote:
>> On 30.06.21 08:32, Song Chen via Xenomai wrote:
>>> If a preocess is calling mutex_timedlock to acquire resource with
>>> an invalid timeout, mutex_timedlock returns -EFAULT even resource
>>> is available, it doesn't make any sense.
>>>
>>
>> It does make sense from the perspective of detecting programming errors
>> of userspace earlier, not only in the contention case. Is POSIX
>> forbidding us to do that? If not, I would rather stick with the current
>> scheme.
> 
> POSIX says the "The validity of the abs_timeout parameter need not be
> checked if the mutex can be locked immediately.", so we are still
> allowed to validate, but maybe should not.
> 
> The sem_timedwait() does not validate in case the semaphore is
> available, so we're trying to consolidate here.
> 

I want it,i can wait for a while, i leave if waiting too long, if i can 
get it immediately, timeout doesn't matter. That's the scenario it is about.

So i prefer try_acquire before validating timeout

/Song

>>
>> Jan
>>
> 

