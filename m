Message-ID: <2ff1a98a0801230515i77f8c22bk866c4cd592a3a9b8@domain.hid>
Date: Wed, 23 Jan 2008 14:15:53 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2ff1a98a0801230204s15e4eefaifdd2c946c44549df@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080123065221.GB6573@domain.hid>
	<2ff1a98a0801230204s15e4eefaifdd2c946c44549df@domain.hid>
Subject: Re: [Xenomai-help] AT91SAM9260 latency
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Juan Antonio Garcia Redondo <juan-antonio.garcia@domain.hid>
Cc: jagarcia@domain.hid, xenomai@xenomai.org

On Jan 23, 2008 11:04 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Jan 23, 2008 7:52 AM, Juan Antonio Garcia Redondo
>
> <juan-antonio.garcia@domain.hid> wrote:
> > I see everything OK except for the first samples of cyclictests. Any comments ?
>
> The load you apply does not load the cache, which is a source of
> jitter. You should run the cache calibrator (I do not find the cache
> calibrator URL, but it is somewhere in Xenomai distribution or wiki).

It is in the TROUBLESHOOTING guide, question "How do I adequately stress test".

-- 
                                               Gilles Chanteperdrix

