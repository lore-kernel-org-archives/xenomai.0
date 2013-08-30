MIME-Version: 1.0
In-Reply-To: <52207471.4020908@siemens.com>
References: <CAMZj-5M0tr1Mqc7w10gTnfBwkHnY7xq87NOxNtc4TiPuX2_cvA@mail.gmail.com>
	<521F409D.4070507@siemens.com>
	<CAMZj-5OASu0jYzT=7JXHjQxULUNhurOTC5RQqt2X=rU0wHMxTA@mail.gmail.com>
	<52204A62.7040005@siemens.com>
	<CAMZj-5NoALKD0KWzFYT-j3+hmcUKwnEYS61Gf4S2hoSMQEvX1Q@mail.gmail.com>
	<52207471.4020908@siemens.com>
Date: Fri, 30 Aug 2013 12:35:23 +0200
Message-ID: <CAMZj-5P5TE+W5=4k1fRE4ghaX4HQxEYLDaj3wU_1-cgP0+_ajw@mail.gmail.com>
From: Asier <atamayoarbide@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Virtualization with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

> You might be able to "steal" a Xenomai recipe from ELDK.
>

Thanks a lot ;-)

Asier


2013/8/30 Jan Kiszka <jan.kiszka@siemens.com>

> On 2013-08-30 12:22, Asier wrote:
> > Once again, thank you.Your last email was really helpful.
> >
> > If I understand it correctly, for my system it is better to use the KVM
> > approach, that is, leave the Xenomai Linux running on top of the HW and
> the
> > Windows on KVM. Though this solution may have some overhead, the
> real-time
> > behaviour will be the same as before. Am I correct?
>
> Yes, you are.
>
> > Or it can't be said for
> > sure?
> >
> > Regarding the Xenomai-aware Linux distributions, I'll have a look at the
> > debian packages for Xenomai. ELDK has no Intel support. I may consider
> > WindRiver Linux and Enea Linux, as well as using the Yocto tools
> themselves.
>
> You might be able to "steal" a Xenomai recipe from ELDK.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RTC ITP SES-DE
> Corporate Competence Center Embedded Linux
>
