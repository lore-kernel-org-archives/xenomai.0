References: <CADYdroNL-JicUU_p=GXy4_ZbR3TqBmbJxf8eoLuxn57tgWpmJA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <c9d39efe-12f6-e0a2-9bda-872b32eedb83@xenomai.org>
Date: Thu, 23 Nov 2017 12:18:57 +0100
MIME-Version: 1.0
In-Reply-To: <CADYdroNL-JicUU_p=GXy4_ZbR3TqBmbJxf8eoLuxn57tgWpmJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] Fix compilation of e1000,
 eepro100 and igp rtnet drivers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Norbert Lange <nolange79@gmail.com>, Xenomai <xenomai@xenomai.org>

On 11/21/2017 02:00 PM, Norbert Lange wrote:
> Hello,
> 
> enabling RTNet will result in compile failures, because there is a
> nameclash from some linux-headers.
> This patch fixes some intel NICs to compile

Merged, thanks.

-- 
Philippe.

