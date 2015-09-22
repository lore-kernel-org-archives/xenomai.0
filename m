MIME-Version: 1.0
In-Reply-To: <20150922035212.GF28220@hermes.click-hack.org>
References: <20150919151423.GE22852@hermes.click-hack.org>
 <CAFkYNwZSskEBYeHOK1UEXi7iGucm5x=O7wBB9YQ+1A_Gu9iGgA@mail.gmail.com>
 <CAFkYNwZS5Js_22DMKozYciMwVUKxPbUJ0-FoAxoY50rfxtcBQA@mail.gmail.com>
 <20150920081716.GH22852@hermes.click-hack.org>
 <CAFkYNwY_sQxtHYfB=Y-bcpGyfaENWjAwnx0Yc7VvWcEPaUH+fg@mail.gmail.com>
 <20150920170330.GA3486@hermes.click-hack.org>
 <CAFkYNwbHQXK8_YA1A0NLErdcHbYB-PpTMo09VUaae7fgQTmxfw@mail.gmail.com>
 <20150921144615.GA20753@hermes.click-hack.org>
 <CAFkYNwYS1NLVK9Kx7ZiVWaM37mLRyfLMFHMV9=on1yjhTux6Fw@mail.gmail.com>
 <CAFkYNwYZJ8QF5cUUqyDULcxNCQRoYh8guZR-M-6TdFHn26Ex7A@mail.gmail.com>
 <20150922035212.GF28220@hermes.click-hack.org>
Date: Tue, 22 Sep 2015 17:55:45 +1200
Message-ID: <CAFkYNwbX30tDzG1iOOj=CKQCyFgj+3jWhnX6WCcFw0ScSSjsOA@mail.gmail.com>
From: vibnwis <vibnwis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Installing xenomai libraries ARM OMAP4460
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is the ipipe-ipipe-core-3.18.20-arm-5.

By typing make kernelversion, I got 3.18.20

qws@qws-MacBookPro:~/PandaBoard-2/ipipe-ipipe-core-3.18.20-arm-5$ make
kernelversion
3.18.20

>From my observation in the menuconfig, it has ipipe integrated. And on
target, uname -r return 3.18.20-ipipe




On 22 September 2015 at 15:52, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Tue, Sep 22, 2015 at 02:28:00PM +1200, vibnwis wrote:
> > Having no lucks, I switched it to ipipe-ipipe-core-3.18.20-arm-5.tar.bz2
> > which I presume it has all the patches required.
>
> No it does not. See:
> http://xenomai.org/installing-xenomai-3-x/#Preparing_the_Cobalt_kernel
>
> --
>                                             Gilles.
> https://click-hack.org
>
