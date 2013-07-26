MIME-Version: 1.0
In-Reply-To: <51F2DDD4.9080300@xenomai.org>
References: <CAH9k9C-uqb3Y2j9UzGdKv-p67X2Vz11yiidb_oYuB5MiQ0y03A@mail.gmail.com>
	<51F2D6E9.5080108@xenomai.org>
	<CAH9k9C8WNX4mgMW0VmQZL-qOYNgNtgSC9Bsvdh2QD4dCaiCB8w@mail.gmail.com>
	<51F2DCA1.3090903@xenomai.org> <51F2DDD4.9080300@xenomai.org>
Date: Fri, 26 Jul 2013 15:41:09 -0500
Message-ID: <CAH9k9C864U02zSRxt_9W4yTVrA6+juW80jkQr_JhAznizAC0jw@mail.gmail.com>
From: =?UTF-8?Q?Ricardo_Am=C3=A9zquita?= <ramezquitao@cihologramas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Queue issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai@xenomai.org

Thanks for the help. I'm already playing with rt_task_shadow(). I'll post
the results.




2013/7/26 Philippe Gerum <rpm@xenomai.org>

> On 07/26/2013 10:31 PM, Philippe Gerum wrote:
>
>> On 07/26/2013 10:20 PM, Ricardo Am=C3=A9zquita wrote:
>>
>>> Thanks for the answer.
>>>
>>>
>>> I'm using cython, so in a way I'm linked to the Xenomai libraries, and =
I
>>> don=E2=80=99t know if this makes a difference. The python->xenomai mess=
ages are
>>> working. Can I trust this?
>>>
>>
>> Yes, because the send side does not request
>>
>
> s,request,require,
>
> --
> Philippe.
>



--=20
Ricardo Am=C3=A9zquita O

Combusti=C3=B3n Ingenieros Ltda
Cll 25B # 85B - 76, Bogot=C3=A1 / Colombia
Tel: 57-1-2635232
Fax: 57-1-4296516
http://www.cihologramas.com
