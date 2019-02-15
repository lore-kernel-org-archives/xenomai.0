Subject: Re: Missing include/cobalt/kernel/rtdm/net.h in 3.0.8 tarball.
References: <CAOgDLiHxPvfY=7zUA-1nW-dP=kvbNRf_aogaFm5uuACUkKLTjw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bd95ce4e-a16f-d4b6-1ddf-1fa6022bc3ad@siemens.com>
Date: Fri, 15 Feb 2019 15:16:47 +0100
MIME-Version: 1.0
In-Reply-To: <CAOgDLiHxPvfY=7zUA-1nW-dP=kvbNRf_aogaFm5uuACUkKLTjw@mail.gmail.com>
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
To: Edouard Tisserant <edouard.tisserant@gmail.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 15.02.19 13:54, Edouard Tisserant via Xenomai wrote:
> Hi
> 
> Apparently, recently added include/cobalt/kernel/rtdm/net.h is missing
> in 3.0.8 tarball.
> 
> Steps to reproduce :
> 
> wget -q -O - https://gitlab.denx.de/Xenomai/xenomai/-/archive/v3.0.8/xenomai-v3.0.8.tar.gz
> | tar tz | grep include/cobalt/kernel/rtdm/net.h
> --> OK, file exist
> 
> wget -q -O - https://www.xenomai.org/downloads/xenomai/stable/xenomai-3.0.8.tar.bz2
> | tar tj | grep include/cobalt/kernel/rtdm/net.h
> --> Not OK ! File is missing
> 

Yeah, unfortunate regression of

https://gitlab.denx.de/Xenomai/xenomai/commit/e23d587156f138a8f9bff648e310427127a98cfc

(and corresponding master commit): We need net.h in 
include/cobalt/kernel/rtdm/Makefile.am, noinst_HEADERS.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

