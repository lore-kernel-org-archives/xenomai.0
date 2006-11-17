Message-ID: <455DCE75.1080300@domain.hid>
Date: Fri, 17 Nov 2006 16:00:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: Re: What happens if task entry function
	returns?
References: <455DC001.2040001@domain.hid>	<434646.1163765689576.JavaMail.ngmail@domain.hid>
	<16178634.1163773048304.JavaMail.ngmail@domain.hid>
In-Reply-To: <16178634.1163773048304.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

M. Koehrer wrote:
> Hi Jan, 
> 
> First, I give you some more information about the error.
> The output is the following:
> Hi, I am task A Hello
> Hi, I am task B World
> Main waits for A
> This is the end of A
> Main waits for B
> 
> Then the system hangs.

You mean completely? Or just that application? Please enable the Xenomai
watchdog to see if we have a run-away RT thread in that case.

> 
> I have done two tests to verify if there is an SMP issue.
> First, I have set all CPUs in use with the application to CPU 0.
> There was no change. However, I am able to stop the application with CTRL-C
> and everything is cleaned up fine.
> 
> Then, I have modified the BIOS settings of the PC to disable Hyperthreading.

[Which is recommended anyway to keep latencies bounded - HT is evil for RT!]

> Again, no change. The same effect as with the test before.
> 
> The strange thing here is, when I use the original test (main on CPU 0, rt tasks on CPU 1)
> on a SMP machine, I am not able to terminate the application with CTRL-C.
> I have to reboot the PC.
> 
> That means, there seems to be a relation to SMP...

Probably in so far that the symptom changes. But !SMP doesn't make it go
away.

> 
> Another thing I have detected:
> When I modify the program to replace the final rt_task_delete by
> a sleep(1) call everything runs perfectly again.

Ok, could you try on a non-hanging setup to grab what is happening via
strace?

Thanks,
Jan

