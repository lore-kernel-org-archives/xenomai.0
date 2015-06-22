Message-ID: <5587E2D9.8000307@xenomai.org>
Date: Mon, 22 Jun 2015 12:26:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1434966877.74785.YahooMailBasic@web173202.mail.ir2.yahoo.com>
In-Reply-To: <1434966877.74785.YahooMailBasic@web173202.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] include guard trank/posix/pthread.h
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik_bayart@yahoo.co.uk>, xenomai@xenomai.org

On 06/22/2015 11:54 AM, Frederik Bayart wrote:
> 
> 
> 
> On Friday, 19 June 2015, 15:07, Philippe Gerum <rpm@xenomai.org> wrote:
>> On 06/19/2015 03:02 PM, Frederik Bayart wrote:
>>
>>
>>
>>
>>> Hallo,
>>> I noticed that both /usr/xenomai/include/trank/trank.h and  /usr/xenomai/include/trank/posix/pthread.h share the same include guard (_XENOMAI_TRANK_TRANK_H).Can this be an error ? I use compile flags 'xeno-config --skin=native --cflags' and get compile errors. If I change the include guard of pthread.h to _XENOMAI_TRANK_POSIX_PTHREAD_H, the problem seems to be solved.In attachment a diff with my changes.
>>> Frederik
>>>
>>
>> Yes, the guard is definitely wrong, will fix. Thanks for pointing this out.
>>
>> -- 
>> Philippe.
> 
> In the same context : to make it compile, I had to add
> /usr/xenomai/include/trank/posix to
>  $(shell xeno-config --skin=native --cflags).
> At the moment -I/usr/xenomai/include/trank -D__XENO_COMPAT__
>  -I/usr/xenomai/include/cobalt -I/usr/xenomai/include -D_GNU_SOURCE
>  -D_REENTRANT -D__COBALT__ -I/usr/xenomai/include/alchemy
> is returned.
> 
> If this is the correct solution, I can prepare a patch for
>  xeno-config if desired.
> 

Please do.

You seem to be combining the legacy native API and the POSIX interface,
which is fine, but would require --native --posix to be passed to
xeno-config if so.

-- 
Philippe.

