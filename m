MIME-Version: 1.0
References: <CA+K1mPFgaiP3fGFnd169MXhdRWo+a1TGz5fnEoj7MOCr11UbLQ@mail.gmail.com>
 <c6a9ba79-c7c5-195d-be1e-030fb44f5abc@siemens.com>
 <CA+K1mPEvKLN+gyDPwLE0OovtSn-iQ_BBZ86zQf12Fv65Ht5KbQ@mail.gmail.com>
 <2ade719a-84c7-c53d-9895-a5e6eea354a3@siemens.com>
 <CA+K1mPHhMrw-2t0k1_AgKE4iZ+2+Vvx7TV_ScHnOFis_sBxt=Q@mail.gmail.com>
 <5CBCCE3F.5090000@freyder.net>
 <CA+K1mPGZiuAvumxhdvKk2R=UvO9WwE_ppfkXeMaWLt7dP5hB3w@mail.gmail.com>
 <ebb4d71b-3d5b-9d66-270f-ca35e7785bce@web.de>
 <dccf6d29-e996-5c78-93fe-a74879270a44@siemens.com>
In-Reply-To: <dccf6d29-e996-5c78-93fe-a74879270a44@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Thu, 25 Apr 2019 00:15:05 -0700
Message-ID: <CA+K1mPHKN42HPMEjQ1aL+P_TjtDt6sUXy95xFRt=y_9qe9y7VQ@mail.gmail.com>
Subject: Re: rt_dev_send() stalls periodic task
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai List <xenomai@xenomai.org>
Cc: Steve Freyder <steve@freyder.net>, w1@codecraftsmen.org

Hi Jan,

Your patch worked somewhat but not completely. It prevents my app from
stalling forever, but I caugh the serial transmission itself stalling on
the oscilloscope for quite a long time. My 72 byte TX packet from the
xenomai periodic task gets cut in half and there is no transmission for
7msec, then the transmission resumes. (I'll send you a screenshot)
(Note that I am on xeno 2.6.5 so I merged your 3.x patch above into
16550A.c manually.)

I'm currently doing a 12 hour test of your patch plus mine. In my patch I
check during every RX interrupt to see if I need to call rt_16550_tx_fill()
too. I know that doesn't work for others but my traffic is full duplex so
this test will tell us something if it works and maybe we can ultimately
get the same behavior without my hack.

Also, I made the *.rx_timeout/.tx_timeout *change Jeff found, and it had
the obvious effect. I can make a patch for xeno 2.6.5 if you want. But I'll
point out that this fix may break peoples code functionally, so it may be a
bad idea to fix it on 2.x. Older code was written with a dependence on a
truly different timeout. It broke my app to fix this because there was
suddenly a new unexpected timeout. What's your policy on this issue?
