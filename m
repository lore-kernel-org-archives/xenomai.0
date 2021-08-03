Subject: Re: kernel bug if rtnet device is accesses during unbind
References: <AS8PR05MB7720FBD018EBB5DED2B01962F6F09@AS8PR05MB7720.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <45907328-1596-7963-c0b7-5122d92d7881@siemens.com>
Date: Tue, 3 Aug 2021 18:04:20 +0200
MIME-Version: 1.0
In-Reply-To: <AS8PR05MB7720FBD018EBB5DED2B01962F6F09@AS8PR05MB7720.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 03.08.21 13:18, Lange Norbert via Xenomai wrote:
> Hello,
> 
> There is some bigger kernel oops when an rtnet device is unbound from
> linux but still accessible via ioctl.
> Effect and backtrace depends on timing, usually the rt_igb module will not
> decrease its reference count, and a following soft reboot might hang.
> 
> To repoduce, for example with rt_igb (doubt its driver specific):
> 
> echo "0000:01:00.0" > /sys/bus/pci/drivers/rt_igb/bind
> # rtifconfig has to run in background
> echo "0000:01:00.0" > /sys/bus/pci/drivers/rt_igb/unbind & rtifconfig rteth0 up
> 

So, running one after the other (rtifconfig up first) will not trigger
this? Then it would sounds like a race between rtnet or the driver
preventing the unbind and the ongoing ifup.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

