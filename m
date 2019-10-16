Subject: Re: issue of hibernate for ipipe
References: <7f7c7a6a-ae0b-a95a-93ec-05940a109fc3@linx-info.com>
 <1830389674.1482147.1571212525654@mail.yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d09e3dbd-c507-f000-f07a-344b6b7603a6@siemens.com>
Date: Wed, 16 Oct 2019 19:29:13 +0200
MIME-Version: 1.0
In-Reply-To: <1830389674.1482147.1571212525654@mail.yahoo.com>
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
To: Alec Ari <neotheuser@ymail.com>, duanwujie <wjduan@linx-info.com>, Xenomai <xenomai@xenomai.org>

On 16.10.19 09:55, Alec Ari via Xenomai wrote:
> Hibernate/suspend/C-states etc generally cause problems with IPIPE. Best to not have any of that.

Indeed (at least hibernate and suspend). I remember having looked at
these paths only a long time ago (>10 years) when I was running Xenomai
for testing purposes on my notebook. And that was recurring effort.
Since then, likely no one cared.

We could declare the related config options as "depends on !IPIPE" to
avoid troubles.

Or do you have an actual use case for for hibernate, Wujie Duan?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

