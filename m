Message-ID: <4BED7D5B.6050605@domain.hid>
Date: Fri, 14 May 2010 18:42:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D72A@alpine.pivotalsys.com>
In-Reply-To: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D72A@alpine.pivotalsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_mutex created prior to main causes board to
 freeze?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sherk Chung <sherk.chung@domain.hid>
Cc: xenomai@xenomai.org

Sherk Chung wrote:
> We are using Xenomai on an AT91 ARM board.  We wrote a program that
> creates multiple Xenomai tasks, which use rt_mutexes to when accessing
> some shared global variables.  The rt_mutexes used are declared
> globally, as in the example below.  Since the objects sharedVar1,
> shredVar2, etc. are declared on the global stack, the rt_mutexes are
> created prior to main() getting executed.  The problem we are having is
> that our program is causing our HW to freeze up on program load, it
> never gets to the first line of main(), and our HW supplier pointed out
> that we must call mlockall() and the set up the signal handlers before
> creating the mutexes.
> 
>  
> 
> Is there a problem with creating rt_mutexes the way we are doing, and
> should that cause the ARM board to freeze?  (the same program loads fine
> on an x86)

No, there should not be any problem. Creating a mutex does not require a
particular context, only locking it does.

Which version of Xenomai do you sue, with which version of the I-pipe patch?

-- 
					    Gilles.

