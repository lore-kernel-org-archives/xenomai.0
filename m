Message-ID: <5350F27E.4020002@mitrol.it>
Date: Fri, 18 Apr 2014 11:38:06 +0200
From: Paolo Minazzi <Paolo.Minazzi@mitrol.it>
MIME-Version: 1.0
References: <5347D5BB.1070107@mitrol.it> <5347D6E0.2030805@xenomai.org>
 <5347DCCC.3040801@mitrol.it> <5347DF09.9080905@xenomai.org>
 <5347E0E1.3020807@mitrol.it> <5347E3DA.6010106@xenomai.org>
 <5347E8AB.7020908@mitrol.it> <5347EB00.7060203@xenomai.org>
 <534FC6F3.1050305@mitrol.it> <534FD826.8030701@xenomai.org>
 <5350E6BE.9080104@mitrol.it> <5350E9C7.7010904@optusnet.com.au>
In-Reply-To: <5350E9C7.7010904@optusnet.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] arm imx6 and hardware FPU [SOLVED]
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Il 18/04/2014 11.00, Tom Evans ha scritto:
>> I'm sorry ... all works correctly, also with hardware floating point. It
>> was all my fault.
>> Paolo
>
> Please post the solution in case someone else has the same problem.
>
> Did you forget CONFIG_VFP in the kernel configuration, or is there 
> something different for i.MX6?
>
> The Kernel has to be told about the FPU so it can swap out all the FPU 
> registers during a context swap.
>
> We have a product with an FPU we configure without kernel support, and 
> then only compile ONE program with hardware FP as the FPU context 
> switch time would slow the device down otherwise.
>
> Tom Evans
>
>
The bug was is my test. All alarms was dummy.
In my first email to mailing list I wrote the important points of my 
configuration. Thay were correct.
There are no problem of reentrance of math function.
All compiled with a linaro toolchain hf (hardware floating).
Repeat, all was my buggy test.






