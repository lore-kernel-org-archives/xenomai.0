References: <E1dcPNl-0001Jt-0M@xenomai.org>
 <78857f31-96f4-c139-3058-71537cb3081e@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8e6ee34a-8dde-419b-abd9-c9d513140028@xenomai.org>
Date: Thu, 31 Aug 2017 17:01:16 +0200
MIME-Version: 1.0
In-Reply-To: <78857f31-96f4-c139-3058-71537cb3081e@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On 08/31/2017 04:47 PM, Jan Kiszka wrote:

>> +	trace_puts(buf);

IIRC, this may need to be #ifdef'ed on CONFIG_FTRACE.

> 
> Any remarks on this approach? Does it take a reasonable direction?
> 
We need that I believe. Another option would be to connect this as
__xntrace_op_ftrace to save a syscall definition, although this is not
the same trace channel - but still ftrace underneath. No strong opinion
on this.

-- 
Philippe.

