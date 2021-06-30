Subject: Re: [PATCH 1/2] y2038: cobalt/posix/mutex: try acquire mutex before
 checking timeout
References: <1625034731-29827-1-git-send-email-chensong_2000@189.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <073d25fa-3b8e-d91f-690e-7a5e5d67eddc@siemens.com>
Date: Wed, 30 Jun 2021 08:50:35 +0200
MIME-Version: 1.0
In-Reply-To: <1625034731-29827-1-git-send-email-chensong_2000@189.cn>
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

On 30.06.21 08:32, Song Chen via Xenomai wrote:
> If a preocess is calling mutex_timedlock to acquire resource with
> an invalid timeout, mutex_timedlock returns -EFAULT even resource
> is available, it doesn't make any sense.
> 

It does make sense from the perspective of detecting programming errors
of userspace earlier, not only in the contention case. Is POSIX
forbidding us to do that? If not, I would rather stick with the current
scheme.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

