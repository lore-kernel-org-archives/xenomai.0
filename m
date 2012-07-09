Message-ID: <4FFAFD2E.4010501@logilin.fr>
Date: Mon, 09 Jul 2012 17:47:57 +0159
From: Christophe Blaess <mailist@logilin.fr>
MIME-Version: 1.0
References: <CAKKWdtfz7+pRjjbE6Ev4zJNZpa45axMePyVar+3MyRyMvcp8aA@mail.gmail.com>
	<4FCF4D05.3070502@xenomai.org> <4FCF58AF.5040106@xenomai.org>
	<4FCF5A4C.60704@xenomai.org> <4FCF5DED.8060007@xenomai.org>
	<4FCF60CD.8000709@xenomai.org> <4FCF6152.7010002@xenomai.org>
	<4FCF62DD.10102@xenomai.org> <4FCF68CA.8010206@xenomai.org>
	<4FCF713F.1030603@xenomai.org> <4FCF7418.4020805@xenomai.org>
	<4FCF7576.8030201@xenomai.org> <4FCF9A1E.6090706@xenomai.org>
	<4FCF9AAD.7020707@xenomai.org> <4FD1C3EE.1000005@xenomai.org>
	<4FD1C50D.5010906@xenomai.org> <4FD1C60D.401@xenomai.org>
	<4FD1C67E.5010600@xenomai.org> <4FD1C751.5070501@xenomai.org>
	<CAKKWdtdebEv14pJhTvr1qc7u3zTzjCPgZZu6h8k1nnrGnpHNdw@mail.gmail.com>
	<CAHue_TUHtzKZ6g1__=jB-y08TRnnZ93t2zY8+C-MAWy7QhH=Pg@mail.gmail.com>
	<4FF3232E.3050605@xenomai.org>
	<CAHue_TVfw+HxX4uPOQU_j766ApjBHAOPPOzxOaXvX_p5NvR=Gw@mail.gmail.com>
	<4FF708E3.9020407@xenomai.org>
	<CAHue_TUx_JT6MgFPH6Eg_rb2K2nRwxH-Mnvd6gOTU+ZGdPj5Mg@mail.gmail.com>
In-Reply-To: <CAHue_TUx_JT6MgFPH6Eg_rb2K2nRwxH-Mnvd6gOTU+ZGdPj5Mg@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-2"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] xenomai-2.6.0 instrumentation commands not executing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 09/07/2012 17:34, Marcin Ku=B6ka wrote:
> i got this:
>
> */usr/xenomai/bin # ./latency
> Xenomai init: open(/dev/mem): No such file or directory
> *
>

You can create the device file manually with

     mknod /dev/mem c 1 1

Otherwise starting "mdev -s" in your /etc/init.d/rcS script will create it.



