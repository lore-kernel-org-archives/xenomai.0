Subject: Re: rt_task_set_priority does not increase priority of other task
References: <777d8ed5-7f6a-4e56-7f65-7677f089527e@cs.ru.nl>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fce90cd3-9667-33c9-0f1b-2f6effa28b38@siemens.com>
Date: Thu, 17 Sep 2020 13:51:46 +0200
MIME-Version: 1.0
In-Reply-To: <777d8ed5-7f6a-4e56-7f65-7677f089527e@cs.ru.nl>
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
To: Harco Kuppens <h.kuppens@cs.ru.nl>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 16.09.20 20:12, Harco Kuppens via Xenomai wrote:
> 
> Hi,
> 
> I found a problem with rt_task_set_priority function which does not 
> increase priority of another task.
> However it works fine if you increase the priority of another task.
> 
> Below is an en example program and its output, and we run this program 
> on xenomai 3.08.
> The problem appears if we run the program on our xenomai image for the 
> raspberry pi 3,
> and is also appears in our virtual box image.
> Both images can be found at :
> 
>   * http://www.cs.ru.nl/lab/xenomai/raspberrypi.html
>   * http://www.cs.ru.nl/lab/xenomai/virtualbox.html
> 
> The easiest way is to run the virtualbox image.
> 
> The final question I have: is there an wrong usage of xenomai API in the 
> example program,
> or is this a bug in xenomai?
> 

Something is inconsistent here. Did you also check via 
/proc/xenomai/sched/threads if that view is consistent with the result 
of inquire? I vaguely recall issues of the latter but I also do not 
recall any fix to 3.1, not to speak of anything that was not backported.

BTW, tried 3.1 as well?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

