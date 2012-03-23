Message-ID: <4F6C7722.2080609@domain.hid>
Date: Fri, 23 Mar 2012 14:14:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F6C35CA.8010506@domain.hid> <4F6C4978.6060108@domain.hid>
In-Reply-To: <4F6C4978.6060108@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_pipe does not support POLLHUP on the Linux
 side
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On 03/23/2012 10:59 AM, Gilles Chanteperdrix wrote:
> On 03/23/2012 09:35 AM, Wolfgang Grandegger wrote:
>> Hello,
>>
>> while playing with rt_pipe, I realized that a select()/poll() function
>> does not unblock when the rt_pipe is deleted (via rt_pipe_delete) on the
>> other end. I think this is because the poll callback does not support
>> POLLHUP:
>>
>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pipe.c#1024
>>
>> Is this by purpose? At least a blocking read() works as expected. It
>> does unblock and return 0 in that case.
> 
> rt_pipes are deprecated, we are not going to add new features to them
> now. Please do not use them for new developments. We now have socket
> based RTIPCs. See examples/rtdm/profiles/ipc.
> 

On the other hand, if you have a small patch to fix this, I will not
hurt anyone to merge it.

-- 
					    Gilles.

