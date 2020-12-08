Subject: Re: [CXP][RFC] pick POSIX/cobalt for the common user API
References: <87mtyr1abi.fsf@xenomai.org> <5FCD907C.6040309@tj.kylinos.cn>
 <87h7oxvsa9.fsf@xenomai.org>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <5FCED564.5090906@tj.kylinos.cn>+F40ADB417664605B
Date: Tue, 8 Dec 2020 09:22:44 +0800
MIME-Version: 1.0
In-Reply-To: <87h7oxvsa9.fsf@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

clear to me, many thanks.

BR

chensong

On 2020年12月07日 18:12, Philippe Gerum wrote:
>
> Hi,
>
> chensong via Xenomai <xenomai@xenomai.org> writes:
>
>> hi Philippe,
>>
>> As far as i know, some vxworks customers like xenomai because they can
>> move their RT processes from vxworks to linux without rewriting their
>> code by the help of vxworks skin.
>>
>> If we "Excluding the legacy RTOS emulators such as VxWorks", we will
>> lose them. It could depend on the balance of the request and effort.
>>
>
> There are two different aspects to consider. First, there is the CXP
> which should define a common ground between future Xenomai releases
> starting from 3.3, which is different from deciding on the feature set
> such releases would include in total eventually. We may want a given
> Xenomai release to support multiple APIs, which would definitely include
> the one specified by the CXP.
>
> In that sense, I'm only excluding the VxWorks API as a possible choice
> for the common API specified by the CXP since this would have no upside
> with respect to usability or portability from Xenomai 3.x to 4.x. I was
> not referring to the presence of the VxWorks API in future Xenomai 3.x
> releases, although the complete lack of feedback from users regarding
> the RTOS emulators may simply mean that most projects already moved away
> from these legacy APIs anyway.
>
> Next, there is the question of whether the VxWorks API, and generally
> speaking RTOS emulators should be present in Xenomai 4. I'm going to
> oppose to such inclusion. These are my reasons:
>
> - as I just hinted at, I believe that too few projects might still be
>    interested in moving from VxWorks to Linux based on API emulation
>    these days, at least not enough to justify the cost of maintaining
>    RTOS emulators. I reckon that most of the legacy apps which should
>    move to Linux already did so by now, many of them based on API
>    conversion instead (e.g. VxWorks -> POSIX). We need to keep in mind
>    that those emulators only cover the BSP-independent APIs, those which
>    can be easily converted to another dialect because there is no
>    hardware-related specifics, with their underlying semantics being very
>    similar (e.g. VxWorks mutex-typed sema4s and POSIX mutexes are quite
>    close in essence).
>
> - generally speaking, Xenomai 4 is going to be all about simplicity and
>    resource-efficiency, in order to address use cases, which I believe
>    are beyond native preemption's reach: meeting ultra-low latency
>    requirements reliably without having to play whack-a-mole with tricky
>    runtime settings, regardless of the ongoing system stress, down to
>    low-end hardware. We should be heading for a real-time sub-system
>    which just delivers out of the box once enabled in the kernel, nicely
>    integrated into the Linux environment, not on the edge of it. Basic
>    but usable, simple but efficient. Among other things, this should
>    involve a limited set of dedicated APIs, all with native support from
>    the real-time core, which is to say without requiring any mediating
>    layer like libcopperplate. As a matter of fact, libcopperplate was
>    designed as a set of common blocks for implementing non-native APIs
>    like RTOS emulators on top of a native interface.
>
> - the Xenomai project has always run on a very limited amount of human
>    resources, including for implementing and more importantly maintaining
>    APIs. Each additional API is one burden more for Xenomai contributors
>    to maintain, and users to comprehend.  I'd rather make sure that a
>    single API is shared and exercised by many users, properly maintained
>    and documented, compared to having many - potentially unused - APIs
>    diluting the maintenance effort.
>



