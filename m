Message-ID: <52CE6A13.3090909@xenomai.org>
Date: Thu, 09 Jan 2014 10:21:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAFnctWFSGJc0Q6ebZ0zBhxRmFEwkvCYKinAEgD-xzcCbfLaPBg@mail.gmail.com>
 <52C7CF1E.2050404@xenomai.org> <52C85088.7020501@xenomai.org>
 <52C86093.4000609@xenomai.org>
 <CAFnctWG1QoQ=f9JCsdxAoU25mc797fKoT9dVS_DdZFRcQ5CP3A@mail.gmail.com>
 <52C891C1.2090007@xenomai.org>
 <CAFnctWFb-dNtNDGf0kckejhQ+tFAj2hBw3gm5Xv8DoALi6f26g@mail.gmail.com>
 <52C949D6.6090904@xenomai.org> <52C9B255.7030702@xenomai.org>
 <52CA622D.806@xenomai.org>
 <CAFnctWGs-mqukTTujenvex9Doq0DoJ_ohFEPDjd7ECYRzu6tpw@mail.gmail.com>
 <52CB23F5.6000006@xenomai.org>
 <CAFnctWGwssFMPeLwhpJnob46rXwRDDxuj_Snoh6Cqs8cbRN2Cw@mail.gmail.com>
 <52CB261F.1050808@xenomai.org> <52CB29F9.4020100@xenomai.org>
 <CAFnctWFJZxFORV-QLxou2PD_DDyFGWiaA5=R3W0VMVqwj+e3_A@mail.gmail.com>
 <52CB32BD.7020607@xenomai.org>
 <CAFnctWFdG5hXxGm7ivfwz94pYxTsDm6c87-FkoeePAAHS5uAiw@mail.gmail.com>
In-Reply-To: <CAFnctWFdG5hXxGm7ivfwz94pYxTsDm6c87-FkoeePAAHS5uAiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_task_init call freezes the system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nima Nourozi <n.nourozi@gmail.com>
Cc: xenomai@xenomai.org

On 01/09/2014 03:51 AM, Nima Nourozi wrote:
> On Mon, Jan 6, 2014 at 2:48 PM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> On 01/06/2014 11:47 PM, Nima Nourozi wrote:
>>> I'm not seeing the latency command on my board. Is it part of xenomai?
>> I'm
>>> using buildroot for my filesystem.
>>
>> It may not be installed in /usr/bin
>>
>> Try "xeno latency"
>>
>>
>> --
>>                                                                 Gilles.
>>
> 
> Gilles, good news!
> 
> I was about to report back that the "simplified SPI code" was throwing the
> same exception before I messed around in the kernel a little bit more and
> turned off VFP feature and low and behold the task is working now!!
> Hurray!! I don't know why VFP was causing all this headache but I'm glad
> it's working.
> 
> Thanks everybody for all help!

Actually, what the VFP changes is the size of rtdm_task_t, so if the
behaviour of your driver depends on the size of rtdm_task_t, there is
definitely something wrong (like for instance an rtdm_task_t put on
stack). So, again:

please re-enable VFP and test xeno latency -t 1
to see if rtdm_task_init works on your system

please send an as reduced as possible piece of code which allows to
reproduce the problem. The reason to reduce it as much as possible is to:
- be sure of exactly what sequence of calls causes the problem;
- allow people helping you to grasp quickly what this sequence of calls is.

-- 
                                                                Gilles.

