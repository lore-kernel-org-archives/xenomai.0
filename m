Message-ID: <54D3920E.7060706@xenomai.org>
Date: Thu, 05 Feb 2015 16:53:50 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1928985868.3780.1423040133670.JavaMail.zimbra@wandercraft.eu>
 <54D1E2AA.40000@xenomai.org>
 <2118665101.4111.1423048074765.JavaMail.zimbra@wandercraft.eu>
 <735225138.4138.1423050050231.JavaMail.zimbra@wandercraft.eu>
 <54D21CCE.5000607@xenomai.org>
 <498604834.10542.1423145127729.JavaMail.zimbra@wandercraft.eu>
 <54D38147.8010503@xenomai.org>
 <1533670141.11145.1423150163559.JavaMail.zimbra@wandercraft.eu>
In-Reply-To: <1533670141.11145.1423150163559.JavaMail.zimbra@wandercraft.eu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai 3 - no skin detected in program
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Cc: xenomai@xenomai.org

On 02/05/2015 04:29 PM, Huy Cong Vu wrote:
> 
> 
> ----- Mail original -----
>> De: "Philippe Gerum" <rpm@xenomai.org>
>> À: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
>> Cc: xenomai@xenomai.org
>> Envoyé: Jeudi 5 Février 2015 15:42:15
>> Objet: Re: [Xenomai] Xenomai 3 - no skin detected in program
> 
>> On 02/05/2015 03:05 PM, Huy Cong Vu wrote:
>>>
>>>
>>> ----- Mail original -----
>>>> De: "Philippe Gerum" <rpm@xenomai.org>
>>>> À: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
>>>> Cc: xenomai@xenomai.org
>>>> Envoyé: Mercredi 4 Février 2015 14:21:18
>>>> Objet: Re: [Xenomai] Xenomai 3 - no skin detected in program
>>>
>>>> On 02/04/2015 12:40 PM, Huy Cong Vu wrote:
>>>>>
>>>>>
>>>>> ----- Mail original -----
>>>>>> De: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>
>>>>>> À: "Philippe Gerum" <rpm@xenomai.org>
>>>>>> Cc: xenomai@xenomai.org
>>>>>> Envoyé: Mercredi 4 Février 2015 12:07:54
>>>>>> Objet: Re: [Xenomai] Xenomai 3 - no skin detected in program
>>>>>
>>>>>> ----- Mail original -----
>>>>>>> De: "Philippe Gerum" <rpm@xenomai.org>
>>>>>>> À: "Huy Cong Vu" <huy-cong.vu@wandercraft.eu>, xenomai@xenomai.org
>>>>>>> Envoyé: Mercredi 4 Février 2015 10:13:14
>>>>>>> Objet: Re: [Xenomai] Xenomai 3 - no skin detected in program
>>>>>>
>>>>>>> On 02/04/2015 09:55 AM, Huy Cong Vu wrote:
>>>>>>>> Hello everyone,
>>>>>>>> I recently try to run an application compiled in native skin of Xenomai 3. When
>>>>>>>> trying to run the binary, these line appeared:
>>>>>>>> WARNING: [main] no skin detected in program
>>>>>>>> BUG: [main] initialization failed, EINVAL
>>>>>>>> I know that this is a cooperplate_init() warning when trying to initialize
>>>>>>>> native skin, but I don't understand the reason why:
>>>>>>>> if (pvlist_empty(&skins)){
>>>>>>>> warning("no skin detected in program");
>>>>>>>> ret = -EINVAL;
>>>>>>>> goto fail;
>>>>>>>> }
>>>>>>>
>>>>>>> It seems that your application was not linked against libalchemy.so.
>>>>>>> When API libraries are properly linked in, internal constructor routines
>>>>>>> populate this list. POSIX support is built-in within the Cobalt
>>>>>>> interface, so it won't appear here though.
>>>>>>>
>>>>> I change the order of the linker flags, now my app is linked against
>>>>> libalchemy.so, but this message shown up:
>>>>> symbol lookup error: /usr/xenomai/lib/libcopperplate.so.0: undefined symbol:
>>>>> main
>>>>>
>>>>> I guess that it stills a problem due to the linker flag, am I right?
>>>>>
>>>>
>>>> Yes. You seem to be using a set of flags with fine-grained tuning, some
>>>> of which might have an adverse effect on your linking stage. You should
>>>> start with the set output by xeno-config --ldflags --alchemy which are
>>>> known to work, then tune gradually as appropriate.
>>>>
>>>
>>> Hi Philippe,
>>>
>>> I'm getting close to it, but it still left some undefined reference for rtdm
>>> functions.
>>>
>>
>> rtdm_socket() is a kernel-space API for inter-driver calls, socket() is
>> what you need for creating a RTDM socket endpoint in your application.
>> The Cobalt implementation will be used provided the linker is passed the
>> proper flags (which you Makefile does).
> 
> So that means I will always end up in calling socket() for all skins (alchemy or cobalt) and let the linker flags differs it in kernel space?

The API layers for x3 are described here:
http://xenomai.org/start-here/#How_does_Xenomai_deliver_real-time

alchemy is one of the non-POSIX APIs.

-- 
Philippe.

