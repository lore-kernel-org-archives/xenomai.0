References: <E1dcPNl-0001Jt-0M@xenomai.org>
 <78857f31-96f4-c139-3058-71537cb3081e@siemens.com>
 <8e6ee34a-8dde-419b-abd9-c9d513140028@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a302fbe7-202a-b2cb-f6ea-8e2882325065@siemens.com>
Date: Thu, 31 Aug 2017 17:18:20 +0200
MIME-Version: 1.0
In-Reply-To: <8e6ee34a-8dde-419b-abd9-c9d513140028@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Jan Kiszka : cobalt: Introduce xnftrace_printf
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 2017-08-31 17:01, Philippe Gerum wrote:
> On 08/31/2017 04:47 PM, Jan Kiszka wrote:
> 
>>> +	trace_puts(buf);
> 
> IIRC, this may need to be #ifdef'ed on CONFIG_FTRACE.

Indeed, only trace_printk is protected. Fill fix.

> 
>>
>> Any remarks on this approach? Does it take a reasonable direction?
>>
> We need that I believe. Another option would be to connect this as
> __xntrace_op_ftrace to save a syscall definition, although this is not
> the same trace channel - but still ftrace underneath. No strong opinion
> on this.

It's a different channel and we will have to cast a parameters. But if
syscall numbers are considered valuable, I can do this.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

