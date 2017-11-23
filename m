References: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
 <f7ad8163bda5484292ccdf6e8cf1a484@P10-EX02.3DSystems.Internal>
 <02f0df6b-0854-eeaa-a168-ae2c10e1d8ab@xenomai.org>
 <845269a3-e580-c8ff-e25d-a56d00c787fe@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <2f850a60-3756-f06d-82c6-ccf6eeb58aa3@xenomai.org>
Date: Thu, 23 Nov 2017 12:42:08 +0100
MIME-Version: 1.0
In-Reply-To: <845269a3-e580-c8ff-e25d-a56d00c787fe@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [RFC] Service hosting for Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 11/22/2017 09:27 PM, Jan Kiszka wrote:
> On 2017-11-22 16:32, Philippe Gerum wrote:
>>
>> Hi Kendall,
>>
>> On 11/21/2017 08:27 PM, Auel, Kendall wrote:
>>> Hi Philippe,
>>>
>>> Is there an online bug tracking and feature request database? This would be a useful way to distribute work and to sync up contributors. I think the kernel uses Bugzilla, and Ubuntu has Launchpad. No doubt there are many others.
>>>
>>> I'd like to contribute in some way. I've been having a lot of fun as a Xenomai user.
>>>
>> We don't have that unfortunately. As suggested by several posters,
>> moving to a git-based, integrated development framework such as gitlab
>> or github would bring in that feature, and others we need too (CI).
>>
>> I have no issue moving the project from the current git server at
>> xenomai.org to any of these environments.
>>
> 
> If it helps the community to grow, I would not refuse such a move. But I
> would like to raise some concerns about platforms like github or gitlab
> that we must be aware of:
> 
> - lacking integration with email-based workflows (while kernel
>   development tends to be based on that...)
> 
> - risk of decoupling communities when parts of the discussions happen on
>   tickets or PRs and parts in mailing list threads
> 
> Therefore, most projects I manage on github and in our internal gitlab
> have clear policies like "no emails, only tickets and PRs" or "no PRs,
> only patches on the mailing list". Even just using the issue tracker to
> keep some to-do list requires discipline to direct discussions
> consequently to a mailing list if that exists as well (and that usually
> does not work very well).
> 
> IOW: we need to be clear in what we want a platform for - and what not.
> 

Forking the original thread to get input from the list specifically
regarding the idea of moving GIT services from xenomai.org to a public
software development platform.

As Jan mentioned, there is more than having GIT underneath, there are
deep implications on the workflow, and it really depends on what we'd
want from such platform. If you have any thought, recommendation,
experience with those platforms in your daily work, it would be great to
know your views.

Thanks,

-- 
Philippe.

