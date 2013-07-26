Message-ID: <1374841118.86884.BPMail_high_noncarrier@web125405.mail.ne1.yahoo.com>
Date: Fri, 26 Jul 2013 05:18:38 -0700 (PDT)
From: GP Orcullo <kinsamanka@ymail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] XDDP test failure on Raspberry Pi, 3.8.13 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: kinsamanka@ymail.com, gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

=0A------------------------------
On Fri, Jul 26, 2013 5:09 AM PDT GP Orcullo wrote:

>----- Original Message -----
>
>From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>To: GP Orcullo <kinsamanka@ymail.com>
>Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>
>Sent: Friday, July 26, 2013 4:26 AM
>Subject: Re: [Xenomai] XDDP test failure on Raspberry Pi, 3.8.13 kernel
>
>On 07/24/2013 02:12 PM, GP Orcullo wrote:
>
>> Hi,
>>
>> Raspberry Pi on Xenomai v2.6.2.1 passes all the regression tests
>> except for the xddp_test.=A0 The test fails with "FAILURE bind: Address
>> already in use".
>>
>> How do I resolve this issue?
>
>
>Hi,
>
>do you have the same issue with Xenomai from git repository?
>
>
>--=20
>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0Gilles.
>
>
>Hello Gilles,
>
>I have restarted from scratch and the issue seemed to have resolved itself=
. I have no clue why it initially failed.
>
>Thanks!
>
>GP Orcullo

I have found the cause.

If the module xeno_klat is loaded, xddp_test fails.

