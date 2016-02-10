References: <CAMJ=MEe9k1CS_tY=SxaaWTd+aYY2jAKNL_Ay1Ya0vvp1w5A6iQ@mail.gmail.com>
 <56B9CC36.1020309@xenomai.org>
 <CAMJ=MEe4vg9+2DF3=4ccss+gfrGnFsvwLL0vsu7rYO4fwBVg6w@mail.gmail.com>
 <CAMJ=MEdRoD20Lri8W6iePg6smZhz73zNZxFdYj8epzBX-oM8xA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56BAF9A1.1040803@xenomai.org>
Date: Wed, 10 Feb 2016 09:49:37 +0100
MIME-Version: 1.0
In-Reply-To: <CAMJ=MEdRoD20Lri8W6iePg6smZhz73zNZxFdYj8epzBX-oM8xA@mail.gmail.com>
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

On 02/10/2016 07:06 AM, Ronny Meeus wrote:
> On Tue, Feb 9, 2016 at 9:23 PM, Ronny Meeus <ronny.meeus@gmail.com> wrote:
> 
>> Philippe
>>
>> I have ported the patch to our version of Xenomai and started the test.
>> It runs already for several minutes without issues so it looks like
>> the problem is solved also with the patch below.
>> I will let it run overnight and update you tomorrow morning.
>>
> 
> Test is still running, no issues seen.
> So the conclusion is clear: your patch solves the issue.
> Thanks
> 

Ok, this patch made it to the -stable and -next branches. Thanks for the
update.

-- 
Philippe.

