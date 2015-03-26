MIME-Version: 1.0
In-Reply-To: <20150326154402.GU15125@hermes.click-hack.org>
References: <20150323220935.GA19836@hermes.click-hack.org>
 <CAJT0owGFHg9cuqWQWYY1y93=Dff9pHUyE+Gct_1=RM2gOwNK_w@mail.gmail.com>
 <20150324160153.GB15125@hermes.click-hack.org>
 <20150324161347.GC15125@hermes.click-hack.org>
 <CAJT0owE5VFmOfH05BZTZ4xZ_8=Co6Anu7VWa3qcW-MLMJK8GTQ@mail.gmail.com>
 <CAJT0owE7vtJDWM289=4cNR_LuUqPWAO60nvg9D0NiTQWeN9Xbg@mail.gmail.com>
 <20150326143151.GM15125@hermes.click-hack.org>
 <CAJT0owEumqaqe+Kd2cRN+cqxx1ZzA905MYE_wbeGv2t61OkNkQ@mail.gmail.com>
 <20150326145437.GR15125@hermes.click-hack.org>
 <CAJT0owFNyAPqyu4hRAU1SFdXZQjQkukvWi5sgwHoMijGxO17kQ@mail.gmail.com>
 <20150326154402.GU15125@hermes.click-hack.org>
Date: Thu, 26 Mar 2015 16:58:36 +0100
Message-ID: <CAJT0owF97KT-VMmK7ofB45mU_esXAJH7J3ge0RBYwHJHoAMFuw@mail.gmail.com>
From: Tianchi Huang <gz.eddie.htc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai 3.0-rc3 Interruption on Arietta G25
 (AT91SAM9G25 chip)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

The function gpio_irq_handler is defined in gpio.c, but i can't find
generic_handle_irq in it.

*Tianchi HUANG*

Ing=C3=A9nieur Informatique en Apprentissage

eddie.huang@bioserenity.com

Tel : +33(0) 6 52 86 29 86



BioSerenity

ICM-iPEPS

47-85 boulevard de l'H=C3=B4pital

75013 Paris


www.bioserenity.com

2015-03-26 16:44 GMT+01:00 Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org>:

> On Thu, Mar 26, 2015 at 04:40:58PM +0100, Tianchi Huang wrote:
> > [<c0041dbc>] (generic_handle_irq) from [<c019681c>]
> > (gpio_irq_handler+0x98/0xd0)
> > [<c019681c>] (gpio_irq_handler) from [<c005913c>]
> > (__ipipe_dispatch_irq+0x7c/0x258)
>
> As I explained, this is the problem.
>
> Could you search with objdump what file defines gpio_irq_handler ?
>
> --
>                                             Gilles.
>
