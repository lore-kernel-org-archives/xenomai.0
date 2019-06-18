From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Preview: 4.19-x86 support
Message-ID: <4a035faa-d1f8-d2ed-9351-192cea2d79eb@siemens.com>
Date: Tue, 18 Jun 2019 18:37:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
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

@all early adopters: There is a first version of upcoming x86 support based on 
the 4.19 kernel available at [1]. You need Xenomai master for it. The kernel 
should boot and run Xenomai workload fine - at least it does here so far. I only 
see one lockdep splat during early boot that needs to be sorted out. Possibly 
just an instrumentation issue, not a real problem. For the first release, 
cleaning up the series and adding latest 4.19 support are on my to-do list.

Early test reports appreciated!

Jan

[1] https://gitlab.denx.de/Xenomai/ipipe-x86/commits/wip/ipipe-x86-4.19.y

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

