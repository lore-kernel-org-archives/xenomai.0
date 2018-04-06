MIME-Version: 1.0
In-Reply-To: <CALLqZ8SoRLCMVuPM7Q_AoUSWUT=QxE1krXy_djUZhZDrPtTFEw@mail.gmail.com>
References: <CA+K1mPGTJBd5OmUUhCcLVJMaHPhrwDgO34xtP6gG6qCvvw2BOw@mail.gmail.com>
 <CALLqZ8SoRLCMVuPM7Q_AoUSWUT=QxE1krXy_djUZhZDrPtTFEw@mail.gmail.com>
From: C Smith <csmithquestions@gmail.com>
Date: Fri, 6 Apr 2018 10:01:57 -0700
Message-ID: <CA+K1mPHAhOt8mKMm_yDudnZxpT96N9g5+m5VCpZ09-wy2cV5VQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Context switch to secondary mode in xenomai tasks
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, xenomai@xenomai.org

The tasks manipulate shared data however they do not communicate directly.
The rt_task which parses the xml document and the main rt_task are running
periodically at different rates using rt_task_set_periodic.

On Fri, Apr 6, 2018 at 9:54 AM, Greg Gallagher <greg@embeddedgreg.com>
wrote:

> Do the tasks communicate with each other?
>
> -Greg
>
> On Fri, Apr 6, 2018 at 12:51 PM, C Smith <csmithquestions@gmail.com>
> wrote:
> > Hi all--
> >
> > Our real time application has a main rt_task which runs concurrently with
> > several other rt_tasks (spawned using rt_task_create) and we are
> concerned
> > about a context switch in one of the tasks. The problematic task uses
> > libxml2 to parse an xml document sent over ethernet which seems to cause
> a
> > switch to secondary mode. Would this also switch the other tasks we are
> > running to secondary mode, or is it isolated?
> >
> > We are running Xenomai 2.6.2 and Xenomai 2.6.5 in our application.
> > _______________________________________________
> > Xenomai mailing list
> > Xenomai@xenomai.org
> > https://xenomai.org/mailman/listinfo/xenomai
>
