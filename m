References: <1534230470-3290-1-git-send-email-sebastian.smolorz@gmx.de>
 <56f43c3f-36e1-23aa-7026-110f551ccb84@xenomai.org> <1840309.ADFtR25N4L@lenni>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <3fb21d3f-403c-6015-181a-550b78911ead@xenomai.org>
Date: Thu, 16 Aug 2018 11:03:18 +0200
MIME-Version: 1.0
In-Reply-To: <1840309.ADFtR25N4L@lenni>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] net: Split internal rtnet.h into rtdm/net.h
 and rtdm/uapi/net.h and install them
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Cc: xenomai@xenomai.org

On 08/16/2018 10:44 AM, Sebastian Smolorz wrote:
> On 08/15/2018, 16:16:09 CEST Philippe Gerum wrote:
>> On 08/14/2018 09:07 AM, Sebastian Smolorz wrote:
>>> For external projects wanting to use RTnet with its special
>>> features like RTnet IOCTLs it is necessary to provide the API
>>> headers in the Xenomai installation directory.
>>
>> Assuming there is no ABI change, and net/stack/include/rtnet.h was not
>> part of any external API, do you push this for inclusion in the
>> -stable branch too?
> 
> My assumption was that Xenomai API headers which are supposed to be used 
> by external projects are installed into the installation directory. All 
> other headers are internal to the Xenomai project and using them for 
> external project would be kind of a misuse. With this assumption in mind 
> I found out that rtnet.h was no part of the API in the installation 
> directory. Thinking this further the patch could be very suitable for 
> the stable branch because it adds the RTnet API where Xenomai 3 lacked 
> it so far (at least inside the installation directory).
>

Ack.

> But I have got some doubts about my patch at a different point: I 
> thought that rtdm/net.h would be for inclusion by RTnet drivers and 
> rtdm/uapi/net.h for userland. Looking at the other RTDM headers this 
> seems not to be true. The API for kernel drivers is located only in 
> include/cobalt/kernel/rtdm/, isn't it? I think I have to prepare a PATCH 
> v2.
> 

The current layout for RTDM-based features is as follows:

kernel API header: include/cobalt/kernel/rtdm/<feat.h>
user API header: include/rtdm/<feat.h>
shared API bits between user and kernel: include/rtdm/uapi/<feat.h>

-- 
Philippe.

