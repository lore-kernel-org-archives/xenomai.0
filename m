Message-ID: <2ff1a98a0708090926y1aaaab73n38388bf83eb3f257@domain.hid>
Date: Thu, 9 Aug 2007 18:26:26 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <3535aae80708090909m57f10233rd317cc862f534702@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3535aae80708090211m198a1b87o9ae164fd94362838@domain.hid>
	<2ff1a98a0708090242k70178437y716b502ce338e0a6@domain.hid>
	<46BAF956.5090401@domain.hid>
	<3535aae80708090909m57f10233rd317cc862f534702@domain.hid>
Subject: Re: [Xenomai-help] hard lock-up
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: andy motten <andy.motten@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On 8/9/07, andy motten <andy.motten@domain.hid> wrote:
> Hello, thanks for the fast response.
>
> We have followed your advice:
>  - enabled the linux debugs, nmi_watchdog debugs and Xenomai debugs.
>  - make use of a serial console.

Please disable Xenomai nmi watchdog, it does not seem to work
correctly on your machine.

-- 
                                               Gilles Chanteperdrix

