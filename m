MIME-Version: 1.0
From: Matheus Pinto <lpinto.matheus@gmail.com>
Date: Thu, 30 Aug 2018 15:32:18 -0300
Message-ID: <CAMDdWux5-RP3o6JmLOx-Wc3Se1q6ffyBarD7NueBLJP3X1ZPVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] how can I use the Xenomai functions in ROS1?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi everbody,

I have my reasons for wanting to integrate ROS1 (Robot Operating System)
with Xenomai.

I would just like it to be possible to use the functions of ROS1 (create
node, publish, subscribe, ...) within a real-time task (do not necessarily
guarantee predictability in ROS functions).

I created a question in ROS community for this subject:

https://answers.ros.org/question/301491/how-can-i-use-the-xenomai-functions=
-in-ros/?comment=3D301568#post-id-301568

But as guided by them it might be a good idea to ask the Xenomai community
to help me.

As can be seen in ROS community question, using a ROS function inside a
task generate a runtime error:

'boost::exception_detail::clone_impl<boost::exception_detail::error_info_in=
jector<boost::lock_error>
>'
      what():  boost: mutex lock failed in pthread_mutex_lock: Invalid argu=
ment
    Aborted


By the way, the ROS library when trying to use a mutex function of
libboost, causes the program to be terminated from within the task.  Does
not Xenomai allow you to use other thread functions within a real-time
task? If yes, how could I get around this problem?

--=20
Atenciosamente*,*

*Matheus Leitzke Pinto*
Professor de Sistemas Embarcados


*Campus Chapec=C3=B3*
+55 (49) 33 13 12 44 <callto:+5549333131244>

*Instituto Federal de Santa Catarina - Campus Chapec=C3=B3*
Rua Nereu Ramos, 3450 D - Semin=C3=A1rio, Chapec=C3=B3 - SC, 89813-000
<http://www.chapeco.ifsc.edu.br>www.chapeco.ifsc.edu.br
