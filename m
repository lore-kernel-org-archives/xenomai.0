MIME-Version: 1.0
In-Reply-To: <50793CB6.3070708@xenomai.org>
References: <CAFNBftf5EYFoSPK3VA4NWA5-eCQVvpOt_uV5Kf8VJ9rAsA5eww@mail.gmail.com>
	<CAHQk_AR+n7pq==TSTz5JwVRhg=jOKMXKniGrgdVTVTea5=aq1Q@mail.gmail.com>
	<50793B0E.5020002@xenomai.org>
	<CAHQk_ASEpt2Xxr4CN+x17LGRCESqv_4CKHe=5UnmtchakLwFAQ@mail.gmail.com>
	<50793CB6.3070708@xenomai.org>
Date: Sun, 14 Oct 2012 15:16:30 -0300
Message-ID: <CAFNBftcUs=uMA13xvhM2wwersAdUpO=7WbQpydqYiYuU72FYZw@mail.gmail.com>
From: Flavio Castro Alves Filho <flavio.alves@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Xenomai on Yocto/Openembedded
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hello,

Thank you for your quick response (despite my delayed answer).

I used the separated kernel approach too (delivery time issues). I
intend to reorganize in order to have the complete procedure, such as
recommended by Gilles. When I get it done, I'll send here the patch.

I'm using imx53 quick start board for my project, using meta-fsl-arm
with Yocto project.

Thank you very much for your help.

Best regards,

Flavio

PS: I couldn't find a Xenomai recipe in Openembedded tree.

2012/10/13 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> On 10/13/2012 12:02 PM, Maksym Parkachov wrote:
>
>> Hi Gilles,
>>
>>> Adding I-pipe and Xenomai as a single patch to the kernel does not seem
>>> the way to go.
>>>
>>> I would rather have the linux kernel building rules call
>>> prepare-kernel.sh to apply the I-pipe patch and setup xenomai links to
>>> the xenomai package source directory. It is not really hard, and it
>>> makes things way easier to maintain.
>>
>> It was just a quick way to get result, when I have time I'll try to
>> rework recipe with your suggestions.
>
>
> No problem, really, it was just a remark.
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

