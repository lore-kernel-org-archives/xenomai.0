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
Date: Tue, 23 Apr 2019 23:53:46 -0700
Message-ID: <CA+K1mPHHO516ziTro8541em4zycwj9pRDo5v-Dd88HQ49kUyXg@mail.gmail.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Steve Freyder <steve@freyder.net>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks very much Jan, I'll try your patch tomorrow.

In the meantime it may confirm your suspicions to hear this :
I hacked the xeno_16550A.c driver to poll the transmit buffer every time
there was an RX interrupt (I have a bidirectional application). If there
was any data waiting just call the TX interrupt routine again. Essentially:
if (ctx->out_npend > 0)
   rt_16550_tx_interrupt(ctx)
With this modified driver I was able to stream data successfully without
any stalls for 8+ hours. An oscilloscope showed there were only occasional
delays in sending the data, like an extra 800us.
That seems to confirm that the UART is still functioning OK at the hardware
level during the problem, it just needs to be "reminded" to transmit. Your
patch may be all it needs...

-C Smith
