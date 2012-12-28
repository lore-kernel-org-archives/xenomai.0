Message-ID: <50DDD713.7080808@nta-inc.net>
Date: Fri, 28 Dec 2012 11:29:55 -0600
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <50dd8fe7a2bbd6.25169205@wp.pl> <50DDB448.2050307@xenomai.org>
	<50DDBBE2.20403@gmail.com> <50DDBE66.3040405@xenomai.org>
	<50DDCFB4.3070206@nta-inc.net> <50DDD0A6.3080305@nta-inc.net>
In-Reply-To: <50DDD0A6.3080305@nta-inc.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] posix/stdio.h error: ?size_t? does not name a type
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 12/28/2012 11:02 AM, Jeff Webb wrote:
> On 12/28/2012 10:58 AM, Jeff Webb wrote:
>> On 12/28/2012 09:44 AM, Gilles Chanteperdrix wrote:
>>> On 12/28/2012 04:33 PM, hauptmech wrote:
>>>
>>>> On 12/28/2012 04:01 PM, Gilles Chanteperdrix wrote:
>>>>> On 12/28/2012 01:26 PM, Mariusz Janiak wrote:
>>>>>
>>>>>> Hi
>>>>>>
>>>>>> After successful Xenomai 2.6.2 installation (with Gilles help), I have started building OROCOS 2.6 with xeno support, and once again I went into trouble. This time I am not sure that it is a Xenomai related bug. The problem is following
>>>>>>
>>>>>> from /worek/install/orocos-toolchain-xeno/rtt/rtt/transports/mqueue/MQLib.hpp:42,
>>>>>>                        from /worek/install/orocos-toolchain-xeno/rtt/rtt/transports/mqueue/MQLib.cpp:40:
>>>>>>       /usr/xenomai/include/xenomai/posix/stdio.h:30:1: error: ?size_t? does not name a type
>>>>>>       make[2]: *** [rtt/transports/mqueue/CMakeFiles/rtt-transport-mqueue-xenomai_plugin.dir/MQLib.cpp.o] Błąd 1
>>>>>>
>>>>>> I have found one thread related to this problem
>>>>>>
>>>>>> http://www.xenomai.org/pipermail/xenomai/2012-September/026143.html
>>>>>>
>>>>>> Adding #include <unistd.h> in /usr/xenomai/include/xenomai/posix/stdio.h have solved my problem, but I don't know if it is a suitable solution.
>>>>>
>>>>> Hi Mariusz,
>>>>>
>>>>> thanks for the report. Could you tell me which distribution and which
>>>>> version you are using? We are certainly not going to include unistd.h in
>>>>> stdio.h, the fact that size_t is not defined indicates that something
>>>>> else is wrong as there are services supposedly defined in stdio.h which
>>>>> use size_t.
>>>>>
>>>>> Regards.
>>>> http://gcc.gnu.org/gcc-4.7/porting_to.html (search for unistd.h)
>>>>
>>>> The correct fix is probably to add unistd.h to MQLib.hpp (and other
>>>> include files that are missing it)
>>>
>>>
>>> This does not look like the same issue: using size_t is valid in stdio.h
>>> without including unistd.h
>>>
>>> I will install the same distribution as Mariusz to try and reproduce the
>>> issue.
>>>
>
> I ran into a similar issue under Ubuntu 12.04 and Xenomai-2.6.1+.  I was also using C++, so maybe it isn't a problem in C...
>
> -Jeff
>

Here's some more information.  This C++ program fails to compile under Xenomai because ‘size_t’ does not name a type.  It compiles fine without Xenomai:

#include <iostream>

int main()
{
     size_t t = 1;
     t += 1;
     return 0;
}

But this one compiles:

#include <cstdio>
#include <iostream>

int main()
{
     size_t t = 1;
     t += 1;
     return 0;
}

The following program compiles as C++ or C:

#include <stdio.h>

int main()
{
     size_t t = 1;
     t += 1;
     return 0;
}

I hope this helps.

-Jeff



