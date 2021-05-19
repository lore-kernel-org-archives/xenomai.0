From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: y2038 dependency to wip/dovetail
Message-ID: <d9592ffe-9cd8-34dd-1101-fed34aeb49ac@siemens.com>
Date: Wed, 19 May 2021 17:34:52 +0200
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Song Chen <chensong_2000@189.cn>

Hi Jan,

as already mentioned this morning during Xenomai community call, the
y2038 stuff has one more dependency that is not in next yet:

We need this commit from wip/dovetail:

336f9d67e5a4 ("lib/cobalt: dovetail: use clock_gettime() vcall for reading timestamps")

That's it for now.

Best regards,
Florian

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

