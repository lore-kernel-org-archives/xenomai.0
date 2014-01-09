Message-ID: <52CE5EE7.90003@xenomai.org>
Date: Thu, 09 Jan 2014 09:33:43 +0100
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

That is totally unexpected. Turning on or off VFP on AT91 should not
change anything, since this processor does not have a VFP unit, as far
as I can tell, or does it have one?

Please post the simplified code so that I can test it on AT91SAM9263.


-- 
                                                                Gilles.

