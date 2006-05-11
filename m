Message-ID: <4546494d0605110704k32c1e7c8qa7d1f1dbbf23ceb5@domain.hid>
Date: Thu, 11 May 2006 22:04:00 +0800
From: "Li Yi (Adam)" <liyiadam@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3786_6005835.1147356240818"
Subject: [Xenomai-help] Some basic questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

------=_Part_3786_6005835.1147356240818
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I have been getting touch with Xenomai for some time, but I still has some
basic confusions (and I think these questions may be common for new users
starting to write real-time application using Xenomai).

1. If my real-time task want to access the HW resource, like DMA, memory,
Network,etc, does the task has to access through Linux kernel service of
allocating DMA or allocating memory, etc. Xenomai itself does not provide H=
W
management services, except interrupt and timer. But by using Linux kernel
service, the task may suffer from the non-determinstic (non-preemptive) of
Linux kernel? Is there any solution for this?

2. When writing a real-time task dealing with HW (that is, a real-time
driver), is the RTDM the prefered interface to use? If I am to make an
existing linux driver (for example, an A/D converter driver) real-time, and
I don't want to change the code a lot, beside RTDM, what other Xenomai
service (API) can I use?

3. Does it make sense that I start a real-time task using the Xenomai nativ=
e
API, while the task calling into Linux network stack (e.g, open a TCP
socket)? Since the Linux network stack is not determinstic, the result is
the same as I start a normal real-time linux task with SCHED_FIFO or
SCHED_RR, that is, the task can be only soft-rt?

4. To create a task to be fully determinstic, I need to make sure the task
running in Xonomai domain. When the task need to acess HW, it should not us=
e
Linux service. Is that right?

5. What is the scheduling policy for Xenomai rt task? SCHED_RR or
SCHED_FIFO? Sorry I did not found it in the document.

6. And finally a question specific to Blackfin: What is the purpose of
starting a kernel thread for each interrupt handler in Linux kernel?

Sorry about so many questions and many thanks in advance!

-Li Yi

------=_Part_3786_6005835.1147356240818
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br><br>I have been getting touch with Xenomai for some time, but I stil=
l has some basic confusions (and I think these questions may be common for =
new users starting to write real-time application using Xenomai).<br><br>
1. If my real-time task want to access the HW resource, like DMA, memory, N=
etwork,etc, does the task has to access through Linux kernel service of all=
ocating DMA or allocating memory, etc. Xenomai itself does not provide HW m=
anagement services, except interrupt and timer. But by using Linux kernel s=
ervice, the task may suffer from the non-determinstic (non-preemptive) of L=
inux kernel? Is there any solution for this?
<br><br>2. When writing a real-time task dealing with HW (that is, a real-t=
ime driver), is the RTDM the prefered interface to use? If I am to make an =
existing linux driver (for example, an A/D converter driver) real-time, and=
 I don't want to change the code a lot, beside RTDM, what other Xenomai ser=
vice (API) can I use?
<br><br>3. Does it make sense that I start a real-time task using the Xenom=
ai native API, while the task calling into Linux network stack (e.g, open a=
 TCP socket)? Since the Linux network stack is not determinstic, the result=
 is the same as I start a normal real-time linux task with SCHED_FIFO or SC=
HED_RR, that is, the task can be only soft-rt?
<br><br>4. To create a task to be fully determinstic, I need to make sure t=
he task running in Xonomai domain. When the task need to acess HW, it shoul=
d not use Linux service. Is that right?<br><br>5. What is the scheduling po=
licy for Xenomai rt task? SCHED_RR or SCHED_FIFO? Sorry I did not found it =
in the document.
<br><br>6. And finally a question specific to Blackfin: What is the purpose=
 of starting a kernel thread for each interrupt handler in Linux kernel?<br=
><br>Sorry about so many questions and many thanks in advance!<br><br>-Li Y=
i
<br><br><br><br><br>

------=_Part_3786_6005835.1147356240818--

