Subject: Re: [Xenomai] ipipe-4.14: planned release date
References: <CAA3JOdZuwus7K4kNBWkQiEWGRMQ6YGwYVEsDwX+W0xoV0SWinA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c09c2b4d-e3ab-177f-c61e-589dc1931f3b@siemens.com>
Date: Wed, 27 Mar 2019 11:10:33 +0100
MIME-Version: 1.0
In-Reply-To: <CAA3JOdZuwus7K4kNBWkQiEWGRMQ6YGwYVEsDwX+W0xoV0SWinA@mail.gmail.com>
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
To: Virendra Kate <virendrakate@gmail.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>, MSchrenkhammer@data-modul.com, henning.schild@siemens.com

On 25.03.19 21:09, Virendra Kate wrote:
> Hi Martin, Jan and Henning,
> 
> Did you all get an update on this issue ? Was it resolved after all? I have the 
> exact same hardware with the exact same issue. The board keeps resetting after 
> "Loading initial ramdisk..."
> 
> My Setup is as follows:
> ipipe version: ipipe-core-4.14.89-x86-2
> Linux-kernel version: linux-4.14.89
> xenomai version: xenomai-3.0.8
> Hardware: AMD® Ryzen embedded v1756b
> 
> The board works fine with Linux kernel 3.9.146 patched with the appropriate 
> xenomai-ipipe files. I would like to move to linux-kernel_4.14 as the GPU driver 
> is officially supported by AMD for linux-kernel_4.14.
> 

No direct progress regarding Ryzen, but I will try to glue together a new 4.14 
version if pending patches soon so that you can try if that happens to help. 
Will let you know.

Unfortunately, I don't have direct access to a Ryzen target ATM in order to 
debug the issue myself.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

