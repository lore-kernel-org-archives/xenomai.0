Message-ID: <49B0FE9A.9040809@domain.hid>
Date: Fri, 06 Mar 2009 11:44:42 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A0187305A@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A0187305A@ARVMAIL1.mra.roland-man.biz>
Content-Type: multipart/mixed; boundary="------------050900090307080304030202"
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
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org, wg@domain.hid

This is a multi-part message in MIME format.
--------------050900090307080304030202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

roderik.wildenburg@domain.hid wrote:
>> Gilles sent you a patch affecting 
>> include/asm-powerpc/bits/pod.h a few weeks
>> ago, that fixed an FPU issue. Are you running with this patch applied?
>>
> 
> Yes, with 2.3.5 and 2.4.6. Both show the same behavior.
> Obviously, in the meantime, Wolfgang could reproduce the problem!?
>

Unfortunately, I'm not able to reproduce this bug on my side, even using the 
latest linuxppc_devel tree. I have attached my test code to make sure we are 
testing the same thing. This test code does raise the FPU exception properly.

> Roderik
> 
> --------------------------------------------------------
> manroland AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Rall, Paul Steidle   
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht Offenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933
> 


--------------050900090307080304030202
Content-Type: text/x-csrc;
 name="divzero.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="divzero.c"

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

--------------050900090307080304030202--

