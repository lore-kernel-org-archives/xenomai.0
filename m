References: <CAOuPNLjTo8E7z=11ip8Dtjvt2dm=PU-+9urgwn8qgYCEcyxmMQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <75d25b2f-e82b-d7ab-da1f-48192862a5af@siemens.com>
Date: Mon, 26 Feb 2018 15:24:48 +0100
MIME-Version: 1.0
In-Reply-To: <CAOuPNLjTo8E7z=11ip8Dtjvt2dm=PU-+9urgwn8qgYCEcyxmMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RTDM] Converting existing Linux char driver to rtdm
	driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pintu Kumar <pintu.ping@gmail.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 2018-02-26 12:26, Pintu Kumar wrote:
> Hi,
> 
> I have a sample linux char driver which I am registering using normal
> misc_register/deregister function.
> In this driver, I have used, open, read, write, ioctl, release system calls.
> 
> Now I wanted to convert this driver to RTDM interface and compare it.
> Later I wanted to add some more use cases related to interrupt
> processing by connecting some external peripheral.
> 
> Firstly, please guide me how to easily convert an existing linux char
> driver to RTDM model.
> 

Conversion of existing Linux UART drivers to RTDM is not straightforward
as the former relies on a larger hierarchy of Linux drivers, starting
with the tty core over the serial core and possibly some chip
abstractions (8250). RTDM, as you can see from the existing drivers in
kernel/drivers/serial, is rather compact and does not come with that
infrastructure, primarily as it has a confined use case. Best is to
study those drivers, use one as template and replace the required
hardware accesses.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

