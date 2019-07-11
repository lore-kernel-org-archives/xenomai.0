Subject: Re: Best way to detect if a filedescriptor is a cobalt filedescriptor
 (/socket)
References: <VI1PR05MB59172CE94DA6AFD8ADE653CEF6F10@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <c71b73d3-fbe8-ada9-a2d0-f960778ca8b5@siemens.com>
 <VI1PR05MB5917627DEAC8D3E321CDFA90F6F00@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <1782aabc-68ba-9e5e-0df4-ef111e2d50a6@xenomai.org>
Date: Thu, 11 Jul 2019 16:22:37 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB5917627DEAC8D3E321CDFA90F6F00@VI1PR05MB5917.eurprd05.prod.outlook.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 7/10/19 11:20 AM, Lange Norbert wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Mittwoch, 10. Juli 2019 08:13
>> To: Lange Norbert <norbert.lange@andritz.com>; Xenomai
>> (xenomai@xenomai.org) <xenomai@xenomai.org>; Philippe Gerum
>> <rpm@xenomai.org>
>> Subject: Re: Best way to detect if a filedescriptor is a cobalt filedescriptor
>> (/socket)
>>
>> E-MAIL FROM A NON-ANDRITZ SOURCE: AS A SECURITY MEASURE, PLEASE
>> EXERCISE CAUTION WITH E-MAIL CONTENT AND ANY LINKS OR
>> ATTACHMENTS.
>>
>>
>> On 09.07.19 16:49, Lange Norbert via Xenomai wrote:
>>> Hi,
>>>
>>> I am opening a packetsocket, which is supposed to be realtime.
>>> Unfortunatly if the rtpacket (rtnet?) module is not loaded, then this will
>> just silently fall back to a linux packet socket. Then later demote thread
>> during accesses.
>>>
>>> How would I be able to detect this early during startup? I could
>> __STD(close) the descriptor and check the returncode for EBADF I suppose...
>>>
>>
>> Yeah, looks this is some feature we lost while embedding the RTDM file
>> descriptor range into the regular Linux space.
> 
> My scheme does not work either, __STD(close) seems to return 0 for the cobalt fd,
> But doesn’t seem to do anything beyond that.
> 

The logic is the other way around: ask the Cobalt co-kernel to perform
some action on a (supposedly) Xenomai-registered fd, otherwise have
libcobalt fallback to glibc if the fd is not managed by the co-kernel.
That would be calling __RT(close), not __STD(close) first.

v2 of the patch switching from -EBADF to -ENODEV is needed to have this
working:
https://lab.xenomai.org/xenomai-rpm.git/commit/?h=for-upstream/next&id=0d7384acca2a71323be0d7412fd99aca6f0450d8

Which includes these bits:

diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index 81943c2f3..06f462d1d 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -835,7 +835,7 @@ int rtdm_fd_close(int ufd, unsigned int magic)
 	if (magic != 0 && fd->magic != magic) {
 ebadf:
 		xnlock_put_irqrestore(&fdtree_lock, s);
-		return -EBADF;
+		return -ENODEV;
 	}

 	set_compat_bit(fd);


Another other option is to use __RT(fcntl(fd, F_GETFD)): EINVAL would be
returned for this query on a Cobalt-managed fd, otherwise a success code
would denote a regular fd.

> Note: I am using Philippe's "cobalt: switch hand over status to -ENODEV for non-RTDM fd" patch,
> so potential it’s a regression of this patch.
> 
>> We could either add a compile-time or runtime feature to libcobalt that
>> permits to disable this silent fallback again or introduce alternative open and
>> socket implementations that do not expose this behavior. Spontaneously, I
>> would be in favor or a runtime switch for the existing implementations.
> 
> I assumed that __RT(open) would call the __cobalt_open function (without fallback),
> __STD(open) would call libc' open, and  __wrap_open would be the only function trying both.
> Turns out that __wrap and __cobalt are identical, but I don’t understand the reasoning behind it.

To have an opportunity for late binding on the __wrap symbols too, so
that one can override the libcobalt wrappers for interposing its own
version of the cobalt calls. OTOH, __cobalt bindings are guaranteed to
tap into the original libcobalt implementation. Some users need this to
provide their own flavor of Xenomai POSIX system calls on top of libcobalt.

-- 
Philippe.

