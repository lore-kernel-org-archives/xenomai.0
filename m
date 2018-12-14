MIME-Version: 1.0
References: <CAOuPNLj7oWkbq9jMNQD4WLp67hVbYO8gd2t-qKwYDTpa+OQrZA@mail.gmail.com>
 <f8edae00-ad7c-5191-e875-66c1aed6e968@xenomai.org>
In-Reply-To: <f8edae00-ad7c-5191-e875-66c1aed6e968@xenomai.org>
From: Pintu Agarwal <pintu.ping@gmail.com>
Date: Fri, 14 Dec 2018 19:01:31 +0530
Message-ID: <CAOuPNLia1ZRvwyUjtqEh2zqKniviQbH9VDtd+wiMG4sLDn4Uog@mail.gmail.com>
Subject: Re: ipipe-arm64 patches for qualcomm dragonboard 410c
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>, jro@xenomai.org

On Fri, Dec 14, 2018 at 2:48 PM Philippe Gerum <rpm@xenomai.org> wrote:
>
> On 12/13/18 12:13 PM, Pintu Agarwal wrote:
> > Dear Philippe,
> >
> > Currently I am working on Xenomai-3.0.6 bring up on QualComm Dragon
> > Board 410c using QualComm Linux Kernel 4.9.xxx
> >
> > First I wanted to know if this part already available.
> > So, for the initial search, I came across this:
> > - Download ipipe-jro-410c.linaro-15.07
> > - (From URL: http://git.xenomai.org/ipipe-jro.git/tag/?h=410c.linaro-15.07
> > - File name:     ipipe-jro-410c.linaro-15.07.tar.bz2  )
> >
> > But, I am not able to access these links.
>
> Check https://lab.xenomai.org/ipipe-jro.git/
>

Thank you so much. Yes I am able to clone this.
One question:
>From the ipipe repo, how can I prepare ipipe-arm64 patches that can be
applied to my Kernel using prepare-kernel.sh or normal patching?

> > It requires user name/password for sign-in.
> > Also the sign-up/register link is not available.
> > If you are aware about this, can you tell me how to access it?
> >
> > Also, I came  across this link:
> > https://discuss.96boards.org/t/dragonboard-for-real-time-robotics/3710
> > http://www.cs.technion.ac.il/~cs234313/projects_sites/S17/15/site/
> >
> > Xenomai installation Guide for Dragon 410c:
> > http://www.cs.technion.ac.il/~cs234313/projects_sites/S17/15/site/files/Install%20Xenomai%20on%20dragonboard%20410c%20guide.docx
> >
> > Is this means that Xenomai is already up in Dragon Board 410c?
> > Or in any other QualComm MSM chipset ?
> >
> >
>
> Jorge did that work. He is the right person to ask those questions to.
>
Okay Thanks.
Once I try some hands on, I will definitely contact Jorge for help.

> --
> Philippe.

