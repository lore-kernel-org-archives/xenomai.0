Message-ID: <548B481E.3050103@nta-inc.net>
Date: Fri, 12 Dec 2014 13:55:10 -0600
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <5489D81D.7070003@nta-inc.net> <548AAB8A.7060406@xenomai.org>
In-Reply-To: <548AAB8A.7060406@xenomai.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] switchtest in Xenomai-3.0-rc2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 12/12/2014 02:47 AM, Philippe Gerum wrote:
> On 12/11/2014 06:45 PM, Jeff Webb wrote:
>> In Xenomai-3.0-rc2, doc/asciidoc/TROUBLESHOOTING.COBALT.adoc still says
>> this:
>>
>>
>> === Issues when running the _switchtest_ program
>>
>> ==== pthread_create: Resource temporarily unavailable
>>
>> The switchtest test creates many kernel threads, this means that the
>> options +CONFIG_XENO_OPT_SYS_HEAPSZ+ and
>> +CONFIG_XENO_OPT_SYS_STACKPOOLSZ+, in your kernel configuration,
>> should be configured to large enough values. Try increasing them,
>> rebuilding the kernel.
>>
>>
>> but, it looks like CONFIG_XENO_OPT_SYS_STACKPOOLSZ has been removed in
>> Xenomai-3.  Is there another an equivalent variable that I might need to
>> increase, or is increasing CONFIG_XENO_OPT_SYS_HEAPSZ sufficient to get
>> rid of the error below?
>>
>
> It is sufficient to increase SYS_HEAPSZ, there is no private stack pool
> anymore, since Xenomai kthreads are now fully mapped over regular
> kthreads. i.e. we don't have to allocate stacks for our kernel threads,
> we simply inherit the kernel stack underlying the new regular kthread.
>
> The doc was fixed accordingly. Thanks for the heads up.
>

That worked.  Thanks!

-Jeff


