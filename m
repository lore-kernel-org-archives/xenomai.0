From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: xenomai-images: Provide different kernel configs set for different
 purposes
Message-ID: <259fefaf-af09-2afb-fe7c-970b8c1300c3@siemens.com>
Date: Tue, 17 Nov 2020 18:51:14 +0100
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

Hi all,

just left this issue on
https://gitlab.denx.de/Xenomai/xenomai-images/-/issues/1:

For functional testing, IPIPE_DEBUG & Co. should be on (currently the
case for x86 and armhf, not for arm64).

For performance/latency testing and demonstration, debug switches should
be off.

However is familiar with xenomai-images already or would like to get it
AND has time, feel free to pick this up.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


