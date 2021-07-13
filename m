Subject: Re: [PATCH] Remove analogy support
References: <27482c83-6428-30df-52a6-b2fa9c61c98b@siemens.com>
 <76895dcc-ef00-b24a-9b00-c928425a2148@akamina.com>
 <05cdf5a9-e599-82f3-ad57-8f3fe7677990@siemens.com>
 <2a81a6b8-a461-485d-0ea1-d1281a00c501@akamina.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ecd67cc1-0f18-22de-ea1c-795c39a6eccf@siemens.com>
Date: Tue, 13 Jul 2021 17:57:24 +0200
MIME-Version: 1.0
In-Reply-To: <2a81a6b8-a461-485d-0ea1-d1281a00c501@akamina.com>
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
To: Peter Laurich <Peter.Laurich@akamina.com>, xenomai@xenomai.org

On 13.07.21 17:43, Peter Laurich wrote:
> Hi Jan,
> 
> Yes, I am still using Analogy. I just upgraded to Xenomai 3.1 and have
> added Analogy support for a mPCIe ACCES I/O module that we are using. I
> did not have any issues with Analogy in adding the new driver.
> 
> I do see that there are many people active within the Xenomai community
> who are likely continually moving their code base forward as new Xenomai
> versions and supported kernels are released. I tend not to follow the
> continuous upgrade path and take a significant release, integrate my
> code with that release and then work with that as a baseline for quite
> some time. The last Xenomai release that I used for quite some time was
> Xenomai 2.6.3. With this development model, I am not always following
> the daily discussions and updates submitted by the Xenomai development
> team. I guess I missed all of the discussions surrounding Analogy.
> 
> Looking forward, I am not certain what I will do with the code base that
> I have that includes Analogy drivers. I may need to migrate to a
> non-Analogy implementation of my data acquisition and control framework.
> I have to think about that.
> 

Look, this project depends on contributions to areas users care about.
Not only code - though also - but even just feedback what is important
and how it is being used. We are always asking for this, not only since
recently, and if we hear nothing, we assume that some corner lost
interests. That story also applies to the mercury interface (Xenomai
over plan Linux) eg.

In this particular case, the issue is that no one contributing to the
code has any use case or even an idea of how people are using Analogy
today. Or will use after their next major update.

We also have no QA for Analogy, except at least building it and fixing
breakage or compiler findings such as [1] or [2] as they happen to pop
up. Blindly, without testing the result. Analogy has some fake and loop
drivers, but there was nothing hooked up into xeno-test, smokey etc. to
ensure that at least basic validation runs (like we have to RTnet).

If something has a user base and someone who cares about the basics *in
upstream*, I'm the last one to rip things out and reduce the usefulness
of Xenomai. But it takes a little bit of involvement at least.

There is no Xenomai if everyone is only looking at own code. At least no
Xenomai like you would expect it, silently.

Jan

[1]
https://source.denx.de/Xenomai/xenomai/-/commit/72bbbb61df39667bdffe0b0ad3a65049b5f20908
[2]
https://source.denx.de/Xenomai/xenomai/-/commit/b6db45b61f1def8e4ca39f388f90802f75f1d0a8


> Thanks for the information.
> 
> Peter
> 
> 
> 
> 
> On 7/13/2021 10:08 AM, Jan Kiszka wrote:
>> On 13.07.21 15:57, Peter Laurich via Xenomai wrote:
>>> Hi,
>>>
>>> I noticed this patch being submitted and was caught a bit off-guard by
>>> the situation. How long has it been since Analogy was actively
>>> maintained? A lot of the drivers that I have developed use the Analogy
>>> API to pass information between acquisition hardware and user-space code.
>>>
>> Hah, finally a reaction, after so many calls! :)
>>
>> Well, the last driver change not fixing forward-porting issues or
>> adjusting to refactorings was this one, I think:
>>
>> commit 328b0447cfa282fbe926ebbd9113224e4a1c18b9
>> Author: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>> Date:   Thu Aug 13 10:23:16 2015 -0400
>>
>>     drivers/analogy: release pci region if mapping failed
>>
>> So, almost 6 years ago. No one cared since then, neither by adding new
>> drivers or features, nor by fixing issues that should have been visible
>> by using things (only issues found by chance when looking at or
>> compiling of code).
>>
>> Are you still actively using analogy? Or are you considering to?
>>
>> Jan
>>

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

