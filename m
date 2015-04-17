Message-ID: <55315058.6090502@siemens.com>
Date: Fri, 17 Apr 2015 20:26:32 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <55314426.7040300@siemens.com>
 <20150417175028.GP1589@hermes.click-hack.org> <55314B85.2030708@siemens.com>
 <20150417180819.GQ1589@hermes.click-hack.org> <55314CA0.7070705@siemens.com>
 <20150417181254.GR1589@hermes.click-hack.org> <55314E36.3040201@siemens.com>
 <20150417182459.GS1589@hermes.click-hack.org>
In-Reply-To: <20150417182459.GS1589@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Dealing with too small thread stacks
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2015-04-17 20:24, Gilles Chanteperdrix wrote:
> On Fri, Apr 17, 2015 at 08:17:26PM +0200, Jan Kiszka wrote:
>> On 2015-04-17 20:12, Gilles Chanteperdrix wrote:
>>> On Fri, Apr 17, 2015 at 08:10:40PM +0200, Jan Kiszka wrote:
>>>> On 2015-04-17 20:08, Gilles Chanteperdrix wrote:
>>>>> On Fri, Apr 17, 2015 at 08:05:57PM +0200, Jan Kiszka wrote:
>>>>>> On 2015-04-17 19:50, Gilles Chanteperdrix wrote:
>>>>>>> On Fri, Apr 17, 2015 at 07:34:30PM +0200, Jan Kiszka wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> analyzing page faults of an application that prefers to set its own
>>>>>>>> stacks, I noticed a problem in Xenomai (2 and 3), at least from the
>>>>>>>> usability POV: We document the minimum stack stack as PTHREAD_STACK_MIN
>>>>>>>> + 1 page, at least in Xenomai 3, and we enforce that on thread creation.
>>>>>>>> However, enforcement is doomed to fail if the stack is preallocated (and
>>>>>>>> that too small).
>>>>>>>>
>>>>>>>> As we cannot detect if the user set a stack address in pthread_attr_t, I
>>>>>>>> would suggest to fail thread creation instead of performing it with
>>>>>>>> improper parameters. Other suggestions? If not, I would prepare a patch
>>>>>>>> for Xenomai 3 (for 2 only if desired).
>>>>>>>
>>>>>>> It seems to me we can detect the parameters in the pthread_attr_t
>>>>>>> using pthread_attr_getstack. So, we can get __wrap_pthread_create to
>>>>>>> fail if the size is not sufficient.
>>>>>>
>>>>>> Nope, unfortunately not:
>>>>>>
>>>>>> "If the pthread_attr_getstack() function is called before the stackaddr
>>>>>> attribute has been set, the behavior is unspecified."
>>>>>
>>>>> It is unspecified by POSIX, but Xenomai supports only two
>>>>> implementations, glibc and uClibc, so, we can look at what these two
>>>>> libraries do. I would bet they return you a NULL stack pointer or
>>>>> something.
>>>>
>>>> I would have expected that, too, but the results for glibc seem random.
>>>> Plus there is the risk that something changes, thus we become
>>>> version-dependent.
>>>
>>> Ok then, what about the influence of pthread_attr_setstack() on
>>> pthread_attr_getstacksize(), maybe more luck there?
>>
>> setstack defines the size getstacksize returns. So does setstacksize.
>>
>> What happens during setstacksize is apparently that the address is set
>> to NULL - size. But, again, that is just the current glibc behaviour.
> 
> Yes, ok, but in order to test the stack size passed by the user, it
> simply means we can use getstacksize and bail out if not sufficient.

Sure, that would be the best way.

Along that, I would recommend raising the minimum to 2*PTHREAD_STACK_MIN.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

