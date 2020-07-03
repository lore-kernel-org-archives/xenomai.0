MIME-Version: 1.0
From: Lakshmi Dhanaraj <lakshmi.d@teclever.com>
Date: Fri, 3 Jul 2020 18:53:48 +0530
Message-ID: <CAJCHRmGZaeqaf6GGVQSxBRL9j6LyVumHLf+ZJpDShy1sqpuaww@mail.gmail.com>
Subject: Doubts in RTDM Driver-reg
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

Hi,

I have a Reflective Memory 5565 hardware driver which is compiled in
xenomai-3.0.5(Linux-4.9.38+Ubuntu 18.04.1) & api functions are compiled
with xeno-config flags.

The api functions are communicated with the rfm2g driver using ioctl
calls.Now my doubt is the driver calls are forwarded to xenomai kernel or
generic kernel.Is there any necessity to recompile my driver with RTDM
wrapper for real-time access.

Awaiting your response




With Thanks & Regards,

Lakshmi.D

[image: Mailtrack]
<https://mailtrack.io?utm_source=gmail&utm_medium=signature&utm_campaign=signaturevirality5&>
Sender
notified by
Mailtrack
<https://mailtrack.io?utm_source=gmail&utm_medium=signature&utm_campaign=signaturevirality5&>
03/07/20,
18:45:43
