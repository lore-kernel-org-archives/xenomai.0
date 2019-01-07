Message-ID: <1546854954.2940.4.camel@smigroup.net>
Subject: Re: Help:About xenomai service
From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Mon, 07 Jan 2019 10:55:54 +0100
In-Reply-To: <tencent_22D390B47E6CF0866FC836F2@qq.com>
References: <tencent_22D390B47E6CF0866FC836F2@qq.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: PerSiStenCe <2631140698@qq.com>, xenomai <xenomai@xenomai.org>

On Mon, 2019-01-07 at 09:23 +0800, PerSiStenCe via Xenomai wrote:
> Hi
> =C2=A0=C2=A0=C2=A0=C2=A0I am testing xenomai 3 on Kaby Lake board(Intel=
 i5-7200u) with
> xenomai 3.0.5 & Linux 4.9.38(ubuntu 16.04);when I run "latency" test
> program,some overruns always come out during the testing period;is
> there any consultant service or other format service available?

Hi,
this could be related to what reported at [1].

Please check dmesg to see if a stack dump is generated when overruns
occours.


[1] https://xenomai.org/pipermail/xenomai/2018-December/040142.html


