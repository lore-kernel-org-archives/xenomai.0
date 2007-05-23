Message-ID: <4654453D.1060504@domain.hid>
Date: Wed, 23 May 2007 15:44:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <46543091.3040308@domain.hid> <465434B9.6010805@domain.hid>
	<46543535.5090106@domain.hid> <46543C86.3040006@domain.hid>
	<46544280.9020904@domain.hid>
In-Reply-To: <46544280.9020904@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] loading module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodolfo <rolfetas@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Rodolfo wrote:
> Gilles Chanteperdrix wrote:
> 
>>Why do you want to use Xenomai in kernel-space ? Since, as you said it,
>>you are a beginner, you should use Xenomai in user-space. There, gdb
>>will help you debug your segmentation faults.
> 
> I actually want to compare latencies between User-Space RT Tasks and
> Kernel RT Tasks.
> 

I would advise starting in user-space, adapting from user-space to
kernel-space will then be straightforward.

If you want to compare latencies between user-space and kernel-space,
you may have a look at the "latency" test. latency -t 0 outputs the
user-space latency, latency -t 1 outputs the kernel-space latency.

-- 
                                                 Gilles Chanteperdrix

