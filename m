References: <1485850637.4051.13.camel@smigroup.net>
 <1485851307.4051.16.camel@smigroup.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <0b7857ad-778f-0e53-cff3-555298397245@xenomai.org>
Date: Tue, 31 Jan 2017 10:34:05 +0100
MIME-Version: 1.0
In-Reply-To: <1485851307.4051.16.camel@smigroup.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ARM L2C-310 cahce controller enabling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mauro Salvini <mauro.salvini@smigroup.net>, xenomai@xenomai.org

On 01/31/2017 09:28 AM, Mauro Salvini wrote:
> Hi,
> sorry, found myself the answer here:
> 
> http://git.xenomai.org/ipipe.git/commit/?h=ipipe-4.1.y&id=a2a9a6148449095fa658a6d0d0cbed3308be2cfb
> 
> So, should be L2 cache disabled for iMX6SX (that has a single  core)?

Not the entire cache, but you may want to try running with
write-allocate off using the "l2x0_write_allocate" kernel switch, since
cache coherence issues are not going to be relevant in this case.

> 
> Thanks again, regards
> Mauro
> 
> On Tue, 2017-01-31 at 09:17 +0100, Mauro Salvini wrote:
>> Hi,
>> I'm working on a iMX6SX custom platform and I'm trying to use Xenomai on
>> top of it.
>> In the past, I tried Xenomai on a iMX6SX SabreSD demoboard using kernel
>> branch 4.1.15 from Freescale patched with Xenomai 3.0.1 (some little
>> rejections corrected by hand), and I was able to get a maximum latency
>> around 25us.
>> Now, using kernel 4.1.36 from Freescale Community (that integrates the
>> Freescale kernel branch) patched with Xenomai 3.0.3 I get maximum
>> latencies around 45us.
>>
>> Trying to figure out what is the source(s) of increased latencies, I
>> found these two kernel logs:
>>
>> [    0.000000] L2C: I-pipe: revision >= L310-r3p2 detected, forcing WA.
>> [    0.000000] L2C: I-pipe: write-allocate enabled, induces high
>> latencies.
>>
>> I wonder why L2C-310 cache controllers that are greater or equal to r3p2
>> revision must be forced enabled.
>>
>> In past I read (and asked) in this mailing list that L2 cache should be
>> disabled to avoid higher latencies (as kernel log says).
>>
>> Thanks in advance, best regards
>>
>> Mauro
>>
>>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai
> 
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
> 


-- 
Philippe.

