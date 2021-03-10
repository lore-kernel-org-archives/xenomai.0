From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: dovetail: ia32 emulation broken
Message-ID: <d752faca-a518-793d-9a39-67f610ca9a92@siemens.com>
Date: Wed, 10 Mar 2021 09:32:59 +0100
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
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

Hi Philippe,

as already reported in the call today: Current dovetail, namely [1],
does not take the different argument mappings into account when entering
from a 32-bit app.

I-pipe has [2] in the arch-specific path to achieve that, but Dovetail
hooks into the generic path - too late for that. As a quick solution, I
would simply move the hooks into arch-specific code but I'm not sure if
that is best. Any suggestions?

Jan

[1]
https://git.evlproject.org/linux-evl.git/commit/?h=dovetail/master&id=4068dfd130ae0a1d10f88a7ea3be2c2e867e7ec1
[2]
https://source.denx.de/Xenomai/ipipe-x86/-/commit/114efa7b187e1e6702c0d2e208ac6b12c4d7b846#e9c562ce16c44dcda4bab48966c6bd5eafa9e811_320_346

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

