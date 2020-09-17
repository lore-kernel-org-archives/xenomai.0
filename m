References: <777d8ed5-7f6a-4e56-7f65-7677f089527e@cs.ru.nl>
 <916ef19a754d4e42b0eaefa8a1a26060@EXPRD08.hosting.ru.nl>
 <5faff965-afc6-f70a-8d10-8f55c570fbf6@cs.ru.nl>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: rt_task_set_priority does not increase priority of other task
In-reply-to: <5faff965-afc6-f70a-8d10-8f55c570fbf6@cs.ru.nl>
Date: Thu, 17 Sep 2020 15:26:08 +0200
Message-ID: <87wo0s7cwf.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Harco Kuppens <h.kuppens@cs.ru.nl>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org


Harco Kuppens via Xenomai <xenomai@xenomai.org> writes:

> On 17/09/2020 13:51, Jan Kiszka wrote:
>> On 16.09.20 20:12, Harco Kuppens via Xenomai wrote:
>>> Hi,
>>>
>>> I found a problem with rt_task_set_priority function which does not
>>> increase priority of another task.
>>> However it works fine if you increase the priority of another task.
>>>
>>> Below is an en example program and its output, and we run this program
>>> on xenomai 3.08.
>>> The problem appears if we run the program on our xenomai image for the
>>> raspberry pi 3,
>>> and is also appears in our virtual box image.
>>> Both images can be found at :
>>>
>>>    * http://www.cs.ru.nl/lab/xenomai/raspberrypi.html
>>>    * http://www.cs.ru.nl/lab/xenomai/virtualbox.html
>>>
>>> The easiest way is to run the virtualbox image.
>>>
>>> The final question I have: is there an wrong usage of xenomai API in the
>>> example program,
>>> or is this a bug in xenomai?
>>>
>> Something is inconsistent here. Did you also check via
>> /proc/xenomai/sched/threads if that view is consistent with the result
>> of inquire?
> yes, and they also said the priority was not increased.
> You can repeat the experiment in the virtualbox image.
> Note: we use virtualbox so that students can do some exercise at
> home. The exerecises on hardware they must do on raspberry pi 3 in the
> lab.
> Normally a rt os on virtualbox would make no sense.
>> I vaguely recall issues of the latter but I also do not
>> recall any fix to 3.1, not to speak of anything that was not backported.
>
>> BTW, tried 3.1 as well?
> no, because I don't have it  installed. Could someone who has it
> running try this example on it, and check whether this   problem also
> occurs there?
>
> Anyway it was pretty difficult to get xenomai 3.08 with gpio support
> to work on the raspberry pi 3.
> Took me a long time, and I rather stick with 3.0.8.
> We use raspberry pi's in a course on the radboud university where
> students get exercises in learning to use xenomai.
> Switching to new version would mean lot of work for me.
>

Ok, I'll have a look asap in the coming days and follow up on this.

-- 
Philippe.

