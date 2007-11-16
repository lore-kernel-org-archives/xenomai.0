Message-ID: <2ff1a98a0711161037n374d388p2ed0dbe592f394a6@domain.hid>
Date: Fri, 16 Nov 2007 19:37:24 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2ff1a98a0711160718x57ee9129w2424c1e1a9c4e32d@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <DD39B5C3F4963040ADC9768BE7E430CB026DBC4E@is-hdq-exchange.marel.net>
	<2ff1a98a0711160718x57ee9129w2424c1e1a9c4e32d@domain.hid>
Subject: Re: [Xenomai-help] Houston,
	we have a problem ... In timed POSIX space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

On Nov 16, 2007 4:18 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Nov 16, 2007 4:00 PM, Daniel Schnell <daniel.schnell@domain.hid> wrote:
> >
> >
> > Hi,
> >
> > The attached program demonstrates that mq_timedsend() doesn't work. The sent
> > value changes on the way to the receiver.
>
> will check your example ASAP.
>
>  Always! mq_send() works fine.
> > Additionally if no asolute timeout value is used, there will be no error
> > returned which is contrary to the POSIX standard (however glibc2.3 also
> > fails here).
>
> There is no way to make difference between an absolute and relative
> timeout. Additionaly, the only constraint I see in the POSIX spec is
> that what should be checked is that the tv_nsec member of the timeout
> should be less than 1000000000, which Xenomai posix skin does.

Actually, if you pass a relative timeout, it will probably be
considered as a date in the past, so mq_timedsend should return
-ETIMEDOUT immediately. And it is what the POSIX spec asks.


-- 
                                               Gilles Chanteperdrix

