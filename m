MIME-Version: 1.0
In-Reply-To: <201408291738.57701.paul_c@tuxcnc.org>
References: <CAEGbdifyuoCnxOnSfo7gXY0Ra1yUcJQY-7HXto5EvsjXEGXFNw@mail.gmail.com>
 <201408291738.57701.paul_c@tuxcnc.org>
Date: Fri, 29 Aug 2014 16:18:38 -0400
Message-ID: <CAEGbdifk+KmF+X8_qER1yVenG0Mi6DoeR2KvU=1R50=MfF6Uug@mail.gmail.com>
From: Matthew Lindner <mattlindn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Linux ATA driver issues and lockups
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul_c@tuxcnc.org>
Cc: xenomai@xenomai.org

On Fri, Aug 29, 2014 at 12:38 PM, Paul <paul_c@tuxcnc.org> wrote:
> On Thursday 28 August 2014, Matthew Lindner wrote:
>> We are using an Advantech-PCM9389 board running Linux 3.10.32 with
>> Xenomai 2.6.3. Regularly there is an error that occurs. Sometimes
>> operation continues as normal, sometimes the operating system freezes
>> (with no panic).
>  <snip>
>> Has anyone experienced things similar to this?
>>
>> Jul 29 04:34:09 delta kernel: ata1.00: exception Emask 0x0 SAct 0x0
>> SErr 0x0 action 0x6 frozen
>> Jul 29 04:34:09 delta kernel: ata1.00: BMDMA stat 0x24
>> Jul 29 04:34:09 delta kernel: ata1.00: failed command: WRITE DMA
>> Jul 29 04:34:09 delta kernel: ata1.00: cmd
>> ca/00:10:68:11:40/00:00:00:00:00/e0 tag 0 dma 8192 out
>> Jul 29 04:34:09 delta kernel:         res
>> 50/00:00:68:11:40/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
>> Jul 29 04:34:09 delta kernel: ata1.00: status: { DRDY }
>
> Experienced similar problems with a couple of drives, one an SD card (if
> that makes any difference). Replaced the drives with known good ones
> and the problem disappeared.
>
> What you may have is a drive that is in the early stages of failure. I'd
> recommend backing up any important data and replacing it. If you must
> use the old drive, save it for non-critical applications.
>
>
> Regards, Paul.


That's not it unfortunately. The board only uses CF cards and even
brand new cards (only a few weeks of use) see the problem. It's also
seen across cards. We're rather baffled by the issue. So far we've
seen it in our own compiled kernel (with minimal changes from a stock
Ubuntu kernel) but have not seen it on the stock Ubuntu kernel itself.

Matthew Lindner

