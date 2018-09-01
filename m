MIME-Version: 1.0
References: <CAMDdWux5-RP3o6JmLOx-Wc3Se1q6ffyBarD7NueBLJP3X1ZPVw@mail.gmail.com>
In-Reply-To: <CAMDdWux5-RP3o6JmLOx-Wc3Se1q6ffyBarD7NueBLJP3X1ZPVw@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sat, 1 Sep 2018 00:12:04 -0400
Message-ID: <CALLqZ8Rs4HT6kXJ1JF+K78sgcNQAmK4i=dHkM0AmX0cib=X=Kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] how can I use the Xenomai functions in ROS1?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: lpinto.matheus@gmail.com
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

On Thu, Aug 30, 2018 at 2:32 PM Matheus Pinto <lpinto.matheus@gmail.com>
wrote:

> Hi everbody,
>
> I have my reasons for wanting to integrate ROS1 (Robot Operating System)
> with Xenomai.
>
> I would just like it to be possible to use the functions of ROS1 (create
> node, publish, subscribe, ...) within a real-time task (do not necessaril=
y
> guarantee predictability in ROS functions).
>

Not directly, I'd recommend using a framework like RTROS to achieve this.


> I created a question in ROS community for this subject:
>
>
> https://answers.ros.org/question/301491/how-can-i-use-the-xenomai-functio=
ns-in-ros/?comment=3D301568#post-id-301568
>
> But as guided by them it might be a good idea to ask the Xenomai communit=
y
> to help me.
>
> As can be seen in ROS community question, using a ROS function inside a
> task generate a runtime error:
>
>
> 'boost::exception_detail::clone_impl<boost::exception_detail::error_info_=
injector<boost::lock_error>
> >'
>       what():  boost: mutex lock failed in pthread_mutex_lock: Invalid
> argument
>     Aborted
>
>
>
 This could be an issue where non RT threads try to use RT resources, many
errors can be generated if care isn't taken when using RT and non RT
resources in the same process. or thread  Look at the presentation that the
ROS community linked in your question, using the RTROS framework you should
be able to achieve what  you are looking for.

By the way, the ROS library when trying to use a mutex function of
> libboost, causes the program to be terminated from within the task.  Does
> not Xenomai allow you to use other thread functions within a real-time
> task? If yes, how could I get around this problem?
>
>
Please look over the getting starting area of the Xenomai wiki.  It should
answer some of your questions.

thanks

Greg

--=20
> Atenciosamente*,*
>
> *Matheus Leitzke Pinto*
> Professor de Sistemas Embarcados
>
>
> *Campus Chapec=C3=B3*
> +55 (49) 33 13 12 44 <callto:+5549333131244>
>
> *Instituto Federal de Santa Catarina - Campus Chapec=C3=B3*
> Rua Nereu Ramos, 3450 D - Semin=C3=A1rio, Chapec=C3=B3 - SC, 89813-000
> <http://www.chapeco.ifsc.edu.br>www.chapeco.ifsc.edu.br
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>
