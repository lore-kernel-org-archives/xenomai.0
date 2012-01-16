Message-ID: <4F144123.9050904@domain.hid>
Date: Mon, 16 Jan 2012 16:24:19 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <BLU166-W49F600F976B754BCA60E03C4820@domain.hid>	<4F130ED3.3030902@domain.hid>
	<4F143351.6050406@domain.hid> <4F1435A9.6030609@domain.hid>
	<4F143DB9.70306@domain.hid>
In-Reply-To: <4F143DB9.70306@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] realtime pipes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Makarand Pradhan <makarandpradhan@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/16/2012 04:09 PM, Makarand Pradhan wrote:
> Thanks Philippe.
>
> To ensure that I understand correctly, let me rephrase my understanding.
>
> In 3.0, the rt_pipe_create and friends will cease to exist. We have to
> start using the sockets with domain AF_RTIPC and protocol IPCPROTO_XDDP
> instead.
>
> Is that a correct statement?

Basically, yes. In addition, X3 will keep the RT_PIPE interface for the 
-rt endpoint available on the application-side, by wrapping a XDDP 
socket to a RT_PIPE descriptor under the hood. In kernel space however, 
the RT_PIPE API to create -rt endpoints won't be available anymore, one 
will have to create them via the rtdm_socket/rt_dev_socket calls.

In any case, the API for the non-rt side does not change, i.e. POSIX 
file I/O calls will still be the way to interface with the -rt endpoint.

>
> Rgds,
> Mak.
>
> On 16/01/12 09:35 AM, Philippe Gerum wrote:
>> On 01/16/2012 03:25 PM, Makarand Pradhan wrote:
>>> Hi,
>>>
>>> "Real-time pipes are deprecated."
>>>
>>> We use a lot of rt pipes. So, can you pl elaborate on this? I would
>>> highly appreciate if you can comment on the following.
>>>
>>> 1. When will the rt pipe interface be removed? Any time frame?
>> Xenomai 3. Xenomai 2.x will keep them forever.
>>
>>> 2. Would like to understand the reason for deprecating the interface.
>>>
>> - Because there is a better socket-based API implemented by the RTIPC
>> driver w/ the XDDP protocol, which does not require running application
>> level code in kernel space (RT_PIPE is definitely an application level
>> API). This new interface is available since Xenomai 2.5.x. It is
>> functionally 100% equivalent to the legacy RT_PIPE API.
>>
>> - Because no support will be provided in Xenomai 3 for running
>> application level code in kernel space, so RT_PIPE have to go from
>> kernel space. However, RT_PIPE are still part of the user-space API of
>> Xenomai 3, interfacing with XDDP endpoints in kernel space.
>>
>> I'm really referring to application level code, by contrast to RTDM
>> driver level code which will obviously remain a first-class citizen in
>> kernel space.
>>
>> See:
>>
>> o http://www.xenomai.org/index.php/Xenomai:Roadmap
>>
>> o
>> http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__rtipc.html
>>
>>
>> o examples/rtdm/profiles/ipc in the Xenomai distro
>>
>>> Thanks and Rgds,
>>> Mak.
>>>
>>>
>>> On 15/01/12 12:37 PM, Gilles Chanteperdrix wrote:
>>>> Real-time pipes are deprecated.
>>>
>>
>
>


-- 
Philippe.

