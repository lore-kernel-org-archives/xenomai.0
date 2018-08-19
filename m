References: <1534446608-1303-1-git-send-email-sebastian.smolorz@gmx.de>
 <e677aecd-440f-8614-50f8-dd6105dfddc1@xenomai.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <9c746901-b2ed-61b2-6f27-bd9b8a2e089a@web.de>
Date: Sun, 19 Aug 2018 22:15:07 +0200
MIME-Version: 1.0
In-Reply-To: <e677aecd-440f-8614-50f8-dd6105dfddc1@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v2] net: Split internal rtnet.h and install
 rtdm/net.h and rtdm/uapi/net.h
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Sebastian Smolorz <sebastian.smolorz@gmx.de>, xenomai@xenomai.org

On 2018-08-18 10:55, Philippe Gerum wrote:
> On 08/16/2018 09:10 PM, Sebastian Smolorz wrote:
>> For external projects wanting to use RTnet with its special
>> features like RTnet IOCTLs it is necessary to provide the API
>> headers in the Xenomai installation directory.
> 
> Looks ok to me, pending a second ack from a RTnet-savvy maintainer (@Jan?).
> 

The split-up looks good to me as well.

> PS: In a second round, maybe we should move the definitions from
> rtnet_port.h used by the drivers to rtdm/net.h and get rid of the former
> since including the latter is definitely about accessing the kernel
> interface needed to implement a driver.

Yeah, a lot of history and legacy is in that code base...

Jan

