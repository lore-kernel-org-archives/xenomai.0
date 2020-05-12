MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Tue, 12 May 2020 10:16:17 +0800
Message-ID: <CAAvDm6bKxtaf-xg5bM+SGgt39CrTh94chO9rfs-NuAO4nwPx3w@mail.gmail.com>
Subject: =?UTF-8?Q?When_the_linux_process_could_recieve_the_message_tra?=
 =?UTF-8?Q?nsport_through_XDDP=EF=BC=9F?=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi,
     As i am using XDDP to transport messages bettween the head domain and
linux domain(i mean there are two processes, one is rt process, the other
is linux process.),I wonder that when the linux process could recieve the
message=EF=BC=9F
     *Will ADOES wake up the related linux process at once when the head
domain write something to the XDDP node?* Or, the linux process has to wait
for the schedule of linux kernel, if the processor is busy, it may wait for
a long long time.

     Thank you for your attention.
     Looking forward to hearing from you.
