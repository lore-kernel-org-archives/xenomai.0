MIME-Version: 1.0
From: Leandro Bucci <guestleandro11@gmail.com>
Date: Fri, 19 Feb 2021 16:33:01 +0100
Message-ID: <CAFZ-hKgw2hNEHshGnw4q7c3suT3wO_92P1pPw0o2e86Rn=Z2uA@mail.gmail.com>
Subject: real time serial communication
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

Hi.
I have Xenomai on the raspberry PI 3 B +. I would like to use the serial
port to make two raspberry (both with xenomai) communicate. If I use the
serial0 device everything works but I get huge latencies caused by the
modeswitches. I saw that it is possible to do serial communication even
using only the Xenomai domain. But I can't, in fact even the example in the
Demo folder, "cross-link", works and I get the error "can't open / dev /
rtdm / rtser0". The problem is that I certainly didn't insert the rtdm
module when compiling the kernel. Can I somehow fix it without having to
reinstall xenomai all over again?
Thanks for your help
