From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ipipe 5.4-arm] WARNING: CPU: 0 PID: 1 at kernel/irq/chip.c:55
 irq_set_chip+0xc4/0xd4
Message-ID: <a7d0fed5-77f7-a20a-2d30-527dd8eca570@siemens.com>
Date: Sat, 6 Mar 2021 12:45:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: Xenomai <xenomai@xenomai.org>, Quirin Gylstorff <quirin.gylstorff@siemens.com>, "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>

Hi Greg,

the pipeline is getting greener again but I just ran into this new issue:

https://source.denx.de/Xenomai/xenomai-images/-/jobs/234340

Seen before?

Quirin, Florian, as we were discussing whether such a warning would be
caught already: this answers it. We just need to see it on the serial
console.

Jan

