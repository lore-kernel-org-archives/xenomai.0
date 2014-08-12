Message-ID: <53E96D0E.7060505@xenomai.org>
Date: Mon, 11 Aug 2014 21:25:34 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <mailman.653.1404749254.5713.xenomai@xenomai.org>	<53C3E6CE.2040306@xenomai.org>	<53C42ADE.7040204@gmail.com>	<53C44696.2070906@xenomai.org>	<53C44EE9.3040000@xenomai.org>	<53C6CC9B.4040009@xenomai.org>	<53C81CFD.30908@gmail.com>	<53C82A08.50100@xenomai.org>	<CACKc53LL5C2AUTjd6cah1JyoDD5BMGeg5RQjsDjX9_FNvqdAJQ@mail.gmail.com>	<53DAA390.7040406@xenomai.org>	<CACKc53LQ5pCL14tVodDbMjyexPoYcaLi-PFzFOGT=VNGhR6FpQ@mail.gmail.com>	<53DBA8D7.9040505@xenomai.org>	<CACKc53+jJ9tq-5oHN65V5o-tTU5L67ZiwKQ5eyFW0C=4HRyYqA@mail.gmail.com>
 <CACKc53KpB1=-HciLvY-E_u4FDO72LGBSwtSV19G_h5_iT8e-LQ@mail.gmail.com>
In-Reply-To: <CACKc53KpB1=-HciLvY-E_u4FDO72LGBSwtSV19G_h5_iT8e-LQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/05/2014 06:01 AM, Wojciech Domski wrote:
> Ok, there was a problem with closing the descriptor on the side of API (new
> file in attachment). I have resolved it but now I have problem with IRQ.
> Here is what dmesg says:
> 
> [  103.942431] Analogy: a4l_add_drv: name=S626
> [  103.942434] Analogy: a4l_lct_drv: name=S626
> [  103.942450] Analogy: Probing for s626
> [  103.942469] Analogy: Probing for s626
> [  115.764941] Analogy: a4l_lct_drv: name=S626
> [  115.764945] Analogy: S626: Attaching s626
> [  115.764947] Analogy: S626: Desired Bus: 2, Slot: 4
> [  115.764949] Analogy: S626: Has Bus: 2, Slot: 4
> [  115.764951] Analogy: S626: PCI dev = ffff880211c72000
> [  115.764952] Analogy: S626: PCI set master
> [  115.764960] Analogy: S626: PCI region request
> [  115.764964] Analogy: S626: PCI ioremap
> [  115.764997] Analogy: S626: disable master interrupt
> [  115.764998] Analogy: S626: DMA
> [  115.765004] Analogy: S626: RTDM irq
> [  115.765016] Analogy: S626: RTDM irq request
> [  115.765027] Analogy: S626: subdevices allocation
> [  115.765031] Analogy: S626: card initialization
> [  115.780513] Analogy: S626: Driver ready
> [  115.780516] Analogy: a4l_setup_transfer: nb_subd=6
> [  119.620570] Analogy: a4l_lct_drv: name=S626
> [  119.620575] Analogy: S626: Attaching s626
> [  119.620579] Analogy: S626: Desired Bus: 2, Slot: 5
> [  119.620581] Analogy: S626: Has Bus: 2, Slot: 5
> [  119.620583] Analogy: S626: PCI dev = ffff880211c73000
> [  119.620584] Analogy: S626: PCI set master
> [  119.620592] Analogy: S626: PCI region request
> [  119.620596] Analogy: S626: PCI ioremap
> [  119.620630] Analogy: S626: disable master interrupt
> [  119.620632] Analogy: S626: DMA
> [  119.620635] Analogy: S626: RTDM irq
> [  119.620644] Analogy: S626: RTDM irq request
> [  119.620655] Analogy: S626: subdevices allocation
> [  119.620659] Analogy: S626: card initialization
> [  119.636135] Analogy: S626: Driver ready
> [  119.636139] Analogy: a4l_setup_transfer: nb_subd=6
> [  121.908284] Analogy: a4l_precleanup_transfer: subd[0]->status=0x00000000
> [  121.908287] Analogy: a4l_precleanup_transfer: subd[1]->status=0x00000000
> [  121.908289] Analogy: a4l_precleanup_transfer: subd[2]->status=0x00000000
> [  121.908290] Analogy: a4l_precleanup_transfer: subd[3]->status=0x00000000
> [  121.908291] Analogy: a4l_precleanup_transfer: subd[4]->status=0x00000000
> [  121.908293] Analogy: a4l_precleanup_transfer: subd[5]->status=0x00000000
> [  121.908298] Analogy: S626: Detaching s626
> [  121.908300] Analogy: S626: Cleaning private
> [  121.908322] Analogy: S626: Handling irq
> [  122.111663] Analogy: S626: Releasing PCI regions
> [  122.111670] Analogy: S626: Removing private
> [  122.111671] Analogy: S626: Detaching completed
> [  124.081687] Analogy: a4l_precleanup_transfer: subd[0]->status=0x00000000
> [  124.081691] Analogy: a4l_precleanup_transfer: subd[1]->status=0x00000000
> [  124.081692] Analogy: a4l_precleanup_transfer: subd[2]->status=0x00000000
> [  124.081694] Analogy: a4l_precleanup_transfer: subd[3]->status=0x00000000
> [  124.081695] Analogy: a4l_precleanup_transfer: subd[4]->status=0x00000000
> [  124.081696] Analogy: a4l_precleanup_transfer: subd[5]->status=0x00000000
> [  124.081702] Analogy: S626: Detaching s626
> [  124.081704] Analogy: S626: Cleaning private
> [  124.081726] Analogy: S626: Handling irq
> [  124.283848] Analogy: S626: Releasing PCI regions
> [  124.283855] Analogy: S626: Removing private
> [  124.283856] Analogy: S626: Detaching completed
> [  127.376882] Analogy: a4l_lct_drv: name=S626
> [  127.376887] Analogy: S626: Attaching s626
> [  127.376888] Analogy: S626: Desired Bus: 2, Slot: 5
> [  127.376890] Analogy: S626: Has Bus: 2, Slot: 5
> [  127.376893] Analogy: S626: PCI dev = ffff880211c73000
> [  127.376894] Analogy: S626: PCI set master
> [  127.376901] Analogy: S626: PCI region request
> [  127.376905] Analogy: S626: PCI ioremap
> [  127.376961] Analogy: S626: disable master interrupt
> [  127.376962] Analogy: S626: DMA
> [  127.376968] Analogy: S626: RTDM irq
> [  127.376983] Analogy: S626: RTDM irq request
> [  127.376992] Analogy: a4l_assign_driver: call(drv->attach) failed


