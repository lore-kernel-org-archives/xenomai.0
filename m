Subject: Re: Is anybody can show me a simple rtdm driver to read/write virtual
 memory device?
References: <CAAvDm6Zsm-gF+HwBLx1jo4-WHHu37_YoPGOTvgey3FVeWVCMWA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <03215306-db00-75ce-e473-3de10cb233e7@siemens.com>
Date: Mon, 6 Apr 2020 09:45:00 +0200
MIME-Version: 1.0
In-Reply-To: <CAAvDm6Zsm-gF+HwBLx1jo4-WHHu37_YoPGOTvgey3FVeWVCMWA@mail.gmail.com>
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

On 06.04.20 09:22, 孙世龙 via Xenomai wrote:
> Is anybody could show me a simple xenomai3 rtdm driver to read/write
> virtual memory device?
> A virtual memory device to:
>      write "hello world" to memory device in real real time(It's appricate
> if the write operation could wake up the read task which allready waited to
> read)
> read  the memory device in real time(It's appricate if the read operation
> could wake up the write task which allready waited to write)
> 

What do you mean with "virtual memory"?

If you are looking for a pattern how a driver implements read/write 
callbacks, maybe study the serial drivers. They come closest to "simple".

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

