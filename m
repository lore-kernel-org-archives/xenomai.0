From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: "rtdm/nrtsig: move inband work description off the stack"
Message-ID: <2098c9e4-4fb1-ef49-2c2d-d2c6573499b5@siemens.com>
Date: Tue, 25 May 2021 09:35:46 +0200
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

[1] makes rtdm_schedule_nrt_work a rather heavyweight service, compared
to what it was (and even over I-pipe). xnmalloc is nothing you would
expect from a "send a signal" service, specifically from
rtdm_nrtsig_pend which does not even make use of the sending extra payload.

Can we do better? Also for xnthread_signal (fd and udd usecases are not
time-sensitive anyway).

Jan

[1]
https://source.denx.de/Xenomai/xenomai/-/commit/572049132a04fc1bd217b87598af7c0ba8711c18

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

