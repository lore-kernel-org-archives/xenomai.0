From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: dovetail: add prctl() call form
Message-ID: <5283f8ff-33bf-910d-25b5-044ea6a963ae@siemens.com>
Date: Mon, 8 Nov 2021 18:39:57 +0100
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

this dovetail commit makes the pipeline go red, crashing the kernels
(e.g. [1][2]). I hope this is something we can quickly fix in dovetail,
maybe via a config option?

Jan

[1] https://source.denx.de/Xenomai/xenomai-images/-/jobs/348118#L966
[2] https://source.denx.de/Xenomai/xenomai-images/-/jobs/348121#L1429

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

