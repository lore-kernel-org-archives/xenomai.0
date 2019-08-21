MIME-Version: 1.0
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Wed, 21 Aug 2019 17:20:39 +0300
Message-ID: <CAPm8-H6txhsFDDepfGEG48S1anF03F1=tBsEiLfkRiPHi7KKxA@mail.gmail.com>
Subject: RTNet - vnic0 question
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hello rtnet community,

  I successfully tested the examples rtt-sender and rtt-responder
within a rtnet made from one beaglebone black and one qemu-x86_64-8139too,
with tdma and also with nomac.

  I have noted that the presence of vnic0 as an up and fully
configured interface is mandatory,
even if rteth0 is up and fully configured.
Otherwise the rtt-sender announces "sendto failed: Network is unreachable".
Could anybody tell me why is this happening?

  I have also noted that if I disable vnic0 (ifconfig vnic0 down),
rtping works if rteth0 is up and fully configured.
Why does not work rtt-sender in this case?
Could it be a problem with rtnet drivers?

Thank you and best regards,
L-C. Duca

