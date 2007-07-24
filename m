Message-ID: <2ff1a98a0707240521u392be5c4kd7ce1382cdb1132a@domain.hid>
Date: Tue, 24 Jul 2007 14:21:58 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2862c2c80707240334v46bcfe6fl42519d57ced3d5a9@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2862c2c80707240334v46bcfe6fl42519d57ced3d5a9@domain.hid>
Subject: Re: [Xenomai-help] Latency Testsuite for AT91
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yeoh Chun Yeow <yeohchunyeow@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

On 7/24/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
> Dear all,
>
> My AT91 system hangs after executing the latency program in the testsuite.
>
> [root@domain.hid]
> ./run
> *
> *
> * Type ^C to stop this application.
> *
>  *
> == Sampling period: 100 us

100 us is too short for AT91, try passing -p 1000

-- 
                                               Gilles Chanteperdrix

