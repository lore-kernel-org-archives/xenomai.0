MIME-Version: 1.0
In-Reply-To: <20160707125109.GO9465@hermes.click-hack.org>
References: <CALZu-7YbLMszbw+82nWzZ+9W=VYKY0s81UGmq=UvQw_fg3XHrw@mail.gmail.com>
 <20160707125109.GO9465@hermes.click-hack.org>
From: marc favereau <favereau.marc.m2gl@gmail.com>
Date: Thu, 7 Jul 2016 15:27:37 +0200
Message-ID: <CALZu-7YPEdg7U4ShiK_6K9KtWUBtREp37e97cc0udwo=u1XD-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Serial port problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Of course !!!

Thanks a lot for four help,
That's work fine !

Marc

2016-07-07 14:51 GMT+02:00 Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org>:

> On Thu, Jul 07, 2016 at 02:40:03PM +0200, marc favereau wrote:
> > when i read the driver code source (16550A.c) i think there is a problem
> > with 'rtdm_irq_request' function. It's like the IRQ was not shared
> between
> > the 4 ports of the card !!!
> >
> > I don't understand why !
>
> Do you have CONFIG_XENO_OPT_SHIRQ enabled in the kernel configuration?
>
> --
>                                             Gilles.
> https://click-hack.org
>
