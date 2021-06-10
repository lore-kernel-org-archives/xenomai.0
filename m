From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Dovetail: Possible boot issue on BeagleBone Black
Message-ID: <6caeb963-97fc-c858-8c89-6cafda765d9a@siemens.com>
Date: Thu, 10 Jun 2021 08:44:49 +0200
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Philippe,

seems we have some early boot problem with Dovetail on the BBB (while
qemu-arm is fine), see [1] vs. [2] (disabled Xenomai for [2], see [3]).
Do you happen to have such a target around? Or a reference config that
is supposed to work?

Jan

[1] https://source.denx.de/Xenomai/xenomai-images/-/jobs/277392#L444
[2] https://source.denx.de/Xenomai/xenomai-images/-/jobs/277821#L444
[3]
https://source.denx.de/Xenomai/xenomai-images/-/commit/d48c28a82f16b5141948f23cc5bce244217eda15

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

