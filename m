MIME-Version: 1.0
From: danwe <daniel.wenninger92@gmail.com>
Date: Fri, 16 Aug 2019 10:17:58 +0200
Message-ID: <CAEmXcAzKYTm-ExSxnU6XDuD6evBb4S_=NDQFLO7N8d6V1dtU7A@mail.gmail.com>
Subject: Differences of Roundtrip time, latency between Xenomai 2 and Xenomai 3
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

I have made a comparison for Roundtrip time between Xenomai 2 / RTnet,
Xenomai 3 and Debian distribution. I would like to ask you some specific
questions as I am not sure.

1. I have read that Xenomai does work on Linux and the Interrupt Pipeline
does know which message is for real-time (Xenomai) and which not (Debian).
As I am copy Xenomai on a SD-Card am I just using real-time messages or is
it also possible to use non-real-time messages? Does Xenomai need Debian
distribution or can it work by itself?

2. I have seen some big difference in jitter between Xenomai 2 / RTnet and
Xenomai 3 without RTnet while testing the latency. Xenomai 3 does have a
much smaller jitter than Xenomai 2 / RTnet. Can you tell me where exactly
the difference come from?

3. I have also seen that the Roundtrip time for Xenomai 3 is twice the size
of Xenomai 2 / RTnet. So my question is: I thought that RTnet ist just for
synchronization and TDMA. Does RTnet also make it "more" real-time than
Xenomai 3 itself?

Kind regards

Daniel
