Message-ID: <54116C52.8000803@xenomai.org>
Date: Thu, 11 Sep 2014 11:33:06 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <54115FD0.1030303@siemens.com>
In-Reply-To: <54115FD0.1030303@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] ipipe: Comment in __ipipe_handle_exception
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 09/11/2014 10:39 AM, Jan Kiszka wrote:
> Hi Philippe,
> 
> in 2338107647 I found this:
> 
> @@ -383,6 +380,8 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
>  			local_irq_disable();
>  	}
>  
> +	/*
> +	 * XXX: We don't trace page faults (yet?). */
>  	if (vector == ex_do_page_fault)
>  		cr2 = native_read_cr2();
>  
> 
> What is the background? Any open issue?
> 

The current interposition we do via std_extable is not aware of trace_*
hooks in entry*.S, so we end up bypassing the trace encapsulation
entirely in __ipipe_handle_exception. Nothing bad, it just needs some
work to do this cleanly. This is for x86_64, ia32 might be slightly
different, but the issue should apply the same way.

-- 
Philippe.

