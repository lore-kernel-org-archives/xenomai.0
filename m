Message-ID: <444E8D7A.30900@domain.hid>
Date: Tue, 25 Apr 2006 22:58:34 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] syslog safe?
References: <20060425134048.D5934@domain.hid> <444E61F0.9000606@domain.hid>
	<20060425143711.E5934@domain.hid>
In-Reply-To: <20060425143711.E5934@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kent Borg <kentborg@domain.hid>
Cc: xenomai@xenomai.org

Kent Borg wrote:
> On Tue, Apr 25, 2006 at 07:52:48PM +0200, Philippe Gerum wrote:
> 
>>No problem using it, but it will trigger an automatic switch to 
>>secondary mode in order to issue the right Linux syscalls. The thread 
>>will switch back to primary automatically again as soon as a (usually 
>>blocking) Xenomai syscall is issued.
> 
> 
> And, looking at strace output, it appears that is a syslog() is too
> low a priority to be logged it doesn't make a system call and so will
> not drop us out of realtime.
> 
> 

Do not trust strace there, it heavily relies on other glibc services, 
like buffered I/O, which might issue syscalls under various conditions. 
For instance, internal mutex locking might cause a syscall to deal with 
any contended request, or malloc called indirectly might ask for 
extending the caller's data segment, and so on. Additionally, some 
syslog flags, like LOG_CONS, do cause file I/O.

-- 

Philippe.

