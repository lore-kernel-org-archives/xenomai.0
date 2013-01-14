Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1283)
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <50F3F296.5000008@xenomai.org>
Date: Mon, 14 Jan 2013 13:05:15 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <3F8DFF0B-6F81-48E1-9D64-83B08DA6A599@mah.priv.at>
References: <D9F55F45-EC38-45B2-A922-08F24868BA87@mah.priv.at>
	<50F3F296.5000008@xenomai.org>
Subject: Re: [Xenomai] universal application binary: how to
	auto-detect	Xenomai/RT-PREEMPT/vanilla kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Gilles,

Am 14.01.2013 um 12:57 schrieb Gilles Chanteperdrix:

> On 01/14/2013 09:29 AM, Michael Haberler wrote:
>=20
>> Hi,
>=20
>=20
> Hi,
>=20
>>=20
>> thanks to patience on this list we were able to build linuxcnc such
>> that it runs on Xenomai, besides RT-PREEMPT, vanilla kernels (in a
>> simulator/non-RT mode) and RTAI
>>=20
>>=20
>> I'm planning to adapt linuxcnc such that a universal binary can be
>> built which runs under Xenomai, RT-PREEMPT and vanilla kernels as
>> this will simplify logistics quite a bit; what I'd like have is
>> reliable auto-detection of the kernel type and 'do the right thing'
>> (RTAI will remain a separate build).
>=20
>=20
> I have no idea about preempt_rt, however, in order to detect xenomai,
> you can check for /dev/rtheap. If it does not exist, xenomai programs
> will not start anyway. Also, I guess for a universal binary, you would
> dlopen xenomai libraries (native or posix, depending on the one you =
want
> to use), if you want to do that, you have to pass =
--enable-dlopen-skins
> to xenomai configure script.

thanks, that is a good idea to verify the libraries are in place; I had =
to use --enable-dlopen-skins anyway to make Python imports happy.

I'll muddle my way through some string matching to find rt-preempt =
running; =
https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO#Checking_the_Kernel =
gives some hints

Is there any chance somebody runs Xenomai AND RT_PREEMPT patches =
applied? I heard a rumor but havent actually seen that

regards

- Michael