the IRQ line is already in use as per the return code (EBUSY).
it could be that the previous call to rtdm_irq_free failed.

could you try again after applying this patch please ?

http://git.xenomai.org/xenomai-jro.git/commit/?h=for-forge&id=44e4db095fb690705e311aaee378d66e84a381db






> (ret=-16)
> [  127.376994] Analogy: a4l_request_irq: IRQ registration failed
> 
> 
> 
> 2014-08-05 11:20 GMT+02:00 Wojciech Domski <wojciech.domski@gmail.com>:
> 
>> I did recompile xeno_analogy kernel module with thresholds both set to 10
>> so now everything should be ok.
>> Here is the dmesg output:
>>
>> [  110.899150] Analogy: a4l_add_drv: name=S626
>> [  110.899154] Analogy: a4l_lct_drv: name=S626
>> [  110.899168] Analogy: Probing for s626
>> [  110.899185] Analogy: Probing for s626
>> [  119.703343] Analogy: a4l_lct_drv: name=S626
>> [  119.703347] Analogy: S626: Attaching s626
>> [  119.703349] Analogy: S626: Desired Bus: 2, Slot: 4
>> [  119.703351] Analogy: S626: Has Bus: 2, Slot: 4
>> [  119.703353] Analogy: S626: PCI dev = ffff880211c72000
>> [  119.703354] Analogy: S626: PCI set master
>> [  119.703361] Analogy: S626: PCI region request
>> [  119.703366] Analogy: S626: PCI ioremap
>> [  119.703398] Analogy: S626: disable master interrupt
>> [  119.703400] Analogy: S626: DMA
>> [  119.703405] Analogy: S626: RTDM irq
>> [  119.703417] Analogy: S626: RTDM irq request
>> [  119.703428] Analogy: S626: subdevices allocation
>> [  119.703432] Analogy: S626: card initialization
>> [  119.718902] Analogy: S626: Driver ready
>> [  119.718905] Analogy: a4l_setup_transfer: nb_subd=6
>> [  119.719039] Analogy: a4l_lct_drv: name=S626
>> [  119.719041] Analogy: S626: Attaching s626
>> [  119.719042] Analogy: S626: Desired Bus: 2, Slot: 5
>> [  119.719044] Analogy: S626: Has Bus: 2, Slot: 5
>> [  119.719045] Analogy: S626: PCI dev = ffff880211c73000
>> [  119.719046] Analogy: S626: PCI set master
>> [  119.719053] Analogy: S626: PCI region request
>> [  119.719055] Analogy: S626: PCI ioremap
>> [  119.719067] Analogy: S626: disable master interrupt
>> [  119.719068] Analogy: S626: DMA
>> [  119.719071] Analogy: S626: RTDM irq
>> [  119.719080] Analogy: S626: RTDM irq request
>> [  119.719087] Analogy: S626: subdevices allocation
>> [  119.719090] Analogy: S626: card initialization
>> [  119.734596] Analogy: S626: Driver ready
>> [  119.734598] Analogy: a4l_setup_transfer: nb_subd=6
>> [  119.734735] Analogy: a4l_precleanup_transfer: subd[0]->status=0x00000000
>> [  119.734736] Analogy: a4l_precleanup_transfer: subd[1]->status=0x00000000
>> [  119.734738] Analogy: a4l_precleanup_transfer: subd[2]->status=0x00000000
>> [  119.734739] Analogy: a4l_precleanup_transfer: subd[3]->status=0x00000000
>> [  119.734740] Analogy: a4l_precleanup_transfer: subd[4]->status=0x00000000
>> [  119.734742] Analogy: a4l_precleanup_transfer: subd[5]->status=0x00000000
>> [  119.734745] Analogy: S626: Detaching s626
>> [  119.734747] Analogy: S626: Cleaning private
>> [  119.734767] Analogy: S626: Handling irq
>> [  119.938140] Analogy: S626: Releasing PCI regions
>> [  119.938147] Analogy: S626: Removing private
>> [  119.938149] Analogy: S626: Detaching completed
>> [  119.938276] Analogy: a4l_lct_drv: name=S626
>> [  119.938278] Analogy: S626: Attaching s626
>> [  119.938280] Analogy: S626: Desired Bus: 2, Slot: 5
>> [  119.938282] Analogy: S626: Has Bus: 2, Slot: 5
>> [  119.938283] Analogy: S626: PCI dev = ffff880211c73000
>> [  119.938285] Analogy: S626: PCI set master
>> [  119.938292] Analogy: S626: PCI region request
>> [  119.938298] S626 0000:02:05.0: BAR 0: can't reserve [mem
>> 0xf7b00000-0xf7b001ff]
>> [  119.938299] Analogy: Can't request regions
>> [  119.938301] Analogy: a4l_assign_driver: call(drv->attach) failed
>> (ret=-12)
>> [  120.142476] Xenomai: RTDM: closing file descriptor 3.
>>
>> Also in the attachment is the patch for the xenomai 2.6.3 for support of
>> multiple s626 cards. Also I have attached the simple testing program
>> (app.c) and API which I've written to make the interaction with s626 easier.
>>
>> Please let me know if you come up with something.
>>
>>
>> 2014-08-01 16:48 GMT+02:00 Jorge Ramirez Ortiz <jro@xenomai.org>:
>>
>> On 08/01/2014 07:33 AM, Wojciech Domski wrote:
>>>
>>>> Dear Jorge,
>>>>
>>>> In attachment you can find the dump file. I created it with strace. I
>>>> hope
>>>> this is what you meant.
>>>>
>>>
>>> I actually meant the kernel traces.
>>> Please when compiling the analogy drivers if you could set the analogy
>>> driver and core debug level thresolds to 10 that would be all.
>>> Then attach the output of $dmesg to your email.
>>>
>>>
>>>
>>>
>>>> Also I forgot to tell one more thing. When I try to relink s1 to a0 I get
>>>> this message from the driver:
>>>> S626 0000:02:05.0: BAR 0: can't reserve [mem 0xf7b00000-0xf7b001ff]
>>>>
>>>
>>> maybe you didnt release the device properly. Please could you send the
>>> code as well?
>>>
>>>
>>>
>>>  This is the result of pci_request_regions() function in attach.
>>>>
>>>> Here is also the sample application which I have written to test it.
>>>>
>>>> ts626 * s626;
>>>>    ts626 * s626_2;
>>>>
>>>>    printf("Opening a0 with s0\n");
>>>>    s626 = s626_init("S626", "analogy0");
>>>>      s626_set_options(s626);
>>>>       s626_set_bus(s626, 2);
>>>>       s626_set_slot(s626, 4);
>>>>       s626_open(s626);
>>>>
>>>>       printf("Opening a1 with s1\n");
>>>>    s626_2 = s626_init("S626", "analogy1");
>>>>      s626_set_options(s626_2);
>>>>       s626_set_bus(s626_2, 2);
>>>>       s626_set_slot(s626_2, 5);
>>>>       s626_open(s626_2);
>>>>
>>>>       printf("Closing a0 with s0\n");
>>>>      s626_close( s626);
>>>>      s626_deinit( s626);
>>>>      s626 = NULL;
>>>>
>>>>      printf("Closing a1 with s1\n");
>>>>      s626_close( s626_2);
>>>>      s626_deinit( s626_2);
>>>>      s626_2 = NULL;
>>>>
>>>>    printf("Opening a0 with s1\n");
>>>>    s626 = s626_init("S626", "analogy0");
>>>>      s626_set_options(s626);
>>>>       s626_set_bus(s626, 2);
>>>>       s626_set_slot(s626, 5);
>>>>       s626_open(s626);
>>>>
>>>>      printf("Closing a0 with s1\n");
>>>>      s626_close( s626);
>>>>      s626_deinit( s626);
>>>>      s626 = NULL;
>>>>
>>>> Best regards,
>>>> Wojciech Domski
>>>>
>>>>
>>>> 2014-07-31 22:14 GMT+02:00 Jorge Ramirez Ortiz <jro@xenomai.org>:
>>>>
>>>>  -----BEGIN PGP SIGNED MESSAGE-----
>>>>> Hash: SHA1
>>>>>
>>>>> On 07/31/2014 05:22 AM, Wojciech Domski wrote:
>>>>>   I prepared the driver to work well with multiple Sensoray 626 and I
>>>>> tested
>>>>>   it with two of those. I have a problem, however.
>>>>>   I suspect that the analogy interface doesn't play along with the
>>>>> driver
>>>>> but
>>>>>   I'm not certain about that. Here what's happening.
>>>>>   I have two s626 cards: s0 and s1. For the sake of conversation let's
>>>>> assume
>>>>>   that analogy device analogy0 is a0 and so on.
>>>>>   When I link s0 to a0, unlink, link s1 to a1, unlink everything works
>>>>> fine,
>>>>>   however. Once more when I link s0 but this time to a1 something goes
>>>>> wrong.
>>>>>   I get -16 error from a4l_sys_attach() which is
>>>>>
>>>>>   No such device
>>>>>
>>>>>   What is the reason of this happening? I do clean everything every time
>>>>> when
>>>>>   I release s626.
>>>>>   Here is what I do when I want to open my device:
>>>>>
>>>>>   a4l_sys_open();
>>>>>   a4l_sys_attach();
>>>>>   a4l_open();
>>>>>   rt_dev_open();
>>>>>   a4l_fill_desc();
>>>>>
>>>>>   When I close the s626 I do:
>>>>>
>>>>>   rt_dev_close();
>>>>>   a4l_close();
>>>>>   a4l_sys_detach();
>>>>>   a4l_sys_close();
>>>>>
>>>>>   Best regards,
>>>>>   Wojciech Domski
>>>>>
>>>>> - ------------------
>>>>>
>>>>> please could you send the driver and the kernel traces for the
>>>>> experiment?
>>>>>
>>>>>
>>>>> - --
>>>>> jro
>>>>>
>>>>> -----BEGIN PGP SIGNATURE-----
>>>>> Version: GnuPG v1.4.11 (GNU/Linux)
>>>>> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>>>>>
>>>>> iQEcBAEBAgAGBQJT2qOQAAoJECDcy2IJkagRnH0H/3j3VgCu8KSUfOBYzC7McFxg
>>>>> my+hW6i+FFNn3kpJJ2/EQtmg/pFGdenIwd/Uu8XJhwaLfT0mtP67b8GDuD/BsPGp
>>>>> lVyuFeznew6gN+usGnQe48sEUCnpadlwI/ZIjcZhJqmcVzwUw991RvA32l6Z9x3/
>>>>> biYv9N0QiaEpp3c0rWAApnHetsun7rFxGuzgAq2pB+adeWCOSTtOpYEado7qOrEx
>>>>> FyBj8Gh1sc7kMLnyml/UXgLBvxsaSUXq81t1QwaOOZS4TQLtg/HstHMlTvqrS6k2
>>>>> WsbhmS5qqmKBIKeEjWUl6d5S3TKfW+XjaY3JVFlN8p6EPS3LUl5SkxqzH/Zavfw=
>>>>> =+hI6
>>>>> -----END PGP SIGNATURE-----
>>>>>
>>>>>
>>>>
>>> --
>>> jro
>>>
>>
>>
> 

- -- 
jro
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJT6W0OAAoJECDcy2IJkagRB4cIAI/LPyA+87ximC4HXoNvr23N
3bUXuTPKP6rPnprNLqzWQnZHaXVZLavXb7QX81DT/biUVw6ObH8/AJ3bRcoYJoa0
4x4FCwh77mLlwgPSi6vipgduEoZ4Sq+f7bidYbw7UWZjicKdtFc+6nPqJJE2+5iE
1VR8yPvZKOg9cQduF0UTHuoAdXrHRCP25vSw1o8HrN37nnyVN2BUVwR2YI78s2Ga
09b+5O8tzEIiXQOuK1jVBhSiHWnnvBaaYseDPihcrec3OJlsAG+pirSXsv+TqW6d
B+N+ehU/ropvWUAwxnOXYKpRsPj32XjwEYRn4sJh79sFYzejD4OED6ZovP0pckA=
=XU3a
-----END PGP SIGNATURE-----

