Subject: Re: [PATCH v3] testsuite: App of gpio loopback/react benchmark
References: <1596434678-27832-1-git-send-email-chensong@tj.kylinos.cn>
 <310ffe2c-04cb-6583-bbc8-d64852fed69c@siemens.com>
 <CALLqZ8Q8TGvMq3-MzRsHGTew9jkNbo1NHh+FxS+ELGLPqywhFw@mail.gmail.com>
 <CALLqZ8R-k+C0RqvKBtGQpm69w4WcARUKAdh8vRk76AmLdg7Exw@mail.gmail.com>
 <4576e489-ee96-0a0b-597b-21ac393a827b@siemens.com>
 <7e84feef-9b11-0c4b-7f32-b32344682cf5@siemens.com>
 <d9c96e5e-57f8-25ce-4e5c-8f2585788f5e@siemens.com>
 <CALLqZ8TJpE2pmrRh6c-v7pRDbdToxveJAggu=gj=Ave67Jag=A@mail.gmail.com>
 <a8fa5bfa-fe05-18b1-2fbd-2e9492ae6de9@siemens.com>
 <5F349E22.3020900@tj.kylinos.cn>
 <13e02bb6-85c0-a723-9e7c-0820b5099465@siemens.com>
 <5F3510AF.4040600@tj.kylinos.cn>
 <b3f4a39b-01a0-5ec4-61b9-bf237f239b0e@siemens.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <5F3518DA.1010008@tj.kylinos.cn>+3363110EDF08CF72
Date: Thu, 13 Aug 2020 18:41:30 +0800
MIME-Version: 1.0
In-Reply-To: <b3f4a39b-01a0-5ec4-61b9-bf237f239b0e@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>



On 2020年08月13日 18:27, Jan Kiszka wrote:
> On 13.08.20 12:06, chensong wrote:
>>
>>
>> On 2020年08月13日 16:54, Jan Kiszka wrote:
>>> On 13.08.20 03:57, chensong wrote:
>>>> I read the code in cyclictest, looks like
>>>>
>>>> printf("index: %d, inner_diff: %llu, outer_diff: %llu\n", index,
>>>>                      (unsigned long long)inner_diff,
>>>>                      (unsigned long long)outer_diff);
>>>
>>> I even wonder if this is strictly correct as it ignores negative diffs.
>>>
>>>>
>>>> can fix the error reported in
>>>> https://travis-ci.com/github/xenomai-ci/xenomai/jobs/371291149.
>>>>
>>>> Do i need to apply a new version?
>>>
>>> No, I've converted your patch to long long types already. Please
>>> cross-check what is in next branch.
>> i'm a little confused here, cross-check what? negative diffs? in
>> theory, it should be always positive, do you mean i keep checking if
>> there is a negative diff?
>>
>> and what's next branch? what can i do about it?
>
> I've modified your patch in
> https://gitlab.denx.de/Xenomai/xenomai/-/commits/next. Please have a
> look if
> https://gitlab.denx.de/Xenomai/xenomai/-/commit/0bcfce8fdc8dee48fa7d85dcd3db0d0ecc6bed1a
> is fine for you as well.

i'm fine with that, it's thoughtful, thanks a lot.

chensong

>
> Thanks,
> Jan
>



