Message-ID: <49958653.2010803@domain.hid>
Date: Fri, 13 Feb 2009 15:40:19 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4B2EEE69E41E524EB7FCDC62A15D68D80308F137@domain.hid>
In-Reply-To: <4B2EEE69E41E524EB7FCDC62A15D68D80308F137@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: thomas.debes@domain.hid
Cc: xenomai@xenomai.org

thomas.debes@domain.hid wrote:
> Hi,
> 
> I successfully managed to enable FP Exceptions on our MPC5200 board for
> plain linux applications (via fesetenv). When I put the same trigger
> code (DivByZero) into a (native) RT task no exception is triggered until
> I force a mode switch to secondary mode (e.g. printf). How can I get
> them without performing the mode switch?
> 

Could you check whether the following test does raise an exception on your
setup? TIA,

#include <sys/types.h>
#include <sys/mman.h>
#include <stdio.h>
#include <fenv.h>
#include <native/task.h>

double z;

int main (int argc, char **argv)
{
	double a = 23.0;

	z = 0;
	fesetenv(FE_ENABLED_ENV);

        mlockall(MCL_CURRENT | MCL_FUTURE);

	rt_task_shadow(NULL, "main", 10, 0);
	a /= z;
	rt_task_suspend(NULL);

	return (int)a;
}

> Thanks for your help!
> Thomas
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

