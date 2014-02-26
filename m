MIME-Version: 1.0
In-Reply-To: <CAEbDrgkJCnq_qTV-gqbH5QbT4DjL7oOyCe09gogiftTHGpGn-Q@mail.gmail.com>
References: <CAEbDrgkJCnq_qTV-gqbH5QbT4DjL7oOyCe09gogiftTHGpGn-Q@mail.gmail.com>
Date: Wed, 26 Feb 2014 20:29:31 +0000
Message-ID: <CAEbDrgmx0yOHTVcLfKVmdZOQ-ek8FoAn3NGxqiodsNdDWOgPxw@mail.gmail.com>
From: Gregory Dymarek <gregd72002@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] RaspberryPi kernel 3.8 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Here is one more ipipe trace with less garbage:
http://pastebin.com/WG80f6cx

This happened when i plug usb device after boot is complete


On 26 February 2014 19:59, Gregory Dymarek <gregd72002@gmail.com> wrote:

>
> Gilles
> here is the ipipe trace (see line 112)
> http://pastebin.com/EcLn0MxJ
>
> that corresponds to
> http://pastebin.com/vjLJVDGS
>
> I do not see any call to enable irq, but there are plenty calls for debug.
>
>
> Could you also explain in a few words the previous patch please.
> What was wrong with local_fiq_disable() defined as ipipe_stall_root() ?
>
> Thanks
>
>
> On 25 February 2014 23:51, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
>
>> On 02/26/2014 12:20 AM, Gregory Dymarek wrote:
>> > well, this does not work for me. It boots fine when there is no USB
>> device
>> > plugged in.
>> > However, when my WIFI or bluetooth adapter is plugged in, the boot log
>> > shows: http://pastebin.com/vjLJVDGS
>>
>> Well, it looks like a different issue, which happens when irqs are
>> re-enabled by DWC_SPINUNLOCK_IRQRESTORE. So, maybe we have progressed. I
>> am cloning the rpi repository, to see what happens at this point.
>>
>> But you can try and use the I-pipe tracer again, put a trace freeze in
>> the "report_bad_irq" function.
>>
>> --
>>                                                                 Gilles.
>>
>
>
>
