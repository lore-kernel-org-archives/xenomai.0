MIME-Version: 1.0
References: <CAMDdWux5-RP3o6JmLOx-Wc3Se1q6ffyBarD7NueBLJP3X1ZPVw@mail.gmail.com>
 <CALLqZ8Rs4HT6kXJ1JF+K78sgcNQAmK4i=dHkM0AmX0cib=X=Kw@mail.gmail.com>
In-Reply-To: <CALLqZ8Rs4HT6kXJ1JF+K78sgcNQAmK4i=dHkM0AmX0cib=X=Kw@mail.gmail.com>
From: Matheus Pinto <lpinto.matheus@gmail.com>
Date: Sat, 1 Sep 2018 11:34:47 -0300
Message-ID: <CAMDdWuzT0SsrZB+YkE8OFTOcGeWxeuDrEv0ZRqER9bh-FEg5FA@mail.gmail.com>
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
To: greg@embeddedgreg.com
Cc: xenomai@xenomai.org

Hi Greg,

This could be an issue where non RT threads try to use RT resources, many
> errors can be generated if care isn't taken when using RT and non RT
> resources in the same process. or thread  Look at the presentation that t=
he
> ROS community linked in your question, using the RTROS framework you shou=
ld
> be able to achieve what  you are looking for.
>

I looked at the video and got in touch with the presenters of this RTROS,
because the source code is not available in any place for download.
However, I got no response.

Also, through an internet search, it can be seen that there is an paper
about RTROS, but of other authors from a different university:
https://www.sciencedirect.com/science/article/pii/S0167739X15001831. The
source code is not available either.

Thanks

Em s=C3=A1b, 1 de set de 2018 =C3=A0s 01:12, Greg Gallagher <greg@embeddedg=
reg.com>
escreveu:

> Hi,
>
> On Thu, Aug 30, 2018 at 2:32 PM Matheus Pinto <lpinto.matheus@gmail.com>
> wrote:
>
>> Hi everbody,
>>
>> I have my reasons for wanting to integrate ROS1 (Robot Operating System)
>> with Xenomai.
>>
>> I would just like it to be possible to use the functions of ROS1 (create
>> node, publish, subscribe, ...) within a real-time task (do not necessari=
ly
>> guarantee predictability in ROS functions).
>>
>
> Not directly, I'd recommend using a framework like RTROS to achieve this.
>
>
>> I created a question in ROS community for this subject:
>>
>>
>> https://answers.ros.org/question/301491/how-can-i-use-the-xenomai-functi=
ons-in-ros/?comment=3D301568#post-id-301568
>>
>> But as guided by them it might be a good idea to ask the Xenomai communi=
ty
>> to help me.
>>
>> As can be seen in ROS community question, using a ROS function inside a
>> task generate a runtime error:
>>
>>
>> 'boost::exception_detail::clone_impl<boost::exception_detail::error_info=
_injector<boost::lock_error>
>> >'
>>       what():  boost: mutex lock failed in pthread_mutex_lock: Invalid
>> argument
>>     Aborted
>>
>>
>>
>  This could be an issue where non RT threads try to use RT resources, man=
y
> errors can be generated if care isn't taken when using RT and non RT
> resources in the same process. or thread  Look at the presentation that t=
he
> ROS community linked in your question, using the RTROS framework you shou=
ld
> be able to achieve what  you are looking for.
>
> By the way, the ROS library when trying to use a mutex function of
>> libboost, causes the program to be terminated from within the task.  Doe=
s
>> not Xenomai allow you to use other thread functions within a real-time
>> task? If yes, how could I get around this problem?
>>
>>
> Please look over the getting starting area of the Xenomai wiki.  It shoul=
d
> answer some of your questions.
>
> thanks
>
> Greg
>
> --
>> Atenciosamente*,*
>>
>> *Matheus Leitzke Pinto*
>> Professor de Sistemas Embarcados
>>
>>
>> *Campus Chapec=C3=B3*
>> +55 (49) 33 13 12 44 <callto:+5549333131244>
>>
>> *Instituto Federal de Santa Catarina - Campus Chapec=C3=B3*
>> Rua Nereu Ramos, 3450 D - Semin=C3=A1rio, Chapec=C3=B3 - SC, 89813-000
>> <http://www.chapeco.ifsc.edu.br>www.chapeco.ifsc.edu.br
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai
>>
>

--=20
Atenciosamente*,*

*Matheus Leitzke Pinto*
Professor de Sistemas Embarcados


*Campus Chapec=C3=B3*
+55 (49) 33 13 12 44 <callto:+5549333131244>

*Instituto Federal de Santa Catarina - Campus Chapec=C3=B3*
Rua Nereu Ramos, 3450 D - Semin=C3=A1rio, Chapec=C3=B3 - SC, 89813-000
<http://www.chapeco.ifsc.edu.br>www.chapeco.ifsc.edu.br
