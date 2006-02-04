Message-ID: <43E4A197.6030801@domain.hid>
Date: Sat, 04 Feb 2006 09:44:07 -0300
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM mmap alternative
References: <20060203192739.87567.qmail@domain.hid>
	<43E46EDA.7060304@domain.hid>
In-Reply-To: <43E46EDA.7060304@domain.hid>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi, Jan. I think I wasn't very clear on my post. I'll try to clarify=20
what I meaned...

Jan Kiszka escreveu:
> Rodrigo Rosenfeld Rosas wrote:
>  =20
>> Hi Jan, I'm back on this discussion.
>>
>> At the time I asked you, you told me to do the mmap on driver
>> initialization.
>>
>> But now, I realized that, since I'll be using RTDM, how could I use
>> mmap from RTDM, even if in a non RT-context?
>>    =20
>
> Which mapping step are you now referring to, the one to get the large
> physical DMA area inside the kernel address space or the one to map
> kernel addresses to user space?
I'm refering to the second case. I want to map the kernel addresses to=20
user space but I'm not very sure if I can do the same thing I did in my=20
previous mmap call on an ioctl. I mean, I don't know if the kernel does=20
something else in a mmap call... And since I don't have a mmap handler=20
I'm a bit confusing...

>  Already checked the related LDD3 chapter for this?
>  =20
Yes, but it didn't answered to my doubts...
>> I'm a bit confusing...
>>
>> What would be others alternatives for avoid copying the video frames
>> in a RTDM driver?
>>    =20
>
> Either map or copy, there is no third way. The point is just which
> mapping functions to use and when.
>  =20
That is what I would like to know... Which mapping functions are=20
available? Actually, if I can use the same I used on my previous mmap=20
handler that is good. I'm just unsure if something will be missing or not...

I have also noted that there is no poll or select handler on RTDM. Are=20
there some plans to include them?

Thank you,

Rodrigo.


	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


