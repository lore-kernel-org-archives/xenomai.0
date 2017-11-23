References: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
 <f7ad8163bda5484292ccdf6e8cf1a484@P10-EX02.3DSystems.Internal>
 <02f0df6b-0854-eeaa-a168-ae2c10e1d8ab@xenomai.org>
 <845269a3-e580-c8ff-e25d-a56d00c787fe@siemens.com>
 <2f850a60-3756-f06d-82c6-ccf6eeb58aa3@xenomai.org>
From: Jorge Ramirez <jro@xenomai.org>
Message-ID: <d4835d99-ffc5-6d1d-5ab3-8236d6d23fab@xenomai.org>
Date: Thu, 23 Nov 2017 13:38:03 +0100
MIME-Version: 1.0
In-Reply-To: <2f850a60-3756-f06d-82c6-ccf6eeb58aa3@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 11/23/2017 12:42 PM, Philippe Gerum wrote:
> On 11/22/2017 09:27 PM, Jan Kiszka wrote:
>> On 2017-11-22 16:32, Philippe Gerum wrote:
>>> Hi Kendall,
>>>
>>> On 11/21/2017 08:27 PM, Auel, Kendall wrote:
>>>> Hi Philippe,
>>>>
>>>> Is there an online bug tracking and feature request database? This would be a useful way to distribute work and to sync up contributors. I think the kernel uses Bugzilla, and Ubuntu has Launchpad. No doubt there are many others.
>>>>
>>>> I'd like to contribute in some way. I've been having a lot of fun as a Xenomai user.
>>>>
>>> We don't have that unfortunately. As suggested by several posters,
>>> moving to a git-based, integrated development framework such as gitlab
>>> or github would bring in that feature, and others we need too (CI).
>>>
>>> I have no issue moving the project from the current git server at
>>> xenomai.org to any of these environments.
>>>
>> If it helps the community to grow, I would not refuse such a move. But I
>> would like to raise some concerns about platforms like github or gitlab
>> that we must be aware of:
>>
>> - lacking integration with email-based workflows (while kernel
>>    development tends to be based on that...)
>>
>> - risk of decoupling communities when parts of the discussions happen on
>>    tickets or PRs and parts in mailing list threads
>>
>> Therefore, most projects I manage on github and in our internal gitlab
>> have clear policies like "no emails, only tickets and PRs" or "no PRs,
>> only patches on the mailing list". Even just using the issue tracker to
>> keep some to-do list requires discipline to direct discussions
>> consequently to a mailing list if that exists as well (and that usually
>> does not work very well).
>>
>> IOW: we need to be clear in what we want a platform for - and what not.
>>
> Forking the original thread to get input from the list specifically
> regarding the idea of moving GIT services from xenomai.org to a public
> software development platform.
>
> As Jan mentioned, there is more than having GIT underneath, there are
> deep implications on the workflow, and it really depends on what we'd
> want from such platform. If you have any thought, recommendation,
> experience with those platforms in your daily work, it would be great to
> know your views.

In the past year alone I have been contributing to uboot (as board 
maintainer), arm-trusted-firmware (board maintainer), ffmpeg (v4l2 
support), zephyr (multiple drivers), the linux kernel (some fixes), AOSP 
(fixes) and a few others. So I have gained certain exposure to a number 
of workflows.

with this in mind I think the Zephyr workflow would suit Xenomai nicely.

It spins around Github and integrates with Shippable - this means that 
on each pull request, we can trigger a full rebuild and run sanity and 
maybe even performance tests before any code review can begin; the 
subsystem maintainer/s then can review the pull request adding comments 
on the code as it moves along.

Xenomai also lacks an IRC channel which makes things way too quiet for a 
small size community (in the case of ffmpeg for instance IRC is where 
most if not all the discussions happen). IRC is - and should be for 
Xenomai- a good place to ask for help and direction. So I vote for 
having one.

To sum up, given the low rate of patches that Xenomai handles and given 
the need push back on performance degradation I strongly believe that 
the Zephyr's workflow would work for us. The way performance 
ramifications are maintained today is pretty much living in Philippe's 
and possibly Jan's head: I think we should move from intuition to 
explicit measurable data when merging PRs (ie, establishing a 
multi-board CI loop)






