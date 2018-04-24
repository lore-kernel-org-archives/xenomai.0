References: <1524573484592.16072@kth.se>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8af8cde4-d58f-f96b-679d-bd3e07fd26f9@xenomai.org>
Date: Tue, 24 Apr 2018 18:46:14 +0200
MIME-Version: 1.0
In-Reply-To: <1524573484592.16072@kth.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Illegal instruction/bad syscall
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gustav Johansson <gusjohan@kth.se>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 04/24/2018 02:38 PM, Gustav Johansson wrote:
> Hi!
> 
> 
> I recently managed to run a cobalt core for raspberry pi 3, Im using ipipe #9 for arm,  kernel version 4.1.21, Xenomai 3.0.6.
> 
> 
> I managed to build the xenomai API but when I try every executable file, for example latency test bench,  I get "illegal instruction", and in dmesg I get "[Xenomai] bad syscall <0xff7000af> ...".
> 
> 
> The crosscompiler Im using is https://github.com/raspberrypi/tools/tree/master/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian and I have also tried compiling it on the RPI3 itself but Im getting the same error.
> 
> 
> I have compared my kernel config next to Harco Kuppens  working image (http://www.cs.ru.nl/lab/xenomai/) But the only difference is that I have higher values in XENO_OPT_SYS_HEAP, XENO_PRIVATE_HEAPS, XENO_OPT_SHARED_HEAPSZ, XENO_OPT_TIMERS.
> 
> 
> Im uploading a readme with the steps I have taken with the installation and also my kernel config.
> 
> 
> Any ideas on why I get "Illegal instruction"?
> 
> 

Maybe EABI vs OABI issue. Try disabling CONFIG_OABI_COMPAT, I suspect
that the code supporting the OABI in Xenomai has not been exercised
since ages.

-- 
Philippe.

