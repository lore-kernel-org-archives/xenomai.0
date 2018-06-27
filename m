Message-ID: <1530093228.2487.22.camel@sprinte.eu>
From: Julien Blanc <julien.blanc@sprinte.eu>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 27 Jun 2018 11:53:48 +0200
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] rtcan loopback behaviour when physical device is in error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

With xenomai 3 (but i think the behaviour was the same with xenomai 2),
with loopback enabled, when there is no physical device on the bus, the
following happens :

* the messages fill the internal socket buffers. this result in any
blocking send call actually blocking the caller
* when this happens, this also block the loopback interface, since can
messages are only loopbacked if succesfully sent to the physical
interface.

We would like to change the behaviour in the following way :

* if the physical interface is in error, and there is a single client,
no change (ie, continue to block)
* if the physical interface is in error, but there are multiple clients
(ie, the loopback will be trigged), then :
  * discard the message from the physical interface
  * loopback the messages to the connected clients

We believe this is a more logical behaviour if each program working
with the rtcan is seen as a separate physical device -> the error of
one device should not compromise the communication between others,
while still remain the behaviour that if no one listens, then the
message cannot be sent.

This is a big change, and likely to break any code that rely on the
previous behaviour.

So, questions :

* has such a change any chance to reach mainline xenomai ? (we're gonna
do and provide the necessary patches)
* if so, should this behaviour be made optional ? The loopback property
could be changed from a single yes/no to a tri-valued easily in that
regard.

Thanks,

Julien

