Message-ID: <4F574E11.7050209@domain.hid>
Date: Wed, 07 Mar 2012 13:01:21 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <59395C11A1D1C44ABE7AD0566C50F68BCC15A49EDD@mary.at.omicron.at>
In-Reply-To: <59395C11A1D1C44ABE7AD0566C50F68BCC15A49EDD@mary.at.omicron.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Cast a double value fails
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bertram Stemer <bertram.stemer@domain.hid>
Cc: "'xenomai@xenomai.org'" <xenomai@xenomai.org>

On 03/07/2012 12:46 PM, Bertram Stemer wrote:
> Hi,
> I'm using Xenomai 2.5.6 with Linux 2.6.36 on a PowerPC and
> have written a real-time application that runs on an isolated
> CPU (Kernel option isolcpus). When I start this application on
> another core, where a plain Linux application runs I get
> sporadically unexpected results in the non real-time application,
> when casting a double to an integer?!
>
> To reproduce this behavior I have a small non real-time test
> application that runs in parallel to the RT application:
> ...
> while (1) {
> 	int z = 4.0;
> 	if (z != 4)
> 		printf("cast error detected!");
> 	/* sleep some microseconds */
> }
> ...
>
> Does anyone know how this can happen? Is there a CPU utilization
> bound for real-time applications that run on the same CPU with
> plain Linux tasks?

isolcpus does not actually fully isolates CPU from non-rt activity. What 
you see is likely a bug in the Xenomai core, leaking fpu context bits 
spuriously between -rt and non-rt. Adding this to the todo list.

>
> Thanks in advance,
> Bertram
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>


-- 
Philippe.

