MIME-Version: 1.0
Reply-To: mophong@gmail.com
From: Ho Tam <mophong@gmail.com>
Date: Wed, 10 Mar 2021 15:37:13 +0700
Message-ID: <CAK+-5=+tXRxm0E3kadiqp9oNuS_R8e+PMsomAuRux2X-xi9gRQ@mail.gmail.com>
Subject: Xenomai 3 on x86_64: system halted when running two realtime
 processes on same CPU core
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

Hello,
I am encountering a strange situation. I have an application containing an
Xenomai task. When I run this application and at the same time start the
latency test. If my Xenomai task and latency task run on the same CPU core,
after a few minutes the whole system is halted. In case I do CPU affinity
to move my Xenomai task to another CPU core, it works fine (I have kept it
running continuously for 2 days without problem).
I have repeated this test with several kernel and Xenomai versions (kernel
4.4, 4.14, 4.19, Xenomai 3.0.8, 3.0.9, 3.1, xenomai-next) and obtained the
same result.
I have used Xenomai 2 for several years and have never seen such a
situation. Is this Xenomai 3 issue or a problem with my kernel
configuration?
Thanks for any help!
--
