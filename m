MIME-Version: 1.0
In-Reply-To: <50F5487F.6030903@xenomai.org>
References: <CAPpP=rPwHY3-e08p_9nAMEbzr-taOOsAJ2hKjiDjMC6k9muGUQ@mail.gmail.com>
	<50F5487F.6030903@xenomai.org>
Date: Tue, 15 Jan 2013 13:34:05 +0100
Message-ID: <CAPpP=rPPwMtod9GNhGuJonnTmeSpExAGKBG1Bxb2rucVeNY3jQ@mail.gmail.com>
From: alex alex <duch.alexandre@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] [POSIX] [Question] Assigning task name before its
	creation
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

2013/1/15 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 01/15/2013 10:58 AM, alex alex wrote:
>
> > Hi all,
> >
> > My application run in the user-space and I use pthread_set_name_np() to
> > assign task name after having created my task.
> > However, I'd like my task name be assigned at the time of its creation I
> > read that it's possible in kernel space with
> > pthread_attr_setname_np<
> http://www.xenomai.org/documentation/trunk/html/api/group__posix__threadattr.html#ga4d48205cba54fed0c96dfc0d184b9f88
> >but
> > is it possible in user-space?
>
>
> No.
>
> --
>                                                                 Gilles.
>

Thanks.

Alex.
