MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Date: Mon, 27 Jan 2014 08:56:14 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <52E5766A.1040306@xenomai.org>
References: <52DF9C5F.70005@geral.com> <52DFAA18.6080703@xenomai.org>
 <52DFAD29.4000800@geral.com> <52DFB2DE.4050501@xenomai.org>
 <52DFC734.2090906@geral.com> <52DFC80D.6050101@xenomai.org>
 <52DFCFDE.9060700@geral.com> <52DFD1B0.6070303@xenomai.org>
 <52E5616F.90002@grandegger.com> <52E56221.5070005@xenomai.org>
 <52E56D0F.2040909@grandegger.com> <52E5766A.1040306@xenomai.org>
Message-ID: <701f63f992829713e3d3d6b872165208@grandegger.com>
Subject: Re: [Xenomai] imx28 rtcan flexcan system freezes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Sun, 26 Jan 2014 21:56:10 +0100, Gilles Chanteperdrix

<gilles.chanteperdrix@xenomai.org> wrote:

> On 01/26/2014 09:16 PM, Wolfgang Grandegger wrote:

>> On 01/26/2014 08:29 PM, Gilles Chanteperdrix wrote:

>>> On 01/26/2014 08:26 PM, Wolfgang Grandegger wrote:

>>>> On 01/22/2014 03:12 PM, Gilles Chanteperdrix wrote:

>>>>> On 01/22/2014 03:04 PM, Alexandre COFFIGNAL wrote:

>>>>>>

>>>>>> Le 22/01/2014 14:30, Gilles Chanteperdrix a écrit :

>>>>>>> On 01/22/2014 02:27 PM, Alexandre COFFIGNAL wrote:

>>>>>>>>

>>>>>>>> Le 22/01/2014 13:00, Gilles Chanteperdrix a écrit :

>>>>>>>>> On 01/22/2014 12:36 PM, Alexandre COFFIGNAL wrote:

>>>>>>>>>>>> +        cf->data[3]=((data0 >> 0)  & 0xFF) ;

>>>>>>>>>>>> +        cf->data[2]=((data0 >> 8)  & 0xFF) ;

>>>>>>>>>>>> +        cf->data[1]=((data0 >> 16)  & 0xFF) ;

>>>>>>>>>>>> +        cf->data[0]=((data0 >> 24)  & 0xFF) ;

>>>>>>>>>>>> +        cf->data[7]=((data1 >> 0)  & 0xFF) ;

>>>>>>>>>>>> +        cf->data[6]=((data1 >> 8)  & 0xFF) ;

>>>>>>>>>>>> +        cf->data[5]=((data1 >> 16)  & 0xFF) ;

>>>>>>>>>>>> +        cf->data[4]=((data1 >> 24)  & 0xFF) ;

>>>>>>>>>>>>

>>>>>>>>>>>> rtcan flexcan works perfectly.

>>>>>>>>>>>> is  anyone know what is the problem with first instructions ?

>>>>>>>>>>> Probably mb->data does not have the right alignment. Could you

>>>>>>>>>>> not

>>>>>>>>>>> arrange to get it properly aligned? Failing that, you should

use

>>>>>>>>>>> put_unaligned instead of open coding it.

>>>>>>>>>>>

>>>>>>>>>>>

>>>>>>>>>> here structures used in flexcan driver, it seem to be aligned

>>>>>>>>>

>>>>>>>>> I am talking about the alignment of cf->data, since obviously,

>>>>>>>>> that is

>>>>>>>>> the one which is causing problems.

>>>>>>>>>

>>>>>>>>>

>>>>>>>> Thank a lot, put_unaligned fix this issue if you want, i can send

a

>>>>>>>> path

>>>>>>>>

>>>>>>>

>>>>>>> The other solution (getting cf->data to be properly aligned) would

>>>>>>> be

>>>>>>> more efficient, why is not it possible to get cf->data properly

>>>>>>> aligned?

>>>>>>>

>>>>>> I think, i can't get cf->data to be properly aligned because "cf"

is

>>>>>> receive internal frame representation within the ring buffer

>>>>>> of a struct rtcan_socket and struct rtcan_rb_frame is a generic

>>>>>> structure used in all rtcan drivers .

>>>>>

>>>>> Well, if you fix rtcan_rb_frame to be aligned, it will be aligned

for

>>>>> all drivers, so that looks like a worthwile improvement...

>>>>

>>>> I had a closer look. The CAN message (frame) queuing is optimized for

>>>> size to get as much as possible messages into the queue. Therefore

the

>>>> CAN data are copied using memcpy, but only the real bytes. Directly

>>>> behind the real data is the 64 bit timestamp, if requested, which is

>>>> also not aligned. Therefore I suggest to use memcpy or byte accesses

in

>>>> the flexcan driver as well. If this was a good decision is another

>>>> question.

>>>

>>> Aligning the data begining costs 2 bytes by struct rtcan_rb_frame. How

>>> many such structures are there for a typical driver?

>> 

>> Any message in the queue will require two bytes more. I did not say

that

>> optimizing for size is necessary, but that's how it was implemented

long

>> time ago. And I do not see a need to break that just because of the

>> Flexcan driver.

> 

> IMO, it is not just for the flexcan driver, it will avoid unaligned

> accesses for all drivers which access data 4 bytes at a time. And I do

> not think it "breaks" anything. What I do not know is:



But it's just the Flexcan driver which is doing unaligned accesses.



> - how many struct rtcan_rb_frame are typically in use? If only a few,

> then adding 2 bytes should not be a problem.



This depends on the size of the queue. But if the message size changes

it will also change run-time behaviour because less messages will fit

into the queue. That's what I'm more concerned about than the extra

2 bytes.



> - do all drivers access data 4 bytes at a time? or only the flexcan

driver?



No, as far as I have seen only the Flexan driver. But I need to check.



Wolfgang.



