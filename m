Message-ID: <442A8086.1070302@domain.hid>
Date: Wed, 29 Mar 2006 14:41:42 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Non-deterministic behaviour in primary mode
References: <1143612388.32703.257789950@domain.hid>
In-Reply-To: <1143612388.32703.257789950@domain.hid>
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
To: Saul <xeno@domain.hid>
Cc: xenomai@xenomai.org

Saul wrote:
> Hi,
> 
> I'm trying to run a short test program, just to get into the swing
> of this shiny new real-time system. I'm running Xenomai 2.1.0 on
> kernel 2.6.15.6
> 
> The following program runs a busy delay in primary mode (verified by
> enabling the primary mode switch warning) and calculates the time taken.
> Another task is resumed and prints the time.
> 
> I get output something like this:
>   1:  40.017 ms
>   2:  40.017 ms
>   3:  53.357 ms
>   4:  53.356 ms
>   5:  40.017 ms
>   6:  40.020 ms
>   7:  53.355 ms
>   8:  40.020 ms
>   9:  40.017 ms
>  10:  53.356 ms
>  11:  40.020 ms
>  12:  40.019 ms
>  13:  106.710 ms
>  14:  40.017 ms
>  15:  40.018 ms ...
> 

Oh, and yes, make sure to try once disabling the entire ACPI support, so 
that we know that we don't get fooled by cpufreq, pm and friends. If you 
want to use HT, and the ACPI is really needed to enumerate the logical 
CPUs, then try only activating the minimal support allowing this by 
passing acpi=ht.

Trying the suggestions from TROUBLESHOOTING file may help too.

-- 

Philippe.

