Message-ID: <4FBE2914.70407@xenomai.org>
Date: Thu, 24 May 2012 14:27:00 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHzTO8=tcqM4-NbZiZnt9VNAMPSg-swPr-d8pM_e=OV=d_K=Ug@mail.gmail.com>
	<4FBE262C.9080409@xenomai.org>
In-Reply-To: <4FBE262C.9080409@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai API
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai@xenomai.org

On 05/24/2012 02:14 PM, Philippe Gerum wrote:
> On 05/24/2012 01:14 PM, Giampaolo Bellini wrote:
>> Hi all
>>
>>    I'm totally new to xenomai... so my question could be stupid :-(
>>
>>    I wonder if there are xenomai's counterpart of RTAI's SCB (Shared memory
>> Circular Buffer),
> 
> RT_QUEUE for the shared memory property.

Documentation here:

http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__native__queue.html
> 
>    MBX (MailBox)
> 
> RT_BUFFER.

Documentation here:
http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__buffer.html

-- 
					    Gilles.

