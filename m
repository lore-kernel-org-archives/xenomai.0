References: <E1ZIZjP-0001py-FB@sd-51317.xenomai.org>
 <5515ffa50f7d05764c02821440947bc5.squirrel@sourcetrek.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55B244BB.3030402@xenomai.org>
Date: Fri, 24 Jul 2015 15:59:23 +0200
MIME-Version: 1.0
In-Reply-To: <5515ffa50f7d05764c02821440947bc5.squirrel@sourcetrek.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum : boilerplate: add
 offsetof() shorthand
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

On 07/24/2015 03:20 PM, Gilles Chanteperdrix wrote:
> 
> git repository hosting wrote:
>> Module: xenomai-3
>> Branch: next
>> Commit: 2a584d6763c64f9e566b5f53094d57dd72688857
>> URL:
>> http://git.xenomai.org/?p=xenomai-3.git;a=commit;h=2a584d6763c64f9e566b5f53094d57dd72688857
>>
>> Author: Philippe Gerum <rpm@xenomai.org>
>> Date:   Thu Jul 23 19:13:29 2015 +0200
>>
>> boilerplate: add offsetof() shorthand
>>
>> ---
>>
>>  include/boilerplate/compiler.h |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/include/boilerplate/compiler.h
>> b/include/boilerplate/compiler.h
>> index e27d165..876e004 100644
>> --- a/include/boilerplate/compiler.h
>> +++ b/include/boilerplate/compiler.h
>> @@ -54,4 +54,8 @@
>>  #define __aligned(__n)	__attribute__((aligned (__n)))
>>  #endif
>>
>> +#ifndef offsetof
>> +#define offsetof(__type, __member)  __builtin_offsetof(__type, __member)
>> +#endif
> 
> offsetof should be defined by glibc headers. By adding a definition, you
> risk a compiler warning about multiple definitions if someone uses the
> proper glibc header.
> 
> 

There is hardly any risk of that kind when using the gcc builtin.

-- 
Philippe.

