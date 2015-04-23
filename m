From: Biermans Joeri <joeri.biermans@student.uantwerpen.be>
Date: Thu, 23 Apr 2015 07:41:24 +0000
Message-ID: <1429774884371.77432@student.uantwerpen.be>
Content-Language: nl-NL
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Implementing a few scheduling policies on Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi everyone,


I'm a student at the university of Antwerp and I'm currently working on my

master's thesis. My thesis is about comparing the performance of several

real-time multicore scheduling algorithms on embedded systems such as EDF, =
EDF-US,

RM, RM-US and EDF(k).


I'm currently looking for a combination of a multicore embedded system if t=
he form

of a single board computer and an RTOS. I'm currently thinking of using a f=
reescale sabrelite

in combination with Xenomai.


Before making a descision there are a few things I have to know first:


  *   Would it be possible to implement these algorithms in Xenomai?
(Note that these are multicore algorithms)
  *   If yes: Could this be achieved in a reasonable amount of time?
  *   Is it possible to monitor the scheduling process of the tasks schedul=
ed?
(ie monitoring how many jobs are generated, how many deadlines are missed, =
when jobs are scheduled,
when they arrive, when they end, when they are interrupted etc.)


Thanks in advance.


Kind regards,

Joeri Biermans

