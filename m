MIME-Version: 1.0
From: Leandro Bucci <guestleandro11@gmail.com>
Date: Sat, 2 Jan 2021 11:38:37 +0100
Message-ID: <CAFZ-hKgU4jY1BVU+zL8VFJ1icouqzU-KUJmUs+_rLcX_5Wd_Pg@mail.gmail.com>
Subject: CPU affinity and scheduler
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello and happy new year to all. I wanted to ask you in detail what this
line means:

isolcpus=0,1 xenomai.supported_cpus=0x3

I understand that 2 CPUs are isolated. (I'm working on a Raspberry). But in
what sense are they isolated? does it mean that if a xenomai Task runs on
one of the two CPUs it will never migrate to another CPU? instead what does
"xenomai supported CPU" mean? that only that CPU supports Xenomai? but then
why is CPU 3 not isolated?
