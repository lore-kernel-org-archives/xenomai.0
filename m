Message-ID: <45E56DD1.4050408@domain.hid>
Date: Wed, 28 Feb 2007 12:56:01 +0100
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: high latency every 8 seconds
References: <45E4646A.10205@domain.hid>	<45E46D67.9030600@domain.hid>	<45E48543.8030800@domain.hid>
	<17892.51246.767507.976015@domain.hid>
In-Reply-To: <17892.51246.767507.976015@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Gilles Chanteperdrix wrote:
> Theo Veenker wrote:
>  > Jan Kiszka wrote:
>  > > Theo Veenker wrote:
>  > >> Hi all,
>  > >>
>  > >> I'm installing xenomai 2.2.5 (kernel 2.6.17.14) on a number of
>  > > 
>  > > When starting new, pick something new, i.e. 2.3 right now. Only if you
>  > > have good reasons, staying at older versions is recommended.
>  > 
>  > I would love to, but I couldn't get my software running with 2.3.
>  > I had to convert (a month ago) my software from RTLinux to Xenomai
>  > having only a few days for it. I have a kernel module and an app
>  > that talks to it. I use the posix skin. But with 2.3 apparently
>  > I had to load posixio and something (forgot) manually, but I just
>  > couldn't get these loaded. Since time was running out I decided
>  > to stay with 2.2.5 for the time being (unfortunately).
> 
> The only thing I see in 2.3 that could be a problem is the fact that
> user space mapping of posix shared memory is no longer enabled by
> default, was it your problem, are you using posix shared memory for
> communication between kernel-space and user-space ?
> 

That could have been the problem. I'm using shared memory. As time
permits I will try again and report what happens.

Theo



