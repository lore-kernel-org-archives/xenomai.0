References: <CADYdroNL-JicUU_p=GXy4_ZbR3TqBmbJxf8eoLuxn57tgWpmJA@mail.gmail.com>
 <334d5994-9ee8-9d61-1020-3579665220e0@alaxarxa.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e7229d4d-0315-fc6d-7087-ad1e6f34e7f4@xenomai.org>
Date: Thu, 23 Nov 2017 12:25:38 +0100
MIME-Version: 1.0
In-Reply-To: <334d5994-9ee8-9d61-1020-3579665220e0@alaxarxa.net>
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
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, xenomai@xenomai.org

On 11/23/2017 08:29 AM, Leopold Palomo-Avellaneda wrote:
> On 21/11/17 14:00, Norbert Lange wrote:
>> Hello,
>>
>> enabling RTNet will result in compile failures, because there is a
>> nameclash from some linux-headers.
>> This patch fixes some intel NICs to compile
> 
> I have applied this patch and seems that works quiet well.
> 
> Philippe, is this a correct solution?
> 
> Could be applied the same for the rest of the drivers with the same problem?
> 

Yes, the fix makes sense. I merged it.

-- 
Philippe.

