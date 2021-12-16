Subject: Re: [PATCH 1/1] Added verbosity to serial driver.
References: <20211216074829.32236-1-ksmola51@gmail.com>
 <e5126b04-5f04-57bc-8450-e519e251b9a6@siemens.com>
 <CAC2JQehOUsbGFmnfuLxukomvN-vjPLqo9nPk3ws1_7e10yOEZw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4a09e1bb-ab4d-4ff7-77bf-8ffff6b23cbb@siemens.com>
Date: Thu, 16 Dec 2021 19:08:52 +0100
MIME-Version: 1.0
In-Reply-To: <CAC2JQehOUsbGFmnfuLxukomvN-vjPLqo9nPk3ws1_7e10yOEZw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
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
To: k smo <ksmola51@gmail.com>
Cc: xenomai@xenomai.org

On 16.12.21 18:40, k smo wrote:
> I will re-submit patch with a better explanation.  But look at this
> dmesg output:
> 
> [55025.834492] xeno_16550A: RTDM-based driver for 16550A UARTs rev
> 1.5.2, Jan Kiszka <jan.kiszka@web.de <mailto:jan.kiszka@web.de>>
> [55025.834568] xeno_16550A: rtser0 io=0x3f8 irq=4
> [55025.834614] xeno_16550A: rtser1 io=0x2f8 irq=3
> [55025.834646] xeno_16550A: rtser2 io=0xd000 irq=18
> [55025.834680] xeno_16550A: rtser3 io=0xd008 irq=18
> [55025.835322] xeno_16550A: rtser4 io=0xd010 irq=18
> [55025.836801] xeno_16550A: rtser5 io=0xd018 irq=18
> later...
> [55044.800713] xeno_16550A: Unloaded.
> 
> In our systems the serial driver is loaded by shell scripts and config
> files which make decisions as to what to load. so without verbosity the
> driver prints nothing and it is not easy to determine (in terms of
> timing relative to other drivers as seen in dmesg) if the driver ever
> got loaded or what ports it is listening to. This is highly informative
> verbosity.
> 

Ok, that makes sense and is similar to what the kernel tty drivers do. I
don't think it needs the very first line, though.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

