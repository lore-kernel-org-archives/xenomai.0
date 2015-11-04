Message-ID: <BLU436-SMTP450DD53B7012910BE83C43F02A0@phx.gbl>
References: <BLU436-SMTP235B354929DDB6910D2667EF02D0@phx.gbl>
 <20151102162755.GA32103@hermes.click-hack.org>
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Date: Tue, 3 Nov 2015 19:11:12 -0800
MIME-Version: 1.0
In-Reply-To: <20151102162755.GA32103@hermes.click-hack.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Support for Raspberry PI 2 B
 (devm_request_threaded_irq)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 15-11-02 08:27 AM, Gilles Chanteperdrix wrote:
> On Sat, Oct 31, 2015 at 08:58:27PM -0700, Mathieu Rondonneau wrote:
>> Hi,
>>
>> irq handlers registered with devm_request_threaded_irq does not get
>> triggered when interrupt fires.
>>
>> The mmc driver uses this (can not load the rootfs).
>> Only the IPIPE patch is enabled.
>> the armctrl chipirq is triggering the .ack handler instead so the
>> interrupt is happening.
>>
>> Any suggestion on where I should look? how is this supported by the
>> ipipe layer?
>
> Maybe have a look here:
> http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/
>
Hi Gilles,

I read this guide a couple of time already in the past but it did not help.
But I think the section "flow handler" is where my problem resides since 
I get the callback to trigger properly.
I will continue staring at the code. I just don't have the big picture 
just yet.

Thanks,
-Mathieu


