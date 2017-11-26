References: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
 <f7ad8163bda5484292ccdf6e8cf1a484@P10-EX02.3DSystems.Internal>
 <02f0df6b-0854-eeaa-a168-ae2c10e1d8ab@xenomai.org>
 <845269a3-e580-c8ff-e25d-a56d00c787fe@siemens.com>
 <2f850a60-3756-f06d-82c6-ccf6eeb58aa3@xenomai.org>
 <d4835d99-ffc5-6d1d-5ab3-8236d6d23fab@xenomai.org>
 <20171123203533.h2qfccbyxdavhpej@csclub.uwaterloo.ca>
From: Jorge Ramirez <jro@xenomai.org>
Message-ID: <92228043-c203-d4c2-7088-6f16e66f7cb4@xenomai.org>
Date: Sun, 26 Nov 2017 18:49:12 +0100
MIME-Version: 1.0
In-Reply-To: <20171123203533.h2qfccbyxdavhpej@csclub.uwaterloo.ca>
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
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 11/23/2017 09:35 PM, Lennart Sorensen wrote:
> On Thu, Nov 23, 2017 at 01:38:03PM +0100, Jorge Ramirez wrote:
>> In the past year alone I have been contributing to uboot (as board
>> maintainer), arm-trusted-firmware (board maintainer), ffmpeg (v4l2 support),
>> zephyr (multiple drivers), the linux kernel (some fixes), AOSP (fixes) and a
>> few others. So I have gained certain exposure to a number of workflows.
>>
>> with this in mind I think the Zephyr workflow would suit Xenomai nicely.
> I personally like the linux kernel workflow where everything is through
> a mailing list and patches are reviewed before they go in.  I am not
> sure that workflow would work for xenomai, but I do like it.

we all like the kernel workflow and the release process. In fact, in 
seems to scale ad-infinitum.
however we dont have this need AFAIK.

>
>> It spins around Github and integrates with Shippable - this means that on
>> each pull request, we can trigger a full rebuild and run sanity and maybe
>> even performance tests before any code review can begin; the subsystem
>> maintainer/s then can review the pull request adding comments on the code as
>> it moves along.
> I am not sure build tests are that useful given the number of different
> platforms the code runs on.  Which one do you build test for?

all the default configs in the tree. 10, 20, 200, whatever.

>
>> Xenomai also lacks an IRC channel which makes things way too quiet for a
>> small size community (in the case of ffmpeg for instance IRC is where most
>> if not all the discussions happen). IRC is - and should be for Xenomai- a
>> good place to ask for help and direction. So I vote for having one.
> IRC is useless when the community is small and spread across timezones.
> At least with the mailing list people will see the question and can
> answer it when it hits their timezone.  IRC isn't helpful when no one
> is there to read your question when you write it.  And good luck trying
> to convey anything complex in an IRC conversation.

complex stuff gets discussed in ML.
simple stuff, information sharing, light details, simple blocks, pings, 
that is what IRC is for.

tends to works well;
maybe try joining #ffmpeg,#kodi, #u-boot, ##linux-msm, etc and have a 
peak if you are not used to IRC.


> Want to try sending
> source code patches through IRC for discussion?

this would be ridiculous if it was for an upstream complex review.

if it is for a quick discussion with someone in the channel, sure, you 
can send a patch - as a code snippet - using paste services [1] obviously.
This is very common these days.

>
> I check my email daily.  I don't check random websites daily to check
> the forums for project x, y and z each with a different interface.
> Too much work.

what do you mean about random websites? you lost me there.

>
>> To sum up, given the low rate of patches that Xenomai handles and given the
>> need push back on performance degradation I strongly believe that the
>> Zephyr's workflow would work for us. The way performance ramifications are
>> maintained today is pretty much living in Philippe's and possibly Jan's
>> head: I think we should move from intuition to explicit measurable data when
>> merging PRs (ie, establishing a multi-board CI loop)


[1] https://hastebin.com/

