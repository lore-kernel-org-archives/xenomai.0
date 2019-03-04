Subject: Re: net.h missing in 3.0.8 tarball release
References: <5c7a0de93fef_@_imoxion.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <52a41083-22ee-16e5-ca9a-761e852256a6@siemens.com>
Date: Mon, 4 Mar 2019 10:14:45 +0100
MIME-Version: 1.0
In-Reply-To: <5c7a0de93fef_@_imoxion.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?6rmA67OR7KeE?= <geniuskpj@kaist.ac.kr>, xenomai@xenomai.org

On 02.03.19 05:52, 김병진 via Xenomai wrote:
> i got tarball of 3.0.8 from this linkhttps://xenomai.org/downloads/xenomai/stable/xenomai-3.0.8.tar.bz2In this file, there is no 'net.h' in 'xenomai-3.0.8/include/cobalt/kernel/rtdm/'It makes some error when i build kernel.i checked 'include/rtdm/net.h'. but this is different from original one.Gitlab has 'net.h' in same path.https://gitlab.denx.de/Xenomai/xenomai/tree/v3.0.8/include/cobalt/kernel/rtdmSo is there someone to check this?
> 

This is a known issue of the release package, addressed by 
https://gitlab.denx.de/Xenomai/xenomai/commit/7c9032348eac6641f2bdbb691c77caa42f4bb70f, 
but that will only have effect in the next release. For this one, I would 
suggest importing the file from git or using a git snapshot directly.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

