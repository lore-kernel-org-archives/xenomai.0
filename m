Message-ID: <53DBA8D7.9040505@xenomai.org>
Date: Fri, 01 Aug 2014 10:48:55 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <mailman.653.1404749254.5713.xenomai@xenomai.org>	<53C3E6CE.2040306@xenomai.org>	<53C42ADE.7040204@gmail.com>	<53C44696.2070906@xenomai.org>	<53C44EE9.3040000@xenomai.org>	<53C6CC9B.4040009@xenomai.org>	<53C81CFD.30908@gmail.com>	<53C82A08.50100@xenomai.org>	<CACKc53LL5C2AUTjd6cah1JyoDD5BMGeg5RQjsDjX9_FNvqdAJQ@mail.gmail.com>	<53DAA390.7040406@xenomai.org>
 <CACKc53LQ5pCL14tVodDbMjyexPoYcaLi-PFzFOGT=VNGhR6FpQ@mail.gmail.com>
In-Reply-To: <CACKc53LQ5pCL14tVodDbMjyexPoYcaLi-PFzFOGT=VNGhR6FpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] sensoray 626 patch [Re: Xenomai Digest, Vol 27,
	Issue 12]
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wojciech Domski <wojciech.domski@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/01/2014 07:33 AM, Wojciech Domski wrote:
> Dear Jorge,
>
> In attachment you can find the dump file. I created it with strace. I hope
> this is what you meant.

I actually meant the kernel traces.
Please when compiling the analogy drivers if you could set the analogy driver and 
core debug level thresolds to 10 that would be all.
Then attach the output of $dmesg to your email.


>
> Also I forgot to tell one more thing. When I try to relink s1 to a0 I get
> this message from the driver:
> S626 0000:02:05.0: BAR 0: can't reserve [mem 0xf7b00000-0xf7b001ff]

maybe you didnt release the device properly. Please could you send the code as well?


> This is the result of pci_request_regions() function in attach.
>
> Here is also the sample application which I have written to test it.
>
> ts626 * s626;
>    ts626 * s626_2;
>
>    printf("Opening a0 with s0\n");
>    s626 = s626_init("S626", "analogy0");
>      s626_set_options(s626);
>       s626_set_bus(s626, 2);
>       s626_set_slot(s626, 4);
>       s626_open(s626);
>
>       printf("Opening a1 with s1\n");
>    s626_2 = s626_init("S626", "analogy1");
>      s626_set_options(s626_2);
>       s626_set_bus(s626_2, 2);
>       s626_set_slot(s626_2, 5);
>       s626_open(s626_2);
>
>       printf("Closing a0 with s0\n");
>      s626_close( s626);
>      s626_deinit( s626);
>      s626 = NULL;
>
>      printf("Closing a1 with s1\n");
>      s626_close( s626_2);
>      s626_deinit( s626_2);
>      s626_2 = NULL;
>
>    printf("Opening a0 with s1\n");
>    s626 = s626_init("S626", "analogy0");
>      s626_set_options(s626);
>       s626_set_bus(s626, 2);
>       s626_set_slot(s626, 5);
>       s626_open(s626);
>
>      printf("Closing a0 with s1\n");
>      s626_close( s626);
>      s626_deinit( s626);
>      s626 = NULL;
>
> Best regards,
> Wojciech Domski
>
>
> 2014-07-31 22:14 GMT+02:00 Jorge Ramirez Ortiz <jro@xenomai.org>:
>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 07/31/2014 05:22 AM, Wojciech Domski wrote:
>>   I prepared the driver to work well with multiple Sensoray 626 and I tested
>>   it with two of those. I have a problem, however.
>>   I suspect that the analogy interface doesn't play along with the driver
>> but
>>   I'm not certain about that. Here what's happening.
>>   I have two s626 cards: s0 and s1. For the sake of conversation let's
>> assume
>>   that analogy device analogy0 is a0 and so on.
>>   When I link s0 to a0, unlink, link s1 to a1, unlink everything works fine,
>>   however. Once more when I link s0 but this time to a1 something goes
>> wrong.
>>   I get -16 error from a4l_sys_attach() which is
>>
>>   No such device
>>
>>   What is the reason of this happening? I do clean everything every time
>> when
>>   I release s626.
>>   Here is what I do when I want to open my device:
>>
>>   a4l_sys_open();
>>   a4l_sys_attach();
>>   a4l_open();
>>   rt_dev_open();
>>   a4l_fill_desc();
>>
>>   When I close the s626 I do:
>>
>>   rt_dev_close();
>>   a4l_close();
>>   a4l_sys_detach();
>>   a4l_sys_close();
>>
>>   Best regards,
>>   Wojciech Domski
>>
>> - ------------------
>>
>> please could you send the driver and the kernel traces for the experiment?
>>
>>
>> - --
>> jro
>>
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.4.11 (GNU/Linux)
>> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>>
>> iQEcBAEBAgAGBQJT2qOQAAoJECDcy2IJkagRnH0H/3j3VgCu8KSUfOBYzC7McFxg
>> my+hW6i+FFNn3kpJJ2/EQtmg/pFGdenIwd/Uu8XJhwaLfT0mtP67b8GDuD/BsPGp
>> lVyuFeznew6gN+usGnQe48sEUCnpadlwI/ZIjcZhJqmcVzwUw991RvA32l6Z9x3/
>> biYv9N0QiaEpp3c0rWAApnHetsun7rFxGuzgAq2pB+adeWCOSTtOpYEado7qOrEx
>> FyBj8Gh1sc7kMLnyml/UXgLBvxsaSUXq81t1QwaOOZS4TQLtg/HstHMlTvqrS6k2
>> WsbhmS5qqmKBIKeEjWUl6d5S3TKfW+XjaY3JVFlN8p6EPS3LUl5SkxqzH/Zavfw=
>> =+hI6
>> -----END PGP SIGNATURE-----
>>
>

-- 
jro

