Message-ID: <454901B6.80606@domain.hid>
Date: Wed, 01 Nov 2006 14:21:10 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Fwd: Re: [Xenomai-help] invalid use of FPU in Xenomai context]
References: <4548C170.1000504@domain.hid> <4548F8BE.90809@domain.hid>
In-Reply-To: <4548F8BE.90809@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jeff Webb wrote:
>> Does anyone else have an AMD system that can verify my results?
> 
> I have an old Athlon 800. Maybe we are lucky and it exposes the problem
> when the kernel is optimised for it. I'm going to give this a try, but
> it may take a few days (and a free time slot).

Thank you.  I appreciate you giving it a try when you get some free time.  I was able to work around the problem by writing the queue data in smaller chunks (or use an i686 kernel), so I am not in urgent need of an immediate fix.  I do think it's important to fix this bug eventually, so I didn't want it to slip through the cracks.

>> The problem seems to be connected with the size of writes to Xenomai
>> pipes.  This example uses POSIX message queues, but I had a similar
>> problem a while back with RTAI pipes.  Maybe this tells us the problem
>> is in the nucleus pipe code?  Just a guess.  The problem seems to affect
>> both 2.4 and 2.6 systems, and goes back to at least Xenomai 2.2.1.
> 
> Maybe, maybe not. Pipes remain fairly unrelated to FPU usage, so there
> is still /at least/ one piece missing in the puzzle.

True.  It is very strange that the amount of data in the write call ends up affecting the FPU context.

> BTW, did you already write what compiler version you are using for these
> tests (/me too lazy to search the archives)?

I forgot to include this.  I compiled with at least three versions of gcc:

Machine #1: FC5 : gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)
Machine #2: FC1 : gcc version 3.3.2 20031022 (Red Hat Linux 3.3.2-1)
            FC5 : gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)
Machine #3: debian : gcc version 3.3.6 (Debian 1:3.3.6-13)

Thanks again,

-Jeff

