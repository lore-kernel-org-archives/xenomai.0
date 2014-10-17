Message-ID: <5440EE83.5000905@xenomai.org>
Date: Fri, 17 Oct 2014 12:25:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1413464642.48297.YahooMailNeo@web141701.mail.bf1.yahoo.com>
 <20141016174309.GD30661@sisyphus.hd.free.fr>
 <1413540390.40452.YahooMailNeo@web141704.mail.bf1.yahoo.com>
In-Reply-To: <1413540390.40452.YahooMailNeo@web141704.mail.bf1.yahoo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] RTDM problem with Advantech PCM-3680I
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?UsOzYmVydCBNYXJj?= <rob_marc2003@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/17/2014 12:06 PM, Róbert Marc wrote:
> Hi Gilles,
> 
> I've looked into dmesg again. At around [ 4.554430] ADV-PCI-CAN: probe of 0000:01:04.0 failed with error -5. Might be this the problem? Tried to google this error code, no luck.

The complete sequence of messages is:
[    4.554273] ADV-PCI-CAN 0000:01:04.0: RTCAN Registering card
[    4.554300] ADV-PCI-CAN 0000:01:04.0: RTCAN detected Advantech PCI card at slot #4
[    4.554313] ADV-PCI-CAN: Initializing device 13fe:c002:c002
[    4.554330] ADV-PCI-CAN: base_addr=0001ef00 conf_addr=  (null) irq=16 ocr=0xfa cdr=0xc0
[    4.554375] rtcan: registered rtcan0
[    4.554390] Unregistering SJA1000 device rtcan0
[    4.554407] RTCAN: unregistered rtcan0


> 
> If somebody has a clue, or had similar issues with the driver let me know your ideas.
> 
> I run out of ideas to be honest with you.

Well you abandon a bit quickly, what about looking in the code where
these messages are printed, adding printks to understand the reasons 
for these messages?

> 
> One more thing what I can try is to disable the original can4linux driver. Will post the outcome.

Yes, you should not have two drivers for the same board.


-- 
                                                                Gilles.

