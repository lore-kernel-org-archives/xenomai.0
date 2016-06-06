References: <CAL8zT=j3AF5CEmEsDczFbb_i7Fe72gOMENLN3yQh_WWu59jrvw@mail.gmail.com>
 <20160603091339.GM1801@hermes.click-hack.org>
 <20160603135534.GD28301@csclub.uwaterloo.ca>
 <20160603140959.GQ1801@hermes.click-hack.org>
 <CAL8zT=gPm8W4hFMrWaKCMtnWGKzN1wShdJG1Wnhj294g9pWk8Q@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <93226060-d8e8-e245-6356-04d9229ffba3@xenomai.org>
Date: Mon, 6 Jun 2016 09:46:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAL8zT=gPm8W4hFMrWaKCMtnWGKzN1wShdJG1Wnhj294g9pWk8Q@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Migrating a Xenomai 2.6.4 to a 4.6 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jean-Michel Hautbois <jhautbois@gmail.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 06/03/2016 04:20 PM, Jean-Michel Hautbois wrote:
> Hi,
> 
> 2016-06-03 16:09 GMT+02:00 Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org>:
> 
>> On Fri, Jun 03, 2016 at 09:55:34AM -0400, Lennart Sorensen wrote:
>>> On Fri, Jun 03, 2016 at 11:13:39AM +0200, Gilles Chanteperdrix wrote:
>>>> The APIs have not changed much. The cost is not very high. The
>>>> changes are documented here:
>>>> https://xenomai.org/migrating-from-xenomai-2-x-to-3-x/
>>>>
>>>> You will have to:
>>>> - port the I-pipe patch for Linux 4.1 to Linux 4.6
>>>
>>> Would that not be required for xenomai 3.x as well though?
>>>
>>>> - add to the I-pipe patches the "I-pipe legacy" support, which was
>>>> removed from 4.1
>>>> - add the missing bits to Xenomai to adapt to the kernel API changes
>>>> between Linux 3.18 and Linux 4.6, of which there should be a fair
>>>> amount, given the difference in version numbers.
>>>>
>>>> So, the best strategy is to not migrate xenomai 2.6.4 to a 4.6
>>>> kernel.
>>>>
>>>>> Would you be interested by the patches once done ?
>>>>
>>>> No. Xenomai 2.6.5 is about to be released, will not support 4.x
>>>> kernel, and will be the last release in the 2.6 branch. We simply do
>>>> not have the man power to maintain two branches, and for this
>>>> reason, want to encourage the users to migrate.
>>>
>>> That does make sense.
>>
>>
>>From a maintenance point of view, it definitely makes sense.
> So, perhaps the best is to try out mercury and use only PREEMPT-RT patches
> on the kernel side, along with the compat layer on the userspace side...
> 
> 
>>> Of course a lot of people are scared of moving xenomai versions.  3
>> sounds
>>> quite different than 2.6, and I certainly remember having a fair bit of
>>> pain going from 2.5 to 2.6 years ago (some of it was probably self
>> inflicted).
>>
>> As far as I remember there were almost no API changes between 2.5
>> and 2.6. The main reason to switch from 2.5 to 2.6 was to fix an
>> issue that could not be fixed reasonably without breaking the ABI.
>>
> 
> I am scared by the compatibility between the existing  2.6 and the
> now-to-be-used 3.x.
> 

If you have any specific example of incompatibilities breaking your
current design, please let us know. If your application has been using
the POSIX or "native" Xenomai 2.6 API so far, with drivers based on
RTDM, you should not find any.

To clarify the Xenomai project's stance on these matters, we discourage
people from basing _new_ projects on the Xenomai 2.6.x series (or
earlier, obviously). Those projects should start with 3.x, because it is
actively maintained and developed, whereas 2.6.x is officially EOL.

However, some production-grade projects already deployed which have to
stick with Xenomai 2.6.x may want to upgrade to Linux 4.x. For this
reason, I pushed the commits  required to build the upcoming Xenomai
2.6.5 against Linux 4.1. However, those projects will be on their own
with respect to maintaining the Xenomai 2.6.x + I-pipe combo for kernel
releases beyond 4.1.

-- 
Philippe.

