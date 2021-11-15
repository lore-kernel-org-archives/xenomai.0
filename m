From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.2.1 released
Message-ID: <28213a1c-fa6f-25e7-29bb-3fd907859e23@siemens.com>
Date: Mon, 15 Nov 2021 09:06:38 +0100
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
To: Xenomai <xenomai@xenomai.org>

This is a quick stable update, required because Dovetail changed its API
and breaks Xenomai 3.2 when using the latest patches (which is strongly
recommended due to the important bug fixes they contain).

Changes since 3.2:

Jan Kiszka (1):
      config: Bump version number

Philippe Gerum (1):
      cobalt/syscall: dovetail: enable propagation from handle_oob_syscall()

Download available under
https://gitlab.denx.de/Xenomai/xenomai/-/archive/v3.1.1/xenomai-v3.2.1.tar.bz2

Thanks to all contributors!

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

