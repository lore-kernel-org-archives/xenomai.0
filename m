Date: Wed, 14 Mar 2018 18:27:27 +0100 (CET)
From: Yann le Chevoir <yann.le-chevoir@etu.esisar.grenoble-inp.fr>
Message-ID: <247635384.10422957.1521048447821.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] kernel does not boot when ipipe tracer is activated
Reply-To: Yann le Chevoir <yann.le-chevoir@grenoble-inp.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, cperles@sepro-group.com

Hi,

I have the same problem C=C3=A9dric had in November.
@C=C3=A9dric, did you manage to activate ipipe-tracer on your iMX6?

Even with earlyprintk (menuconfig and bootargs), the
kernel hangs to "Starting kernel...".

I have an iMX6 too, my Kernel is 4.1.38.
The I-pipe patch 4.1.18 did not exactly fit. I finished to patch manually.

Given an example, I look at the 4.4.43 patch to edit ring_buffer.c and
reactivate ftrace as there was an error at compilation time.
Now, ftrace works.

Which files should I look closer to see if there is a bug in my patch?
Which files are used by the I-pipe debugging kernel option?

Thanks,

Regards,

Yann



>Hi,
>
>I=E2=80=99m working on an iMX6 based board with NXP kernel 4.1.15.
>Using cyclictest and dohell, I benched latency on my Xenomai + Preempt-rt
>kernel. To understand the results, I wanted to activate ftrace and
>ipipe-tracer.
>
>While ftrace activation was not a big deal, when "I-pipe debugging" is
>activated into menuconfig my kernel does not boot anymore and hangs to
>"Starting kernel ..."
>
>Did someone faced the same issue ?
>Is there a way to investigate
>
>Regards,
>
>C=C3=A9dric.

