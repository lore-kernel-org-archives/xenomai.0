Message-ID: <52F125BC.9030206@xenomai.org>
Date: Tue, 04 Feb 2014 18:39:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1WAhle-0006kB-0q@sd-51317.dedibox.fr>
 <52F1172B.2080500@xenomai.org> <52F11F94.9000309@siemens.com>
 <52F1231A.7080603@xenomai.org> <52F12442.3040301@xenomai.org>
 <52F124EF.4040804@siemens.com>
In-Reply-To: <52F124EF.4040804@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai-git@xenomai.org, xenomai@xenomai.org

On 02/04/2014 06:35 PM, Jan Kiszka wrote:
> On 2014-02-04 18:32, Gilles Chanteperdrix wrote:
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
>
> Designated initializer are _not_ standard compliant.

They are standard in C99 at least. I thought they were in C++0x as well, 
but googling a bit would seem to suggest that you are right.


-- 
					    Gilles.

