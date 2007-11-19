Message-ID: <2ff1a98a0711190306w3f8c2b1ub3ce52700febb89c@domain.hid>
Date: Mon, 19 Nov 2007 12:06:47 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB026DBDC5@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <DD39B5C3F4963040ADC9768BE7E430CB026DBC4E@is-hdq-exchange.marel.net>
	<18239.3938.28607.266649@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB026DBDC5@domain.hid>
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

On Nov 19, 2007 10:23 AM, Daniel Schnell <daniel.schnell@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
> >
> > You misread the POSIX spec. It says:
> > "The timeout shall expire when the absolute time specified by
> > abs_timeout passes, as measured by the clock on which timeouts are
> > based (that is, when the value of that clock equals or exceeds
> > abs_timeout), or if the absolute time specified by abs_timeout has
> > already been passed at the time of the call."
> >
> > But it also says:
> > "Under no circumstance shall the operation fail with a timeout if
> > there is sufficient room in the queue to add the message immediately.
> > The validity of the abs_timeout parameter need not be checked when
> > there is sufficient room in the queue."
>
>
> Ok. I missed that part. Thanks for clarifying.
>
>
> But this doen't change the fact that the delivered message is sent
> incorrectly.

This should be solved in trunk (commits 3187 and 3188).


-- 
                                               Gilles Chanteperdrix

