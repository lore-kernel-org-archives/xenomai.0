Message-ID: <43E4B7DA.7010505@domain.hid>
Date: Sat, 04 Feb 2006 11:19:06 -0300
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM mmap alternative
References: <20060203192739.87567.qmail@domain.hid>
	<43E46EDA.7060304@domain.hid> <43E4A197.6030801@domain.hid>
	<43E4A102.4070207@domain.hid>
In-Reply-To: <43E4A102.4070207@domain.hid>
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

Jan Kiszka escreveu:
> ...
>  I suggested to look at remap_pfn_range() or
> io_remap_page_range(). Do you see problems when using one of them?
>  =20
Ok, I'll try them on an ioctl on monday. I'll let you know then.
> ...
>> I have also noted that there is no poll or select handler on RTDM. Are
>> there some plans to include them?
>>    =20
> Only rough plans. This requires a lot of work and restructuring, I'm
> afraid. And I doubt that it's worth it. Do you see an urgent use-case
> for poll/select under RT? The only real-life use-case that we came
> across was ACE/TAO.
>  =20
I was thinking of providing an API similar to v4l2 on my RTDM video=20
driver. But since it does not have neither mmap nor select/poll, I'll=20
have to do all these tasks by ioctl... But that is no problem at all.=20
There will not be missing any feature but the v4l2 compatibility...

Thank you for all support you are giving me.

Best regards,

Rodrigo.


	=09
_______________________________________________________
Yahoo! Acesso Gr=E1tis - Internet r=E1pida e gr=E1tis. Instale o discador a=
gora!
http://br.acesso.yahoo.com


