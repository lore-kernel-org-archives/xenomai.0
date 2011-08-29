MIME-Version: 1.0
In-Reply-To: <4E5792CE.8080307@domain.hid>
References: <4E5792CE.8080307@domain.hid>
Date: Tue, 30 Aug 2011 01:00:13 +0200
Message-ID: <CAMesUR6yiWjSgpE3gxSj5SjsUvoxLK4p-X039_JUEUBriS+6cQ@mail.gmail.com>
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-core] Xenomai 2.6.0, or -rc1?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

On Fri, Aug 26, 2011 at 2:34 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
> Hi,
>
> I think it is about time we release Xenomai 2.6.0. Has anyone anything
> pending (maybe Alex)? Should we release an -rc first?
>
Yes. in my experimental branch, I have a few things which are not that
experimental. I would like to push:
- a first version of Julien Delange's ni_660x driver
- Anders Blomdell's fix on duplicate sympbols with comedi
- Anders Blomdell's fix in pcimio driver (wrong IRQ number after reboot)
- some waveform generation tools (fully generic)
- an overhaul of the testing drivers (fake + loop => fake)

I will integrate them in my analogy branch and send a pull request if
you are OK with that.

Alexis.

