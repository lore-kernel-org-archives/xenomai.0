Message-ID: <2ff1a98a0806100243ld67333an560e93d227e20a4f@domain.hid>
Date: Tue, 10 Jun 2008 11:43:39 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <ec954c020e0057cc34ff395b2aed5715@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <ec954c020e0057cc34ff395b2aed5715@domain.hid>
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org

On Tue, Jun 10, 2008 at 10:43 AM, Matthieu
<matthieu.connaulte_xenomai@domain.hid> wrote:
> Hi
>
> Is it possible to change the value of the xenomai scheduler's ticks period
> ? I would like the tasks to be scheduled each 1 millisecond for exemple. I
> found out xnpod_tick_announce, but I didn't find any documentation and I
> didn't find the sources.

Xenomai scheduler has no tick period. If you want, you may change a
skin period, either by using Kconfig options, or by using module
parameters. You will find documentation about the module parameters
either by using modinfo or in the text file documenting the skin you
want to use.

-- 
 Gilles

