References: <61813822-bfb7-e2ec-bce2-85a508eab0a5@alaxarxa.net>
 <49014e60-4b55-ed4e-a8c1-576231633c50@xenomai.org>
 <94ebb798-5816-98d0-dcb6-6ebe1651861c@alaxarxa.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <d550bf86-3526-c0af-076f-956dc17225ba@xenomai.org>
Date: Thu, 30 Nov 2017 17:46:37 +0100
MIME-Version: 1.0
In-Reply-To: <94ebb798-5816-98d0-dcb6-6ebe1651861c@alaxarxa.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xeno-config options to build Xenomai applications
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, Xenomai List <xenomai@xenomai.org>

On 11/30/2017 03:41 PM, Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> first of all thanks!!
> 
> On 30/11/17 14:31, Philippe Gerum wrote:
>> On 11/30/2017 01:32 PM, Leopold Palomo-Avellaneda wrote:
> 
> [....]
>>
>>> 3) C/C++ POSIX shared library with native (2.x) (--alchemy) code and xddm
>>> mechanism to interchange data. The posix code must not be wrapped
>>>
>>
>> Assuming you meant: the posix code should not be wrapped (i.e.
>> application requirement, not a Xenomai requirement).
> 
> ok, but could be any kind of conflict in the posix code is wrapped? xddm, etc?
>

With the app, could be. With the Xenomai libs, should not be as there
are provisions for avoiding this by explicitly marking the POSIX calls
there with either __RT() or __STD().

> 
> And just asking an idea. Could be possible "in theory" to build some big library
> as POCO to convert it to RT wrapping its POSIX funcions? I'm thinking in the
> thread class and the network module (RTNET)
> 

POSIX resources - sems, mutexes, condvars etc - can't be shared between
rt and non-rt domains (i.e. cobalt and glibc), so blindly wrapping all
POSIX calls may lead to unexpected results if there are calls on the
same resources between those domains.

Also, calling a non-wrapped portion of the library from a wrapped
portion would defeat the purpose of switching the POSIX calls issued by
the latter to Xenomai services. Wrapping should be handled on a case by
case basis, I don't see any "automatic" process for this.

-- 
Philippe.

