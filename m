Message-ID: <541184E5.7090505@siemens.com>
Date: Thu, 11 Sep 2014 13:17:57 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <54115FD0.1030303@siemens.com> <54116C52.8000803@xenomai.org>
In-Reply-To: <54116C52.8000803@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe: Comment in __ipipe_handle_exception
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 2014-09-11 11:33, Philippe Gerum wrote:
> On 09/11/2014 10:39 AM, Jan Kiszka wrote:
>> Hi Philippe,
>>
>> in 2338107647 I found this:
>>
>> @@ -383,6 +380,8 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
>>  			local_irq_disable();
>>  	}
>>  
>> +	/*
>> +	 * XXX: We don't trace page faults (yet?). */
>>  	if (vector == ex_do_page_fault)
>>  		cr2 = native_read_cr2();
>>  
>>
>> What is the background? Any open issue?
>>
> 
> The current interposition we do via std_extable is not aware of trace_*
> hooks in entry*.S, so we end up bypassing the trace encapsulation
> entirely in __ipipe_handle_exception. Nothing bad, it just needs some
> work to do this cleanly. This is for x86_64, ia32 might be slightly
> different, but the issue should apply the same way.

Which tracing are you referring to? There are at least three in the
assembly entries (ftrace, Linux IRQSOFF tracing, I-pipe tracing). And I
unfortunately still don't get how those relate to the reading of CR2.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

