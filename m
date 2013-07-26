MIME-Version: 1.0
In-Reply-To: <51F2D6E9.5080108@xenomai.org>
References: <CAH9k9C-uqb3Y2j9UzGdKv-p67X2Vz11yiidb_oYuB5MiQ0y03A@mail.gmail.com>
	<51F2D6E9.5080108@xenomai.org>
Date: Fri, 26 Jul 2013 15:20:50 -0500
Message-ID: <CAH9k9C8WNX4mgMW0VmQZL-qOYNgNtgSC9Bsvdh2QD4dCaiCB8w@mail.gmail.com>
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

Thanks for the answer.


I'm using cython, so in a way I'm linked to the Xenomai libraries, and I
don=E2=80=99t know if this makes a difference. The python->xenomai messages=
 are
working. Can I trust this? Also, I just found about buffers, should they
work? Or as you said previously, I should stick with pipes?

Thanks again


2013/7/26 Philippe Gerum <rpm@xenomai.org>

> On 07/26/2013 09:28 PM, Ricardo Am=C3=A9zquita wrote:
>
>> Hello All
>>
>> I'm writing a simple wrapper in python to be able to control some
>> real-time
>> processes. To communicate between the real-time process, and the python
>> process I'm using native queues. Sending messages from the python proces=
s
>> to the realtime process is working fine, but when I try to send a messag=
e
>> from the realtime process to the python process, I'm having problems.
>> Using
>> rt_queue inquire, I know that the message is in the queue, but the recei=
ve
>> function in the python side, never receives it.
>>
>> Is there a limitation that apply to my application? I have tested with
>> pipes, and it works, but I want to implement everything using queues.
>>
>>
> If your python process is not supposed to run Xenomai services at all,
> i.e. mere Linux application not even linked with the Xenomai libraries,
> then message pipes are definitely what you are looking for. Queues won't
> work, since the python side won't be allowed to receive from a real-time
> queue.
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
