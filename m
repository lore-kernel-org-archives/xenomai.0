References: <20210220151840.409745-1-rpm@xenomai.org>
 <20210220151840.409745-2-rpm@xenomai.org>
 <7200b2df730dc65a5ce7e531109b6ba663e88ae7.camel@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 2/5] cobalt/kernel: y2038: convert struct timespec to
 timespec64
In-reply-to: <7200b2df730dc65a5ce7e531109b6ba663e88ae7.camel@siemens.com>
Date: Thu, 04 Mar 2021 10:44:20 +0100
Message-ID: <875z271cej.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Cc: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>


florian.bezdeka@siemens.com <florian.bezdeka@siemens.com> writes:

> On Sat, 2021-02-20 at 16:18 +0100, Philippe Gerum via Xenomai wrote:
> [snip]
>> +#if __BITS_PER_LONG == 64
>
> That might be a beginner question, but I'm learning from the best ;-)
>
> Do we really care about each single assignment (two per timespec) and
> each object on the stack that it is worth duplicating all this helpers?
> We could use the __BITS_PER_LONG == 32 version for both worlds,
> couldn't we?

Yes, this would work as well. I agree that the very limited gain is not
worth the code duplication.

-- 
Philippe.

