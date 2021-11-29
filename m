Subject: Re: [PATCH 4/6] drivers/can: add a minimal support to ethtool API
References: <20211124234648.7428-1-dariobin@libero.it>
 <20211125004644.4.Ia5c620cabdfdf1d9fb20719eddce89c52aa4af62@changeid>
 <13bfd3b6-94bd-6e60-3978-4683f8aebc87@siemens.com>
 <1195732259.564856.1638027537471@mail1.libero.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6f4f334d-bb1d-3d06-b973-53c0b3c3deee@siemens.com>
Date: Mon, 29 Nov 2021 08:53:45 +0100
MIME-Version: 1.0
In-Reply-To: <1195732259.564856.1638027537471@mail1.libero.it>
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
To: Dario Binacchi <dariobin@libero.it>, xenomai@xenomai.org
Cc: Philippe Gerum <rpm@xenomai.org>, Michael Trimarchi <michael@amarulasolutions.com>, Gianluca Falavigna <gianluca.falavigna@inwind.it>, Wolfgang Grandegger <wg@grandegger.com>, "Stephen J . Battazzo" <stephen.j.battazzo@nasa.gov>, Sebastian Smolorz <Sebastian.Smolorz@gmx.de>

On 27.11.21 16:38, Dario Binacchi wrote:
> Hi Jan,
> 
>> Il 25/11/2021 11:26 Jan Kiszka <jan.kiszka@siemens.com> ha scritto:
>>
>>  
>> On 25.11.21 00:46, Dario Binacchi wrote:
>>> Like in the Linux kernel, the API allows to get/set device controller
>>> parameters.
>>> For now it only supports:
>>>  - ETHTOOL_GDRVINFO: get general driver and device information
>>>  - ETHTOOL_GRINGPARAM: get RX/TX ring parameters
>>>
>>
>> What will be the use case? IIUC, only the c_can driver will implement
>> the required callbacks, right? 
> Yes, for now.
> 
>> Does it need this interface in order to become operational? 
> No, the driver is fully operational even without this interface.
> I think that 2722ac986e93 ("can: c_can: add ethtool support") was the
> first commit applied to the Linux Kernel adding ethtool support for
> CAN devices.
> 
>> Is it a useful debug features? Or what is this for, practically?
> It allows the userspace to know the number of message objects managed by
> the controller (32 or 64) and how many of them are used for reception/transmission.
> If I know the TX FIFO depth I know how many messages I can send before the 
> sendmsg returns error for FIFO full.
> 

OK, please expand the commit message accordingly. Also explain that
application programs are expected to use the new API via IOCTL directly,
no userspace tool.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

