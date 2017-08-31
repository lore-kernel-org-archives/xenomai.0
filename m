From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <182a5ea9-8cde-2ded-0e8c-ff43fb98b2e4@siemens.com>
Date: Thu, 31 Aug 2017 19:33:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [RFC] Remove support for Blackfin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

it appears to me that the Blackfin architecture is no longer of broader
use, in general, and likely also in combination with Xenomai. At the
same time, it's "special" nature in several details makes maintaining
cross-arch changes complicated. And even without that, it's simply
another arch to look after in Xenomai, adding work and test efforts.

Therefore my proposal: schedule its removal from Xenomai support with
the next major release (I suppose that will be 3.1). At that point,
Blackfin should also be dropped from any port of the I-pipe patches to
newer kernel versions.

If you are using Blackfin with Xenomai or planning to do so, this would
be the time to speak up!

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

