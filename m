References: <1984ba68-34d2-7574-f33a-0d63f07da9bc@numalliance.com>
 <0beb5709-2600-7cbb-4091-e1bbec0b2861@xenomai.org>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <87033b83-e7f5-8ee2-9cac-82126f1713d6@numalliance.com>
Date: Fri, 20 Jan 2017 17:12:15 +0100
MIME-Version: 1.0
In-Reply-To: <0beb5709-2600-7cbb-4091-e1bbec0b2861@xenomai.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] 32 bits / 64 bits compatibility
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Le 17/01/2017 =E0 11:32, Philippe Gerum a =E9crit :
> On 01/17/2017 10:30 AM, St=E9phane Ancelot wrote:
>> Hi,
>>
>> In order to keep graphic compatibility with an application, I must run
>> some xenomai applications in 32 bits.
>>
>> Is it possible to have a 64 bits kernel compile xenomai with 32 bits
>> libs for applications ?
>>
> Xenomai 3 supports this, currently for x86.
I managed to run 32 bits applications , with shared memory using 32 bits=20
emulation under 64 bit kernel with xenomai 3.  (latest git next branch=20
with 3.18.20 kernel)

The main problem remains with rtnet.
ioctl replies with no such device.

This can be reproduced with rtifconfig 32 and 64 bits version against=20
rteth0 interface (that is loaded ...).

rtifconfig 64bits works , not 32 bit one.

Regards,
S.Ancelot


