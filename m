References: <550719c6-8d3d-1cb1-fc74-d0922b80deb3@siemens.com>
 <3440bd12-2bd3-7c09-1d51-a67853635ad7@xenomai.org>
 <85f76e95-d6e3-78e9-4401-f14163d6e81b@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <308e75ea-789b-8fd6-e4ad-7dc5e0e6d7b6@xenomai.org>
Date: Fri, 4 Nov 2016 12:10:43 +0100
MIME-Version: 1.0
In-Reply-To: <85f76e95-d6e3-78e9-4401-f14163d6e81b@siemens.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PULL] Trying to flushing my queue...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 11/02/2016 12:25 PM, Jan Kiszka wrote:
> On 2016-11-02 11:48, Philippe Gerum wrote:
>>>       boilerplate: Fix enabling Xenomai only in shared libs
>>
>> Superseded by #91f7a0c and #82b6325.
> 
> Not quite: I had to apply my patch on top of next, otherwise loading
> xenomai-dependent libs via dlopen didn't work. Apparently, __real_main
> wasn't optimized out in my build, thus main was still pulled.
> 

Actually, this wrapper does not make sense. Such a wrapper is supposed
to help when --wrap is not given at link time, for resolving direct
references to the real symbols nevertheless, such as those we may do
from __wrap routines. But nobody is going to call __real_main()
explicitly if --wrap is not given, by definition - the one that does
that is the bootstrap module, and this one depends on --wrap to be
passed to the linker anyway.

I can't see any situation where a reference to such placeholder for
main() would exist. I'm leaning to get rid of boilerplate/wrappers.c
entirely, making the patch pointless in the same move.

-- 
Philippe.

