Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Stefan Schaal <sschaal@domain.hid>
In-Reply-To: <1294242791.1828.6.camel@domain.hid>
Date: Thu, 6 Jan 2011 14:05:47 -0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <B177BAEC-ED02-40F8-9057-AF7445A6F321@domain.hid>
References: <515034A5-8E42-4ACC-B08E-FC8A05DEB293@domain.hid>
	<1287218938.1854.11.camel@domain.hid>
	<A059C858-912A-4207-A834-411C50184622@domain.hid>
	<1294236456.1828.3.camel@domain.hid>
	<B531163E-B46F-465A-8970-13BC59A61496@domain.hid>
	<1294242791.1828.6.camel@domain.hid>
Subject: Re: [Xenomai-core] hanging in Xenomai 2.5.5
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi Philippe,

  thanks a lot for the hint. I configured my kernel from scratch, and =
got rid of the linux compile problems. I could thus verify that the =
commit you mentioned below DOES NOT have the problem I described, i.e., =
semaphores used by multiple processes which are running on different =
cores DID NOT hang anymore.

   Then, I thought I try to bisect the problem with git, and I pulled =
the latest version of the 2.5 repository. Interestingly, with the very =
latest commits, my problem has gone away. I confirmed this by switching =
back to Alexis' analogy branch, which I need for my development. This =
branch is not quite as up-to-date as the 2.5 branch, and the hanging =
problem still exists. I merged the analogy branch with the latest 2.5 =
branch, and now nothing hangs anymore.

  I guess, I stop investigating at this point, unless the problem =
re-apprears.

Thanks so much for you help!

Best wishes,

-Stefan



On Jan 5, 2011, at 7:53, Philippe Gerum wrote:

> On Wed, 2011-01-05 at 07:41 -0800, Stefan Schaal wrote:
>> HI Philippe,
>>=20
>>  sorry, I must have mis-communicated. This was, of course, a xenomai =
commit that I tried, and the errors I sent you resulted when recompiling =
the linux kernel with this xenomai version.
>>=20
>=20
> Those errors are not related to Xenomai, they happen on basic linux
> code. Make sure to work from a fresh build tree, using a proper
> toolchain. It looks like something is severely broken in your build =
env.
>=20
>> -Stefan
>>=20
>>=20
>> On Jan 5, 2011, at 6:07, Philippe Gerum wrote:
>>=20
>>> On Sat, 2010-12-25 at 11:02 -0800, Stefan Schaal wrote:
>>>> 6a020f5
>>>=20
>>> I don't see how this messages could be related to Xenomai. I was
>>> mentioning a Xenomai commit, not a linux one. You should reset to =
this
>>> commit:
>>>=20
>>> commit 6a020f5a89955a42f1e03621ae6c63a587e9c75c
>>> Author: Philippe Gerum <rpm@xenomai.org>
>>> Date:   Sat Aug 28 13:04:45 2010 +0200
>>>=20
>>>   nucleus, posix: use fast APC scheduling call
>>>=20
>>> --=20
>>> Philippe.
>>>=20
>>>=20
>>=20
>=20
> --=20
> Philippe.
>=20
>=20


