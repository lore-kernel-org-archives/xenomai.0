Message-ID: <47AB0B79.8000709@domain.hid>
Date: Thu, 07 Feb 2008 14:45:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200710081503.15198@domain.hid> <200802061509.13010@domain.hid>
	<2ff1a98a0802070523r7af4ec4fv20f514b0cf1868c@domain.hid>
In-Reply-To: <2ff1a98a0802070523r7af4ec4fv20f514b0cf1868c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] FPU not available
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai-help <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> On Wed, Feb 6, 2008 at 3:09 PM, Petr Cervenka <grugh@domain.hid> wrote:
>> Hello.
>>  Recently, we switched to newer distribution of linux (Kubuntu 7.10). During this switch we changed many things (Xenomai 2.4.1, linux kernel 2.6.24, x86_64 architecture, ...).
>>  No we have problem, that in one of our tasks we are sometimes not able to use floating point operations (under very specific circumstances) . In such case, that task crashes immediately, but rest of the application runs "normaly". Output from dmesg is attached to this message. Task was created with T_FPU flag.
>>  Is there anything we can check or change?
>>  Petr Cervenka
> 
> I do not know if this is related to the issue you are facing, but the
> first FPU fault of a thread running in primary mode may be handled by
> Xenomai without switching to secondary mode. So, maybe the fault
> epilogue implicitely expects Xenomai to have switched the fault to
> secondary mode and use some secondary mode services such as
> ipipe_restore_root, whereas the thread never leaved primary mode.
> 

Good point! That is probably this path (and not the one I starred on):

__ipipe_handle_exception()
	...
	if (unlikely(ipipe_trap_notify(vector, regs))) {
		local_irq_restore(flags);
		return 1;
	}

That needs some more thoughts...

Petr, confirming our assumptions with the help of the tracer is still
valuable!

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

