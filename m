MIME-Version: 1.0
References: <CA+K1mPFgaiP3fGFnd169MXhdRWo+a1TGz5fnEoj7MOCr11UbLQ@mail.gmail.com>
 <c6a9ba79-c7c5-195d-be1e-030fb44f5abc@siemens.com>
 <CA+K1mPEvKLN+gyDPwLE0OovtSn-iQ_BBZ86zQf12Fv65Ht5KbQ@mail.gmail.com>
 <2ade719a-84c7-c53d-9895-a5e6eea354a3@siemens.com>
 <CA+K1mPHhMrw-2t0k1_AgKE4iZ+2+Vvx7TV_ScHnOFis_sBxt=Q@mail.gmail.com>
 <5CBCCE3F.5090000@freyder.net>
 <CA+K1mPGZiuAvumxhdvKk2R=UvO9WwE_ppfkXeMaWLt7dP5hB3w@mail.gmail.com>
 <ebb4d71b-3d5b-9d66-270f-ca35e7785bce@web.de> <5CBE1B46.3050804@freyder.net>
 <5CBE2AFC.2050105@freyder.net>
In-Reply-To: <5CBE2AFC.2050105@freyder.net>
From: C Smith <csmithquestions@gmail.com>
Date: Mon, 22 Apr 2019 15:56:19 -0700
Message-ID: <CA+K1mPHu1d3dbDdTLdgutBmbFV72PGLXS-H0c9MUc6XfypsXyw@mail.gmail.com>
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
To: Steve Freyder <steve@freyder.net>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Please don't think the cross-link.c app config has the magic answer.
Changing RX timeouts to prevent TX stalls would be an open loop hack that
might fail the serial traffic jitters differently.   The most suspicious
difference between the two apps is that : cross-link.c behaves very
regularly in terms of timing, because it receives its own transmissions.
My app receives packets from another computer asynchronously (full duplex).
So there is likely a random timing anomaly causing the problem.  Any
properly working UART and driver should be able to handle this, National
Semiconductor would say. But I have a strange serial port, and it is
tricking the xeno_16550A driver.

Jan alluded to a buffer-filling race condition in his comment.
I also fear that Receive interrupt handlers are somehow clearing Transmit
interrupts?

I didn't look at the stack trace when my app hung at startup due to that
infinite RX config. BTW there was no serial traffic whatsover during this
hang. I could try it again and look at the stack...
Also, it would be too hard to rewrite my apps to send single bytes. Its two
computers, rigid packet protocols & CRCs etc. Lots and lots of code. Thats
why I did that test app.

-C Smith
