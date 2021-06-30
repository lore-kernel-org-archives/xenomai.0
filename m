Subject: Re: [PATCH 1/2] y2038: cobalt/posix/mutex: try acquire mutex before
 checking timeout
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <1625034731-29827-1-git-send-email-chensong_2000@189.cn>
 <073d25fa-3b8e-d91f-690e-7a5e5d67eddc@siemens.com>
Message-ID: <c77b77a6-6c61-f872-2bcd-6b1e5b6b3014@siemens.com>
Date: Wed, 30 Jun 2021 08:56:35 +0200
MIME-Version: 1.0
In-Reply-To: <073d25fa-3b8e-d91f-690e-7a5e5d67eddc@siemens.com>
Content-Type: text/plain; charset=utf-8
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
To: Song Chen <chensong_2000@189.cn>, florian.bezdeka@siemens.com, xenomai@xenomai.org

On 30.06.21 08:50, Jan Kiszka wrote:
> On 30.06.21 08:32, Song Chen via Xenomai wrote:
>> If a preocess is calling mutex_timedlock to acquire resource with
>> an invalid timeout, mutex_timedlock returns -EFAULT even resource
>> is available, it doesn't make any sense.
>>
> 
> It does make sense from the perspective of detecting programming errors
> of userspace earlier, not only in the contention case. Is POSIX
> forbidding us to do that? If not, I would rather stick with the current
> scheme.
> 

Well, the common uncontended case is actually no syscall at all - we are
in the race situation here where the lock was contended from userspace
perspective and now became free. Still, I do not yet see the benefit of
checking the availability again first.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

