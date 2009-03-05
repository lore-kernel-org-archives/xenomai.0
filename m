Message-ID: <49AFCF81.8020806@domain.hid>
Date: Thu, 05 Mar 2009 14:11:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <67b6b3430903041631p107682bdyf5d5fb9c0e70d86d@domain.hid>
	<49AFA197.9090704@domain.hid>
In-Reply-To: <49AFA197.9090704@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ipipe error
Reply-To: gilles.chanteperdrix@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Mark Saiia wrote:
>> When running 2.6.27.19 w/ Xenomai 2.4.7 on a geode board, I get the
>> following in the log. I haven't done any debugging yet, but wanted to
>> see if anyone else has this issue.  It results in some of the
>> application threads not being responsive, while others are still
>> running.
>>
> 
> Is CONFIG_FRAME_POINTER enabled for your kernel, i.e. can we trust the backtrace
> below?

>From what I understood, in recent kernels, even when
CONFIG_FRAME_POINTER is enabled, the show_stack code prints what it
finds on the stack, but with a '?' before, to make the difference with
the frame pointers.

-- 
                                                 Gilles.

