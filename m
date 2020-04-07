Subject: Re: Is anybody could tell me the relation between lib/boilerplate
 folder and lib/copperplate folder?
References: <CAAvDm6YRboO8XBz=b+M41Y2O=0CXqPK4aaM+0LhMkjv-yqV7Lw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <17678b7f-614a-d473-2067-83f403c4f7c5@siemens.com>
Date: Tue, 7 Apr 2020 11:59:48 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6YRboO8XBz=b+M41Y2O=0CXqPK4aaM+0LhMkjv-yqV7Lw@mail.gmail.com>
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
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>, xenomai@xenomai.org

On 07.04.20 11:40, 孙世龙 via Xenomai wrote:
> Is anybody could tell me the relation between lib/boilerplate and
> lib/copperplate?
> 
> I am using xenomai-v3.1.
> 
> Thanks a lot.Looking forward to your replay.
> 

libboilerplate: internal utility services, used across the board, also 
both by cobalt and mercury configurations.

libcopperplate: helper lib for non-posix skins (alchemy, vxworks etc.) 
to implement their services on top of cobalt or mercury core.

HTH,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

