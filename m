Subject: Re: Segmentation error 6 in rt_heap_create() without --enable-pshared
References: <20181105120636.B8E60FC0@centrum.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f5430687-f110-0973-3de6-5ede3acb79c7@siemens.com>
Date: Mon, 5 Nov 2018 12:10:12 +0100
MIME-Version: 1.0
In-Reply-To: <20181105120636.B8E60FC0@centrum.cz>
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
To: =?UTF-8?Q?Petr_=c4=8cervenka?= <grugh@centrum.cz>, Xenomai <xenomai@xenomai.org>

On 05.11.18 12:06, Petr Červenka via Xenomai wrote:
> Hello.
> I'm continuing to test newest Xenomai (git clone).
> If I configure Xenomai without --enable-pshared, I will always get an segmentation error 6 in rt_heap_create() call. It doesn't matter, if I use NULL as heap name or not.
> With --enable-pshared everything works fine.

stable or master (or both)?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

