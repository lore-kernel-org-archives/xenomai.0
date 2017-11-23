References: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
 <f7ad8163bda5484292ccdf6e8cf1a484@P10-EX02.3DSystems.Internal>
 <02f0df6b-0854-eeaa-a168-ae2c10e1d8ab@xenomai.org>
 <845269a3-e580-c8ff-e25d-a56d00c787fe@siemens.com>
 <2f850a60-3756-f06d-82c6-ccf6eeb58aa3@xenomai.org>
 <20171123135212.45ec5f3b@md1em3qc>
From: Jorge Ramirez <jro@xenomai.org>
Message-ID: <ae12e587-58dd-982f-1afa-8b7f66dbfc86@xenomai.org>
Date: Thu, 23 Nov 2017 14:18:26 +0100
MIME-Version: 1.0
In-Reply-To: <20171123135212.45ec5f3b@md1em3qc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Xenomai] [RFC] Service hosting for Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 11/23/2017 01:52 PM, Henning Schild wrote:
> Am Thu, 23 Nov 2017 12:42:08 +0100
> schrieb Philippe Gerum <rpm@xenomai.org>:
>
>> On 11/22/2017 09:27 PM, Jan Kiszka wrote:
>>> On 2017-11-22 16:32, Philippe Gerum wrote:
>>>> Hi Kendall,
>>>>
>>>> On 11/21/2017 08:27 PM, Auel, Kendall wrote:
>>>>> Hi Philippe,
>>>>>
>>>>> Is there an online bug tracking and feature request database?
>>>>> This would be a useful way to distribute work and to sync up
>>>>> contributors. I think the kernel uses Bugzilla, and Ubuntu has
>>>>> Launchpad. No doubt there are many others.
>>>>>
>>>>> I'd like to contribute in some way. I've been having a lot of fun
>>>>> as a Xenomai user.
>>>> We don't have that unfortunately. As suggested by several posters,
>>>> moving to a git-based, integrated development framework such as
>>>> gitlab or github would bring in that feature, and others we need
>>>> too (CI).
>>>>
>>>> I have no issue moving the project from the current git server at
>>>> xenomai.org to any of these environments.
>>>>   
>>> If it helps the community to grow, I would not refuse such a move.
>>> But I would like to raise some concerns about platforms like github
>>> or gitlab that we must be aware of:
>>>
>>> - lacking integration with email-based workflows (while kernel
>>>    development tends to be based on that...)
>>>
>>> - risk of decoupling communities when parts of the discussions
>>> happen on tickets or PRs and parts in mailing list threads
>>>
>>> Therefore, most projects I manage on github and in our internal
>>> gitlab have clear policies like "no emails, only tickets and PRs"
>>> or "no PRs, only patches on the mailing list". Even just using the
>>> issue tracker to keep some to-do list requires discipline to direct
>>> discussions consequently to a mailing list if that exists as well
>>> (and that usually does not work very well).
>>>
>>> IOW: we need to be clear in what we want a platform for - and what
>>> not.
>> Forking the original thread to get input from the list specifically
>> regarding the idea of moving GIT services from xenomai.org to a public
>> software development platform.
>>
>> As Jan mentioned, there is more than having GIT underneath, there are
>> deep implications on the workflow, and it really depends on what we'd
>> want from such platform. If you have any thought, recommendation,
>> experience with those platforms in your daily work, it would be great
>> to know your views.
> Jan is absolutely right here. Before moving to github (or something
> alike) you need to set groundrules for how to deal with PRs, issues and
> all the stuff that you suddenly gain.
>
> I think Xenomai could benefit from issue tracking and CI, not sure
> whether we need github for that.

issue tracking is not something that important IMO.
I dont believe this is extensively used by any projects but mainly distros.

> The CI they offer is docker-based and
> we would likely want something more powerful. But i guess you could
> always use docker to remote control AWS or real hardware.

yes. there are a number of solutions that in fact do OTA and most of 
them use Docker to control real hardware.
the industry seems to be going in that direction. I think Shippable 
should server our purpose.

for instance, check out this commit:
https://github.com/zephyrproject-rtos/zephyr/pull/5134

and its shippable output
https://app.shippable.com/github/zephyrproject-rtos/zephyr/runs/7471/summary/console

> github sucks at routing mails. My github account is shared between my
> work and personal stuff but i do not star/watch any work related
> projects because i do not want the notifications in my personal inbox.

I agree that it sucks but I dont see why this should be an issue.
Just dont rely on github emails (I personally tend to disable them, they 
are extremely annoying).

when I need to find out how any PR is progressing (every other day) I 
just connect to github.

>
> commitment to github etc. is likely to cause sort of a vendor lock-in.

? what do you mean?
> I am sure the APIs can be used to extract some information, but will you
> get something that you can import into your own gitlab or track later
> on? As long as we only use git-hosting and CI from them that would not
> be too much of a problem.

yeah everything can be done (ie: at linaro we have lava-labs and 
integrate our own CI loops with Jenkins and real hardware).
But I dont believe Xenomai has the dedicated resources for that.

BTW at ELCE in Prague, Tgx's daughter presented a very interesting 
approach [1] to accessing real hardware on CI (using libvirt). Very cool.
I think we should use it if in the end we decide to roll our own. But 
IMO, Shippable should suffice.

[1] 
https://osseu17.sched.com/event/ByYA/continuous-integration-jenkins-libvirt-and-real-hardware-anna-maria-gleixner-manuel-traut-linutronix-gmbh


>
> Henning
>
>> Thanks,
>>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>


