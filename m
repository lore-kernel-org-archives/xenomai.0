Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=iso-8859-1
From: Skander Bahloul <skander.bahloul@imag.fr>
In-Reply-To: <51FF8F1D.6010002@xenomai.org>
Date: Wed, 7 Aug 2013 17:22:22 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <08A3370B-8A54-4F6D-9076-2B41F933842C@imag.fr>
References: <0DE90633-1CDC-4BB5-837D-D9FA5409B73D@imag.fr>
	<51FF8F1D.6010002@xenomai.org>
Subject: Re: [Xenomai] polling task and rt_task_sleep()
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

Hi,

well, I surprised that it blocked parent process.

Is it really normal?


Thank you for answer.

Best regards,=20
Le 5 ao=FBt 2013 =E0 13:40, Gilles Chanteperdrix a =E9crit :

> On 08/01/2013 06:20 PM, Skander Bahloul wrote:
>> Dear Xenomai list members,
>>=20
>> I'am trying to use xenomai for a polling task.
>>=20
>> I'am use rt_task_sleep() and i discover that this function is
>> important to execute the program but it causes latencies.
>>=20
>> If i delete this function, the terminal freeze.
>=20
> Hi,
>=20
> good! it means xenomai works as expected: your polling task has the
> highest priority and prevent anything else from running.
>=20
> Regards.
>=20
> --=20
>                                                                Gilles.


