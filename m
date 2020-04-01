Subject: Re: Directory /proc/xenomai/registry/rtipc/xddp does not exist
References: <LEXPR01MB0701827C1E997DC3541284B58FCF0@LEXPR01MB0701.DEUPRD01.PROD.OUTLOOK.DE>
 <4426b307-184f-0422-afe8-2d9d41625608@web.de>
 <LEXPR01MB0224A5674739063B3262F5028FC80@LEXPR01MB0224.DEUPRD01.PROD.OUTLOOK.DE>
 <LEXPR01MB0224CBFBE73173F2167F54FD8FC90@LEXPR01MB0224.DEUPRD01.PROD.OUTLOOK.DE>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <0df9f459-7fb2-c042-7ccb-8cbab6595219@web.de>
Date: Wed, 1 Apr 2020 13:48:40 +0200
MIME-Version: 1.0
In-Reply-To: <LEXPR01MB0224CBFBE73173F2167F54FD8FC90@LEXPR01MB0224.DEUPRD01.PROD.OUTLOOK.DE>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jona Ostermann <Jona.Ostermann@janztec.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01.04.20 11:38, Jona Ostermann wrote:
> Hello Jan,
>
> our customer still has some problems creating this link.
> They were using Xenomai 2 before and now have switched to Xenomai 3.1.
>
> They were using the function rt_pipe_create in Xenomai 2, is there anyth=
ing different in Xenomai 3?
>
> We have set the following kernel configuration f=C3=BCr XDDP:
>
> CONFIG_XENO_DRIVERS_RTIPC=3Dm
> CONFIG_XENO_DRIVERS_RTIPC_XDDP=3Dy
> CONFIG_XENO_DRIVERS_RTIPC_IDDP=3Dy
> CONFIG_XENO_OPT_IDDP_NRPORT=3D32
> CONFIG_XENO_DRIVERS_RTIPC_BUFP=3Dy
> CONFIG_XENO_OPT_BUFP_NRPORT=3D32
>
> Is there anything else needed?

Rather than guessing what might have changed and what might affect you:
Can you provide a test case for what is not working as expected?

Jan

>
> Best Regards
> Jona
>
> -----Urspr=C3=BCngliche Nachricht-----
> Von: Jona Ostermann
> Gesendet: Dienstag, 31. M=C3=A4rz 2020 16:03
> An: 'Jan Kiszka' <jan.kiszka@web.de>; xenomai@xenomai.org
> Betreff: AW: Directory /proc/xenomai/registry/rtipc/xddp does not exist
>
> Hello Jan,
>
> thank you, you are correct.
> Using the xddp-label demo tool the link is created.
> So it is an application error and not a Xenomai configuration error.
>
> Best regards
> Jona
>
> -----Urspr=C3=BCngliche Nachricht-----
> Von: Jan Kiszka <jan.kiszka@web.de>
> Gesendet: Freitag, 27. M=C3=A4rz 2020 10:07
> An: Jona Ostermann <Jona.Ostermann@janztec.com>; xenomai@xenomai.org
> Betreff: Re: Directory /proc/xenomai/registry/rtipc/xddp does not exist
>
> On 26.03.20 11:12, Jona Ostermann via Xenomai wrote:
>> Hello,
>>
>> one of our customers hast he problem that he needs a registry link in t=
he directory /proc/xenomai/registry/rtipc/xddp.
>> But the directory does not exist, only /proc/xenomai/registry/ exists.
>>
>> What could be the problem?
>> Is a special kernel configuration required or does a special kernel mod=
ule need to be loaded?
>>
>
> The links show up once xddp is being used. You can check that via smokey=
's xddp test.
>
> If that is not the case, compare configuration and versions of the refer=
ence xenomai-images against your setup and share your findings.
>
> Jan
>


