Date: Tue, 14 Apr 2009 11:29:37 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <49E48C89.1050806@domain.hid>
Message-ID: <Pine.LNX.4.64.0904141018390.7250@domain.hid>
References: <Pine.LNX.4.64.0904131821010.12546@domain.hid>
	<49E48C89.1050806@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-core] Fixing xeno-test
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


On Tue, 14 Apr 2009, Gilles Chanteperdrix wrote:
> I'd prefer to avoid adding this new program. xeno-test is already more
> complicated than I would like, and I am almost sure that we can handle
> differences between the shells by testing what shell we are running (for
> instance using the SHELL variable) and using some explicit "ifs" in the
> script.

Okay, although the external C program was meant to simplify the
xeno-test script. I'll have another look at doing this entirely in the
shell.

>> In case anybody wants to see the code first, you can find the program
>> source code and a simple makefile for compiling it, at:
>>
>>    http://www.astro.caltech.edu/~mcs/xenomai/xeno-stress.c
>
> I get a 404.

Sorry, I must have deleted the wrong file after accidentally placing
it in 2 places. FWIW, I've put it back now.

Martin

