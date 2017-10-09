From: Piotr Piorkowski <qba100@gmail.com>
Message-ID: <local-44d6e18d-7fee@nylas-mail.nylas.com>
Date: Mon, 09 Oct 2017 20:20:32 +0000
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Xenomai]  Creation of RTDM thread assigned to one CPU core
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai xenomai.org" <xenomai@xenomai.org>

   I would like to create a kernel module which would read data from A/D
   converter and buffor them in memory. The only idea that comes to my
   mind is creating a thread that would be assigned to one of processor's
   cores (Linux scheduler would not have access to this core) and constant
   data reading and bufforing.

   However I do not know how to assign the RTDM thread to a particular
   processor's core and whether this is a right approach to this issue.
   I tried to use function xnthread_migrate, however despite this function
   returns correct value, all of the system freezes. I would like to ask
   you for some ideas.
   With regards
   Piotr

   [018d5550fefb14a9765686e3d5d4e140660eb4d605e2ec0f3ad13fe86bde7634]
