From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e0cc88bf-1fd8-1c01-513b-b7444b323da7@siemens.com>
Date: Fri, 6 Apr 2018 19:07:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] dlopen test in current stable fails
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>, Henning Schild <henning.schild@siemens.com>

Henning,

should dlopen work with stable-3.0.x? The test case is merged, but it
fails for me.

../../../lib/boilerplate/setup.c:686: __register_setup_call: Assertion
`!main_init_done' failed.

(at this chance I noticed that redirecting smokey outputs on the command
line does not work as well - different story).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

