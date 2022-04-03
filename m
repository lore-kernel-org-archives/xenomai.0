Date: Sun, 3 Apr 2022 21:59:29 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <543716113.213122.1649015969293.JavaMail.zimbra@nod.at>
In-Reply-To: <77e99c33-abac-8ebe-d690-3ba0ede05fda@siemens.com>
References: <20220403144348.1775590-1-rpm@xenomai.org>
 <317493564.212576.1649003575604.JavaMail.zimbra@nod.at>
 <87ilrqnjdp.fsf@xenomai.org>
 <77e99c33-abac-8ebe-d690-3ba0ede05fda@siemens.com>
Subject: Re: [PATCH v2] x86: dovetail: reinstate I/O bitmap on user entry
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Philippe Gerum <rpm@xenomai.org>, xenomai <xenomai@xenomai.org>

----- Urspr=C3=BCngliche Mail -----
> Von: "Florian Bezdeka" <florian.bezdeka@siemens.com>
> An: "Philippe Gerum" <rpm@xenomai.org>, "richard" <richard@nod.at>
> CC: "xenomai" <xenomai@xenomai.org>
> Gesendet: Sonntag, 3. April 2022 21:41:51
> Betreff: Re: [PATCH v2] x86: dovetail: reinstate I/O bitmap on user entry
>>> For the whole series:
>>> Reviewed-by: Richard Weinberger <richard@nod.at>
> This email address is different from the address used in the Reported-
> and Tested-By tags in the patch.

Sorry, this is due my wicked mail setup.
I use Google mail as /dev/null for mailing lists. :-)

>> These are the two remaining patches in the final series, ok for both?
>>=20
>> tick: irq_pipeline: fix proxying of a broadcast device
>> x86: dovetail: reinstate I/O bitmap on user entry
>>=20
>>> Thanks for addressing the issue so quickly. :-)
>>>
>>=20
>> You are welcome, your test case made it easy.
>=20
> Any chance to integrate the test case into the test suite?

Yes, the only thing we have to keep in mind is that the test
writes to an IO port. I don't know whether this will make
some hardware unhappy.
But I think the test can easily get changed to reading instead
of writing.

Thanks,
//richard

