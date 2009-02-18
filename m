Message-ID: <499C1394.3030905@domain.hid>
Date: Wed, 18 Feb 2009 14:56:36 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <499B36C5.3060104@domain.hid> <499B3F35.2080604@domain.hid>
	<499B5136.2030107@domain.hid> <499B55CF.3020005@domain.hid>
	<499BBF88.9000207@domain.hid> <499BE2E7.4090704@domain.hid>
	<499BF9BB.3090700@domain.hid> <499C0E33.3070606@domain.hid>
	<499C1288.9040607@domain.hid>
In-Reply-To: <499C1288.9040607@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] __ipipe_syscall_root logic
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
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> ...
>>> However, let's assumed we entered __ipipe_syscall_root with root domain
>>> stalled. If we then return from __ipipe_dispatch_event with 0 (=>
>>> forward this syscall to Linux), we would not call __fixup_if again so
>>> that the stalled state is kept. Is this a valid scenario for the given
>>> task, or would this be broken already? At least it looks like the path
>>> taken here
>> Could someone explain __ipipe_syscall_root to me? The comment before the
>> second __fixup_if() does not help me understanding why we only have to
>> call it when we do not forward the syscall to Linux. In other words,
>> this version would make more sense to me (32-bit variant, but 64-bit
>> looks as fishy as its little brother):
> 
> My understanding is that we should call fixup_if again if we changed
> domain while handling the syscall.

Yep, but does this derive indirectly from the return code of
__ipipe_dispatch_event? AFAIU, it shouldn't, so we should fix up
unconditionally if we entered the dispatcher.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

