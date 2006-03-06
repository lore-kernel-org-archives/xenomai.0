Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 6 Mar 2006 10:42:42 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A2066F6@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
Subject: [Xenomai-core] Fundamental Questions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Dear Gurus,

I have 2 fundamental questions and I appologize in advance to burden you =
with more answering jobs stealing your precious development time, but at =
least the first question is crutial to our project.

1.)
Essentially the question deals with the problem, how long a Xenomai task =
in secondary mode can be delayed by normal Linux tasks.=20
In detail : we plan to to have a lot of "near realtime" ethernet =
communication from within Xenomai using the normal Linux network stack =
(calling the normal socket API). The question now is, how our network =
communication is influenced by other Linux tasks performing also network =
communication, let=B4s say an FTP transfer ?
(I have heard about RT-Net, but as far as I understand it needs its own =
realtime domain and therefore a gateway to communicate with the outside =
world. We want to avoid this.)

I have created a scheduling scenario and I would ask you to have a look =
on it and to tell me whether it is correct or not. Thank you !
An corresponding question about this scheduling is : are there =
differences between a 2.4 and 2.6 Linux kernel ? (for our PowerPC =
plattform we intend to use the 2.4 kernel for performance reasons)

Scheduling scenario :
(I hope formating is not destroyed by email transfer)

Time moves downwards

v-Xenomai=20
     v-Linux kernel
          v-Linux processes

          l1   Linux task1 running
     s1 < l1   Linux task1 makes systemcall
     s1        Linux task1 systemcall processed
-------------  Linux scheduling  =20
          l2   Linux task2 starts to run
     s2 < l2   Linux task2 makes systemcall
     s2        Linux task2 systemcall processed
+++++++++++++  Xenomai scheduling
x3             Xenomai task3 starts to run =3D> primary mode
x3 > s3        Xenomai task3 makes systemcall =3D> secondary mode
     s3        Xenomai task3 systemcall processed=20
-------------  Linux scheduling =3D> Xenomai task preemted
     s1        Linux task1 systemcall processed
     s1 > l1   Linux task1 systemcall ready =3D> Linux task1 continues=20
          l1   Linux task1 continues
-------------  Linux scheduling=20
     s2        Linux task2 systemcall processed
     s2 > l2   Linux task2 systemcall ready =3D> Linux task2 continues=20
          l2   Linux task2 continues
-------------  Linux scheduling =3D> Xenomai Task3 systemcall continued
     s3        Xenomai Task3 systemcall continued
x3 < s3        Xenomai Task3 systemcall ready =3D> Xenomai Task =
contiunes
x3             but has been delayed by normal Linux tasks


2.)
This question is not so crucial, but nevertheless interesting :
Who are the people behind Xenomai (I did not find anything about this on =
the Xenomai webpage), what is their background (University, Company)and =
who impels /sponsors the Xenomai development (University, Company, =
Community)?=20
I think I "identified" at least 2 core developers : Philippe Gerum and =
Gilles Chanteperdrix, but I don=B4t know very much more.
The background for this question is, to get a feeling, how future-proof =
the xenomai development is. As far as I can see open source projects =
often die or stall when the initiators decide that "growing flowers" is =
a much more pleasant job ;-).


Thank you for taking time to answer these questions, which are =
interesting to others too, I think !?

Best Regards
Roderik




