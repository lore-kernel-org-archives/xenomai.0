Subject: Re: Fix of long size in port bitmap index
References: <CAG6b3EpL6OZcHgOR8o--Frr51e7tDYgwDGs9+L7xUh48sTpoSQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <23bf2dcc-8881-59b4-d146-0d365bd99c8f@siemens.com>
Date: Wed, 19 Feb 2020 09:57:10 +0100
MIME-Version: 1.0
In-Reply-To: <CAG6b3EpL6OZcHgOR8o--Frr51e7tDYgwDGs9+L7xUh48sTpoSQ@mail.gmail.com>
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
To: =?UTF-8?B?TWF0w7rFoSBPbGVrxaHDoWs=?= <oleksak.matus@gmail.com>, xenomai@xenomai.org

On 18.02.20 18:19, Matúš Olekšák via Xenomai wrote:
> Hi,
> I am running xenomai application on 64bit Linux and I had to increase
> RT_UDP_SOCKETS to 128 and I discovered that my application started to
> behave strangely. I have done some debugging and I discovered that in
> function rt_udp_socket you presume that all systems have 32 bit long. Which
> is not true on x86_64 and you are rewriting other values because of wrong
> index. So I suggest to replace constant 32 with BITS_PER_LONG, so that all
> systems will have the right value. Patch is attached to this email. Also
> this is my first contribution to xenomai, so I am not sure if this is
> correct way.

Good catch! Could you send a patch according to CONTRIBUTING.md, 
specifically one with proper subject, issue description (including a 
hint that this didn't bite yet due to RT_UDP_SOCKETS = 64) and the 
signed-off line?

TIA!
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

