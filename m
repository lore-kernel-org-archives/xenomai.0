Message-ID: <49DE8502.7070408@domain.hid>
Date: Fri, 10 Apr 2009 01:30:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <17B3FD74-07D0-4F36-9836-8E03943DF917@domain.hid>		<49D1EA0B.2020300@domain.hid>		<67b6b3430904081529n36226987r3708908b974d8d1a@domain.hid>		<49DDBF4D.1060708@domain.hid>	<67b6b3430904091623r21864506l1158002c713a36ea@domain.hid>
	<49DE8478.9040301@domain.hid>
In-Reply-To: <49DE8478.9040301@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] geode gx1 latencies
Reply-To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Mark Saiia <mark.saiia@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Mark Saiia wrote:
>> Attached is a tracelog.  It was obtained with 2.6.27.19, with Xenomai
>> 2.4 maintenance branch, and Gilles' patch.  In order to get the
>> application to run without overruns, I had to disable instrument
>> function entries in the kernel config.  It is impossible to run
>> latency at the same time as the application with the ipipe tracer
>> enabled(probably due to resource scarcity?) as the system locks up, so
>> I was unable to do as Gilles suggested/requested (running latency -f
>> during the applications execution).
> 
> What I meant is you to run the latency test alone, with some non
> real-time load. And to obtain useful traces, we need the "instrument
> function entries in the kernel config". You can increase the latency
> period to decrease the log.

to decrease the load, I mean.

-- 
					    Gilles.

