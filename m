MIME-Version: 1.0
In-Reply-To: <CAKO1R-TUkrgYo1nwb86m_W8MMghq124EkPuL8Q+qQrGs9n1Z0A@mail.gmail.com>
References: <CAKO1R-ReR8XT8n6_UHWCV=vnk_Y38QkSiSjf0_HVg0=Eu70VNg@mail.gmail.com>
 <560FA3DF.1030204@xenomai.org>
 <CAKO1R-TUkrgYo1nwb86m_W8MMghq124EkPuL8Q+qQrGs9n1Z0A@mail.gmail.com>
Date: Sun, 4 Oct 2015 21:00:53 +0800
Message-ID: <CAKO1R-QpXjj580xoC3_bXn9buLxC+56ka+--w3FdmA71g9AM6A@mail.gmail.com>
From: =?UTF-8?B?5p6X5bGV57+U?= <chlin6016@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Cyclictest in Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Sorry I forgot to mention that the successfully-executed latency was ran on
kernel 3.18,
before switching to the 'next' branch.

I also ran latency and cyclictest on Xenomai2, with my current linux kernel
version.
The numbers seemed to be fine.
(Max value around 30 us for both program, in a short period of time)

Chan-Hsiang Lin


2015-10-04 20:43 GMT+08:00 =E6=9E=97=E5=B1=95=E7=BF=94 <chlin6016@gmail.com=
>:

> Thanks Philippe.
>
> I've switched to the 'next' branch and tried to run cyclictest on
> Beaglebone Black
> (Also ran latency, the numbers were OK.)
> The first time I ran cyclictest, there was a message saying that
> non-SMP libraries was running on SMP kernel
> But after recompiling xenomai with the '--enable-smp' option,
> when I executed cyclictest (and latency), there were no messages printed
> out (even errors)
>
> Could this be the problem of the compiling process on Xenomai or the Linu=
x
> kernel ?
> (My kernel version is 3.14.39)
>
>
> Chan-Hsiang Lin
>
>
> 2015-10-03 17:46 GMT+08:00 Philippe Gerum <rpm@xenomai.org>:
>
>> On 10/03/2015 11:35 AM, =E6=9E=97=E5=B1=95=E7=BF=94 wrote:
>> > Hello,
>> >
>> > I've cloned the code from Konstantinos's github page and amended the
>> > Makefile and cyclictest.c like Philippe had suggested.
>> >
>> > But when I ran cyclictest(after compilation) with the command
>> './cyclictest
>> > -p 99 -i 250 -n', the MAX latency was still over 200us.
>> >
>> > Can anyone tell me where the problem might be?
>>
>> A good way to check whether you actually fixed up the original code
>> properly with the earlier, out of tree cyclictest, is to run Xenomai's
>> latency test. Not seeing any latency issues with that one would give you
>> some hint about where the problem might be.
>>
>> --
>> Philippe.
>>
>
>
