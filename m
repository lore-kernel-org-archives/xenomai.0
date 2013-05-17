MIME-Version: 1.0
In-Reply-To: <51960FB1.9030400@xenomai.org>
References: <CAMDpcBGxGUCtcnREr9AeQihhiNO8D7vvxbFCa7647fOO4rMzow@mail.gmail.com>
	<51960FB1.9030400@xenomai.org>
Date: Fri, 17 May 2013 13:59:06 +0200
Message-ID: <CAMDpcBF84ZRLG=eeyhus5qE5+t5Smf_jETtVGUSC9r7iu62ARg@mail.gmail.com>
From: kunming yang <yangkunming99@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] <6>Xenomai: scheduling class idle registered.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Ok, I will have a try. Thank you very much for reply.


On Fri, May 17, 2013 at 1:08 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 05/17/2013 12:41 PM, kunming yang wrote:
>
> > Hello,
> >
> > When I boot my Cubieboard(A10) with xenomai, the kernel hangs after this
> > message:
> > <6>Xenomai: scheduling class idle registered.
> > What might cause this?
> >
> > Any help would be appreciated!
>
>
> To find where the kernel really blocks:
> - enable early printk (as described in the porting guide)
> - add calls to printascii in the code to find what is the last function
> called.
>
> My guess would be the hardware timer initialization.
>
> --
>                                                                 Gilles.
>
