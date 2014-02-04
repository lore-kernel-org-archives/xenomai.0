Message-ID: <52F12700.3020400@xenomai.org>
Date: Tue, 04 Feb 2014 18:44:32 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1WAhle-0006kB-0q@sd-51317.dedibox.fr>
 <52F1172B.2080500@xenomai.org> <52F11F94.9000309@siemens.com>
 <52F1231A.7080603@xenomai.org> <52F12442.3040301@xenomai.org>
 <52F125E8.6020200@xenomai.org>
In-Reply-To: <52F125E8.6020200@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : alchemy: Replace static
 variable no_alchemy_task with macro
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-git@xenomai.org, Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 02/04/2014 06:39 PM, Philippe Gerum wrote:
> On 02/04/2014 06:32 PM, Gilles Chanteperdrix wrote:
>> On 02/04/2014 06:27 PM, Philippe Gerum wrote:
>>> If g++ chokes on the initializer part because it is outdated, then using
>>> old-fashioned ones may be an option. Actually, I find macroizing this
>>> definition quite bad.
>>>
>>> static const RT_TASK no_alchemy_task = {
>>> -    .handle = 0,
>>> -    .thread = 0
>>> +    handle: 0,
>>> +    thread: 0
>>>     };
>>
>> No, the previous version is better, it is standard compliant C and C++,
>> the second version is a gcc extension, which works only when compiling
>> C, if I remember correctly.
>>
>
> Recent g++ is happy with both (no -std forced though). But the former is
> allowed by the C++ parser only since recently.
>

Well, on the other hand:
static const RT_TAKS no_alchemy_task;

Will zero initialized the structure just as well...

-- 
					    Gilles.

