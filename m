Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B8B092E.1070104@domain.hid>
Date: Mon, 01 Mar 2010 01:24:14 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
References: <0C632A1C-3B64-462B-9892-380CB14F6AD8@domain.hid> <4B7DC07C.5@domain.hid>
	<6D7DAD32-5300-47EB-9A04-ECA065395014@domain.hid>
	<4B84634F.4080606@domain.hid>
In-Reply-To: <4B84634F.4080606@domain.hid>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Analogy DIO speed
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: Peter Pastor Sampedro <pastorsa@domain.hid>, xenomai@xenomai.org

Alexis Berlemont wrote:
> Hi,
> 
> Stefan Schaal wrote:
>> Hi Alexis,
>>
>> On Feb 18, 2010, at 14:34, Alexis Berlemont wrote:
>>
>>> I have some problems with
>>>> implementing commands on my NI6259 so far.
>>> Could you remind me what was the problem ?
>>
>> See the print-outs below for the problem we have.
>>
>> Thanks so much for looking into this!
>>
>> -Stefan
>>
>>
>>
>>
>> Using the cmd_write() function that you provide in analogy, we get the 
>> following problem:
>>
> I am currently trying to fix this bug, which is not that easy. I just
> have one question (that I remember I have already asked you in some way,
> but I just want to be sure):
> Does this bug occur the very first time you launched cmd_write (I mean
> after a reboot) ?
>
I managed at last to fix the bug you were facing (at least I hope so).
The problem was located in the trigger callback which waited for a
bit-status (fifo half full) before going further; however, sometimes the
DMA interrupt already occurred and cleaned everything behind your back.

I have not made a pull request because the current implementation is not
perfect.

If you have some time, could you clone my git repository (branch:
analogy) and check that a simple call to cmd_write does not trigger the
bug anymore ?

Many thanks.
>> root@domain.hid# ./cmd_write -v
>> cmd_write: device analogy0 opened (fd=0)
>> cmd_write: basic descriptor retrieved
>>      subdevices count = 14
>>      read subdevice index = 0
>>      write subdevice index = 1
>> cmd_write: complex descriptor retrieved
>> cmd_write: channel 0
>>      ranges count = 3
>>      range's size = 16 (bits)
>> cmd_write: channel 1
>>      ranges count = 3
>>      range's size = 16 (bits)
>> cmd_write: scan size = 4
>> cmd_write: size to write  = 400
>> cmd_write: command successfully sent
>> cmd_write: triggering failed (ret=-32)
>>
>> root@domain.hid# dmesg -c
>> [133345.213865] Analogy: analogy_ni_pcimio: ni_mio_common: interrupt: 
>> b_status=0002 m1_status=80a80000
>> [133345.332719] Analogy: analogy_ni_pcimio: ni_ao_wait_for_dma_load: 
>> timed out waiting for dma load<3>Analogy: a4l_do_special_insn: 
>> execution of the instruction failed (err=-32)
>>
>>
>> Another problem we have is with the --mmap option:
>>
>> root@domain.hid# ./cmd_write -v --mmap
>> cmd_write: device analogy0 opened (fd=0)
>> cmd_write: basic descriptor retrieved
>>      subdevices count = 14
>>      read subdevice index = 0
>>      write subdevice index = 1
>> cmd_write: complex descriptor retrieved
>> cmd_write: channel 0
>>      ranges count = 3
>>      range's size = 16 (bits)
>> cmd_write: channel 1
>>      ranges count = 3
>>      range's size = 16 (bits)
>> cmd_write: scan size = 4
>> cmd_write: size to write  = 400
>> cmd_write: buffer size = 65536 bytes
>> cmd_write: a4l_mmap() failed (ret=-22)
>>
>>
>> root@domain.hid# dmesg -c
>> [133408.942998] Analogy: a4l_ioctl_mmap: mmap not allowed on this 
>> subdevice
>>
>>
> 
> Alexis.
Alexis.

