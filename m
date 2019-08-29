Subject: Re: [PATCH 2/2] cobalt: switch hand over status to -ENODEV for
 non-RTDM fd
References: <20190620172934.31393-1-rpm@xenomai.org>
 <20190620172934.31393-3-rpm@xenomai.org>
 <VI1PR05MB5917F833764544DF7F3E666FF6A20@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5f37d7d4-d4bb-6473-dd1a-494bd0472c83@siemens.com>
Date: Thu, 29 Aug 2019 16:52:23 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB5917F833764544DF7F3E666FF6A20@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, Philippe Gerum <rpm@xenomai.org>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 29.08.19 16:12, Lange Norbert via Xenomai wrote:
> 
> I ran into a rather big issue with linux filehandles
> I use Xenomai master on ipipe-core-4.19.60-x86-5 with those patches,
> (can't be 100% sure its not some kernel/userspace conflict, but I doubt it)
> 
> What happens is that upon a __cobalt_close with a linux filehande, the
> syscall sc_cobalt_close returns EBADF, but that means the libc close will
> never be tried and filehandles are leaking like mad.
> 

Ah, good catch. Looks like Philippe's patch was missing a change to rtdm_fd_close().

Thanks a lot for testing pro-actively!

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

