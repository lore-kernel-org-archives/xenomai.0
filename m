References: <CAMJ=MEe9k1CS_tY=SxaaWTd+aYY2jAKNL_Ay1Ya0vvp1w5A6iQ@mail.gmail.com>
 <56B9CC36.1020309@xenomai.org>
 <CAMJ=MEe4vg9+2DF3=4ccss+gfrGnFsvwLL0vsu7rYO4fwBVg6w@mail.gmail.com>
 <CAMJ=MEdRoD20Lri8W6iePg6smZhz73zNZxFdYj8epzBX-oM8xA@mail.gmail.com>
 <CAMJ=MEdpwJ_J_3u7QMdhgCKM8QtfDSNS_7h2igKGJf8PniuGfA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56BAF87A.8050505@xenomai.org>
Date: Wed, 10 Feb 2016 09:44:42 +0100
MIME-Version: 1.0
In-Reply-To: <CAMJ=MEdpwJ_J_3u7QMdhgCKM8QtfDSNS_7h2igKGJf8PniuGfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Mercury / pSOS: messages lost due to bug in q_receive
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: xenomai@xenomai.org

On 02/10/2016 09:13 AM, Ronny Meeus wrote:
> On Wed, Feb 10, 2016 at 7:06 AM, Ronny Meeus <ronny.meeus@gmail.com> wrote:
>> On Tue, Feb 9, 2016 at 9:23 PM, Ronny Meeus <ronny.meeus@gmail.com> wrote:
>>
>>> Philippe
>>>
>>> I have ported the patch to our version of Xenomai and started the test.
>>> It runs already for several minutes without issues so it looks like
>>> the problem is solved also with the patch below.
>>> I will let it run overnight and update you tomorrow morning.
>>>
>>
>> Test is still running, no issues seen.
>> So the conclusion is clear: your patch solves the issue.
>> Thanks
>>
>> Ronny
> 
> Philippe,
> 
> you state in on of the comments in the patch:
> "
>  * Whether a condition should be deemed satisfied if it is
>  * signaled during the race window described above is
>  * debatable, but this is a simple and straightforward way to
>  * handle such grey area.
> "
> 
> I understand this, it could also be possible to return a timeout in
> this case to the
> caller, but it is not acceptable that the message is actually lost.
> If you implement it in such a way that a timeout error is returned, the message
> that has been copied into the receiver's buffer should be put back in the queue
> so that it is received on the next call to q_receive.
> 

Clearly, yes. But that approach would invalidate the current assumption
that receiving any error status from the wait_grant/drain services
(which includes -ETIMEDOUT/-EINTR) does mean that such operation has
entirely failed, and the object state was left unchanged. On the
contrary, that would mean that such operation might have failed or
succeeded, we would not know until some extra state is considered (e.g.
the wait_struct relaying the data).

Not only this would require all current users to be fixed up for looking
at that extra piece of information in their own state, but this is not
acceptable logically speaking. Also, that would make the implementation
uselessly complex in the upper layers.

-- 
Philippe.

