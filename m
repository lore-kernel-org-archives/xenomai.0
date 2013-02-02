Message-ID: <510D4A71.7030309@xenomai.org>
Date: Sat, 02 Feb 2013 18:18:41 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51090B3D.6030909@siemens.com>
In-Reply-To: <51090B3D.6030909@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] x86-64 FPU saving/restoring
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 01/30/2013 12:59 PM, Jan Kiszka wrote:
> Hi,
>
> can someone explain to me why we have to worry that fxsave64 or
> fxrstor64 can fault on x86-64 (and i386's fxsave/fxrstor not)? And why
> we ignore such faults then? git doesn't explain why that change was once
> done. To my understanding, the target/source memory for the save/restore
> is not located in user space. The kernel seems to carefully save/restore
> only when pushing to/pulling from user space, e.g. during signal
> handling or on ptrace.

 From the archaeological dept: I suspect this was only a matter of 
quickly deriving a Xenomai version of the existing kernel helpers, in 
order to work on Xenomai's fpuenv areas from our TCBs.

I don't think relying on the fault fixup code dragged in this way was 
intended. We could not afford any fault there anyway, since we might 
then try to relax a thread in the middle of a Xenomai switch, so...

-- 
Philippe.

