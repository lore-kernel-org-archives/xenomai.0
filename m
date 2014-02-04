Message-ID: <52F1231A.7080603@xenomai.org>
Date: Tue, 04 Feb 2014 18:27:54 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <E1WAhle-0006kB-0q@sd-51317.dedibox.fr>
 <52F1172B.2080500@xenomai.org> <52F11F94.9000309@siemens.com>
In-Reply-To: <52F11F94.9000309@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org, xenomai-git@xenomai.org

On 02/04/2014 06:12 PM, Jan Kiszka wrote:
> On 2014-02-04 17:36, Philippe Gerum wrote:
>> On 02/04/2014 04:18 PM, git repository hosting wrote:
>>> Module: xenomai-jki
>>> Branch: for-forge
>>> Commit: bffcc58ed0114985a4d8d8a4cff2adff1b13292d
>>> URL:
>>> http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=bffcc58ed0114985a4d8d8a4cff2adff1b13292d
>>>
>>>
>>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>>> Date:   Tue Feb  4 16:12:07 2014 +0100
>>>
>>> alchemy: Replace static variable no_alchemy_task with macro
>>>
>>> The current definition of a static const variable representing an
>>> invalid alchemy task is both C++-incompatible and also ugly as we do not
>>> use them in every module that includes task.h. So replace it with a
>>> macro that builds the required struct on-the-fly.
>>
>> Could you elaborate on the ugly part of things? I don't really get your
>> point.
>
> It is ugly to define potentially unused static variables in a header,
> even more when this header is part of the public interface, pulled in by
> our users with hard to predict compiler configurations.

This is a const static, exposed as a common definition, which normally 
has no existence in the data segment when built with g++ 4.x. Not even 
with -O0.

So maybe you could tell us which is the exact issue you have beyond the 
struct initializer issue, and the compiler release you are currently 
using, along with the build flags?

But more
> important is the conflict with C++ (including C++11).
>

If g++ chokes on the initializer part because it is outdated, then using 
old-fashioned ones may be an option. Actually, I find macroizing this 
definition quite bad.

static const RT_TASK no_alchemy_task = {
-	.handle = 0,
-	.thread = 0
+	handle: 0,
+	thread: 0
  };

-- 
Philippe.

