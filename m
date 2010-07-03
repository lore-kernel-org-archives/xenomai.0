Message-ID: <4C2F8F9B.30300@domain.hid>
Date: Sat, 03 Jul 2010 21:29:31 +0200
From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
MIME-Version: 1.0
References: <1278071353-13836-1-git-send-email-wolfgang.mauerer@domain.hid>
	<4C2F6BCA.2020300@domain.hid>
In-Reply-To: <4C2F6BCA.2020300@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 0/7] Host realtime clock support
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Wolfgang Mauerer wrote:
>> Some points that may require further discussion:
>>
>> - POSIX only specifies a few clock_ids, and these have already been
>>   extended by the Linux kernel. We use the maximum id (16) for the new
>>   clock, but it might also make sense to use 7 (CLOCK_MONOTONIC_COARSE+1)
>>   or 4 (CLOCK_THREAD_CPUTIME_ID+1).
> 
> Why are we limited to 16 clocks? I mean we do not go trough any
> kernel/glibc path, so it looks like we can use any number. Or did I miss
> something?
> 

To goal was to find a number that's least surprising and blends best
with the POSIX conventions and the existing numbers in Linux. Maximum
was referring to the definition in the Linux kernel, but I'm happy
to pick any larger number, including 23 and 42 ;-)

Regards, Wolfgang

