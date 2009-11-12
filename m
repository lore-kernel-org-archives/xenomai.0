Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Fri, 13 Nov 2009 00:24:32 +0100
References: <200911101536.55579.leo@domain.hid>
	<200911110055.23162.berlemont.hauw@domain.hid>
	<200911121533.55248.leo@domain.hid>
In-Reply-To: <200911121533.55248.leo@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200911130024.32690.berlemont.hauw@domain.hid>
Subject: Re: [Xenomai-help] rtdm and comedi
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Leopold Palomo-Avellaneda <leo@domain.hid>
Cc: xenomai@xenomai.org

Hi, 

On Thursday 12 November 2009 15:33:54 Leopold Palomo-Avellaneda wrote:
> A Dimecres 11 Novembre 2009, Alexis Berlemont va escriure:
> > Hi,
> >
> > On Tuesday 10 November 2009 15:36:55 Leopold Palomo-Avellaneda wrote:
> > > Hi,
> > >
> > > I would like to ask about comedi and xenomai because I'm a bit lost
> > > with the situation in xenomai. I think that Alexis Berlemont did a
> > > branch of xenomai with support for some drivers from comedi in xenomai.
> >
> > We have the comedi core layer and the NI PCIMIO driver which are ported
> > to rtdm.
> 
> Ok.
> 
> > Concerning the branch you mentioned, if you speak about the comedi branch
> > on my git repository, you must have noticed that this branch is no more
> > active (I should remove it).
> > Comedi/RTDM was renamed as analogy, here is a mail which explains the
> > motivations.
> > https://mail.gna.org/public/xenomai-core/2009-09/msg00016.html
> 
> Ok, I read it. I was looking for it, but I didn't find it (probably my
>  fault, because I had it in my xenomai folder :-(
> 
> Reading again, following the links you mentioned and think about it
>  carefully and I think that yours mails, specially in the xenomai list and
>  comedi have not had the needed attention. And it's a pity.
> 
> Maybe I'm wrong, but comedi is a very good project and needed to people
>  that are working with acquisition of data from external sources. Comedi
>  also, have had some relevance, AFAIK in some project because work with
>  RTAI and rtlinux. I think that it's important (needed feature in most
>  cases) to have the determinist OS to measure devices. I have see that
>  people doesn't switch to xenomai from rtai because of comedi.
> 
> Also, my opinion is that you cannot compete against proprietary systems as
> labView if you don't have drivers in realtime to acquire data. In my field,
> the robotic area, for example, although we don't have a top high
>  requirements in realtime, a simple device, as a force sensor, it's
>  important (in some cases needed) to use it in realtime.
> 
> I don't know if I have understood all the threads in the several mail list,
> but it's a discouraging thing to work on something, that you think that
>  it's good to improve a project and not have fed back from upstream. Worst
>  is to distract you between lists .... In the case of the comedi project, I
>  have understand that it's moving to be integrated to the kernel tree, so
>  the realtime or it's used with the rt_preeemt patch or rtai and rtlinux or
>  you will not be able to use it, no? If it's true, I'm not sure if some
>  people are aware about it.
> 
> And about analogy, I don't understand quiet well what do you have in mind.
>  Are you trying to create a new project like comedi for xenomai with rtdm?
>
With Analogy, we are trying to provide a fully deterministic (from kernel 
space to user applications) framework for acquisition drivers. That is made 
possible thanks to the use of the RTDM skin provided by Xenomai.

Analogy is the evolution of Comedi within the Xenomai project, in other words, 
it looks like Comedi but we can take the liberty to make it evolve according 
to the user needs (users who needs an RTOS).

I hope that Analogy will allow people to use Xenomai in the robotic area and 
many other fields where real-time acquisitions are critical.

If you have any request / idea regarding this project, feel free to ask.

Regards,

Alexis.

