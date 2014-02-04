Message-ID: <52F123DC.1010307@xenomai.org>
Date: Tue, 04 Feb 2014 18:31:08 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1WAhle-0006kB-0q@sd-51317.dedibox.fr>
 <52F1172B.2080500@xenomai.org> <52F11F94.9000309@siemens.com>
In-Reply-To: <52F11F94.9000309@siemens.com>
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
> our users with hard to predict compiler configurations. But more
> important is the conflict with C++ (including C++11).

Are you sure you are using a C++ compiler recent enough?

Using g++ 4.7, I do not get any warning compiling the following code:

#include <stdio.h>
#include <stdlib.h>

struct x {
	unsigned a;
	unsigned b;
} y = {
	.a = 42,
	.b = 43,
};

int main(void)
{
	printf("%u\n", y.a);
}

Without even passing a -std option.


-- 
					    Gilles.

