MIME-Version: 1.0
In-Reply-To: <CA+K1mPGTJBd5OmUUhCcLVJMaHPhrwDgO34xtP6gG6qCvvw2BOw@mail.gmail.com>
References: <CA+K1mPGTJBd5OmUUhCcLVJMaHPhrwDgO34xtP6gG6qCvvw2BOw@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Fri, 6 Apr 2018 12:54:35 -0400
Message-ID: <CALLqZ8SoRLCMVuPM7Q_AoUSWUT=QxE1krXy_djUZhZDrPtTFEw@mail.gmail.com>
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
To: C Smith <csmithquestions@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Do the tasks communicate with each other?

-Greg

On Fri, Apr 6, 2018 at 12:51 PM, C Smith <csmithquestions@gmail.com> wrote:
> Hi all--
>
> Our real time application has a main rt_task which runs concurrently with
> several other rt_tasks (spawned using rt_task_create) and we are concerned
> about a context switch in one of the tasks. The problematic task uses
> libxml2 to parse an xml document sent over ethernet which seems to cause a
> switch to secondary mode. Would this also switch the other tasks we are
> running to secondary mode, or is it isolated?
>
> We are running Xenomai 2.6.2 and Xenomai 2.6.5 in our application.
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

