MIME-Version: 1.0
From: Thiago Lima <thiagolims@domain.hid>
Date: Wed, 10 Jun 2009 19:41:34 +0000
Message-ID: <6a782b880906101241r50217294j937e03acb3303a86@domain.hid>
Content-Type: multipart/alternative; boundary=00151751104cdc1363046c03aa6d
Subject: [Xenomai-help] Extending RT_TASK | Container_of | Linux Kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--00151751104cdc1363046c03aa6d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I have created a structure that contains a RT_TASK:

typedef struct {
    RT_TASK task;
    char id;
    int c;
    int t;
    int d;
    int b;
    int prio;
} thread_qos;


I create a thread_qos and start its RT_TASK in Xenomai User Mode. Besides, i
have a linux kernel function that is called whenever a real time task starts
(i did this by applying a patch to xenomai kernel).
In this function, i get the current xnthread_t and use container_of to get
RT_TASK. But, when i use container_of (#define thread2threadqos(ln)
container_of(ln, thread_qos, task) to get thread_qos i cant get values
informed in user mode.

Do you realize what this could be ? If i create a thread_qos in kernel, my
macro is working perfectly.

Thanks for helping,
-- 
Thiago Lima Silva
Registered Linux user #466887

--00151751104cdc1363046c03aa6d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I have created a structure that contains a RT_TASK:<br><br>typedef struct {=
<br>=A0=A0=A0 RT_TASK task;<br>=A0=A0=A0 char id;<br>=A0=A0=A0 int c;<br>=
=A0=A0=A0 int t;<br>=A0=A0=A0 int d;<br>=A0=A0=A0 int b;<br>=A0=A0=A0 int p=
rio;<br>} thread_qos;<br><br><br>I create a thread_qos and start its RT_TAS=
K in Xenomai User Mode. Besides, i have a linux kernel function that is cal=
led whenever a real time task starts (i did this by applying a patch to xen=
omai kernel).<br>

In this function, i get the current xnthread_t and use container_of to get =
RT_TASK. But, when i use container_of (#define thread2threadqos(ln)=A0 cont=
ainer_of(ln, thread_qos, task) to get thread_qos i cant get values informed=
 in user mode. <br>

<br>Do you realize what this could be ? If i create a thread_qos in kernel,=
 my macro is working perfectly.<br><br>Thanks for helping,<br>-- <br>Thiago=
 Lima Silva<br>Registered Linux user #466887<br><br>

--00151751104cdc1363046c03aa6d--

