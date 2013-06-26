MIME-Version: 1.0
In-Reply-To: <51CB21EC.6080600@xenomai.org>
References: <011001ce6f6b$44fb8080$cef28180$@z9.com>
	<51C800C7.3040707@siemens.com> <51CB21EC.6080600@xenomai.org>
Date: Wed, 26 Jun 2013 15:36:58 -0300
Message-ID: <CAFNBftcETRGod7mmi8n+mmf_cYgt6DHKRLA3nw1QrhuCv6af_g@mail.gmail.com>
From: Flavio Castro Alves Filho <flavio.alves@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Xenomai on 3.8.13
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, George Pontis <gpontis@z9.com>, xenomai@xenomai.org

2013/6/26 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> On 06/24/2013 10:18 AM, Jan Kiszka wrote:
>
>> On 2013-06-22 19:09, George Pontis wrote:
>>> 2013/6/11 Jan Kiszka <jan.kiszka@siemens.com>:
>>>> Hi all,
>>>>
>>>> I've merged 3.8.13 into our stable 3.8 branch. This triggered some
>>>> minor conflicts in generic and ARM code. Please see
>>>>
>>>> git://git.xenomai.org/ipipe-jki for-upstream/3.8
>>>>
>>>> for details. The result works fine for x86, and if it's also OK for
>>>> the other arch, I'd propose this to be merged into the official 3.8
>>>> stable branch.
>>>>
>>>> Jan
>>>>
>>>
>>> Would this be used with Xenomai 2.6 current git ?
>>
>> Yes, you need Xenomai 2.6 to be able to build for 3.x kernels. The last
>> release 2.6.2.1 is fine.
>
>
> At least on ARM, you need xenomai 2.6 git, not xenomai 2.6.2.1.

It works in both cases, at least for BeagleBone Black.

Best regards,

Flavio

>
>
> --
>                                                                 Gilles.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai



--
Flavio de Castro Alves Filho

flavio.alves@gmail.com
www.linuxembarcado.com
Twitter: http://twitter.com/#!/fraviofii
LinkedIn profile: www.linkedin.com/in/flaviocastroalves

