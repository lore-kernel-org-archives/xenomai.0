Date: Tue, 10 Nov 2015 17:16:15 +0000 (UTC)
From: Frederik Bayart <frederik_bayart@yahoo.co.uk>
Message-ID: <1769796423.4391042.1447175775237.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <20151108180426.GU1798@hermes.click-hack.org>
References: <20151108180426.GU1798@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] kernel problem xenomai 2.6.4 - linux 3.8.13
Reply-To: Frederik Bayart <frederik_bayart@yahoo.co.uk>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

>On Sunday, 8 November 2015, 19:04, Gilles Chanteperdrix <gilles.chanteperd=
rix@xenomai.org> wrote:
>
>On Fri, Nov 06, 2015 at 04:58:40PM +0000, Frederik Bayart wrote:
>
>> Hallo,
>>
>> I'm using xenomai 2.6.4 on kernel 3.8.13 (patch ipipe-core-3.8.13-x86-4.=
patch)
>>
>> In attachment you find the kernel config.
>>
>> When I boot the kernel on a recent pc's (Intel(R) Core(TM) i5), I don't =
get problems, but if I install the same image on an older pc, (Intel(R) Cor=
e(TM) Duo CPU=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 T2500=C2=A0 @ 2.00GHz), I get p=
eriodic kernel traces after booting without running any real-time process (=
see below). In the dmesg in attachment, I see a stack trace.
>> (If I build a normal linux kernel without ipipe patch, I get no kernel t=
races.)
>>
>> Has anyone has a suggestion what could go wrong ?
>
>
>The NULL EIP suggest an NULL handler. Any chance to test something
>more recent? Like xenomai 2.6 git head, with the latest I-pipe patch
>for 3.18?
>
>Gilles.

First impression is that building and installing xenomai 2.6 git head with =
ipipe-core-3.18.20-x86-3.patch seems to solve the problem.
The problem was still existing in xenomai 2.6.4 and kernel 3.14.17, so I gu=
ess the problem might been fixed after the release of 2.6.4
I will test further.

Thanks for the help.

Frederik








  
