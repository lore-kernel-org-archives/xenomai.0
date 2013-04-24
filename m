MIME-Version: 1.0
Date: Wed, 24 Apr 2013 11:59:34 +0530
Message-ID: <CAH8NBSf+nbREqxMkYt_398z81f-TNRNMbUvm1OSQuk6AagngaQ@mail.gmail.com>
From: Srikanth C <srikanthc9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Spurious interrupt are raised with 2.6.1 xenomai patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hi,

Spurious interrupts are raised on 2.6.1 Xenomai patch
with Linux Kernel version 3.2.34

for every pci interrupt raise  there is one spurious interrupt also getting
raised.

Without Xenomai patch pci interrupts are working fine (Spurious interrupts
are not raised).


Thanks and Regards,
Srikanth
