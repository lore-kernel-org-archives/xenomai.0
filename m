Message-ID: <5465D11B.1060808@sigmatek.at>
Date: Fri, 14 Nov 2014 10:53:31 +0100
From: Johann Obermayr <johann.obermayr@sigmatek.at>
MIME-Version: 1.0
References: <54631EB1.1050900@sigmatek.at>
 <20141112164411.GB17476@sisyphus.hd.free.fr> <5464DCAA.6060004@sigmatek.at>
 <20141113163300.GM4656@sisyphus.hd.free.fr>
In-Reply-To: <20141113163300.GM4656@sisyphus.hd.free.fr>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Subject: Re: [Xenomai] rtdm_nrtsig_pend FAQ
Reply-To: johann.obermayr@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Am 13.11.2014 um 17:33 schrieb Gilles Chanteperdrix:
> On Thu, Nov 13, 2014 at 05:30:34PM +0100, Johann Obermayr wrote:
>> Am 12.11.2014 um 17:44 schrieb Gilles Chanteperdrix:
>>> On Wed, Nov 12, 2014 at 09:47:45AM +0100, Johann Obermayr wrote:
>>>> Hello,
>>>>
>>>> we use rtdm_nrtsig_pend follow.
>>>>
>>>> static rtdm_nrtsig_t wait_domain_nrt;
>>>> static DECLARE_WAIT_QUEUE_HEAD(wait_domain_wq);
>>>>
>>>> void period_update()
>>>> {
>>>>          wait_domain_pend_count++;
>>>>          rtdm_nrtsig_pend(&wait_domain_nrt);
>>>> }
>>>>
>>>> static void wait_domain_nrt_handler(rtdm_nrtsig_t nrt_sig, void *arg)
>>>> {
>>>>      wait_domain_call_count++;
>>>>      //wakeup wait_domain
>>>>      wait_domain_wakeup =3D 1;
>>>>      wake_up_interruptible(&wait_domain_wq);
>>>> }
>>>>
>>>>
>>>> period_update is called every millisecond.
>>>> this is on imx6 hardware with kernel 3.0.x and xenomai 2.6.2.1.
>>> >From what Thierry said, I suspect the patch for this kernel has a
>>> missing call to irq_exit. So, I would ask you to do the same as
>>> Thierry, please enable the I-pipe tracer, set a sufficient number of
>>> back trace points such as 10000, and trigger a trace when you detect
>>> that you have "lost" a notification (wait_dommain_pend_count > wait_dom=
ain_call_count + 1)
>>>
>>> Then send the trace to the mailing list.
>>>
>> Hi,
>>
>> witch function i must use to make a i-pipe trace ?
>> here i am in a xenomai irq handle
>>
>> void period_update()
>> {
>>      ......
>>      else if (wait_domain_pend_count > 100000 &&
>> wait_domain_pend_count !=3D wait_domain_call_count) {
>>              // dotrace
>>
>>       }
>> }
> ipipe_trace_freeze. Requires a numeric argument, which has no
> particular meaning, it just gets printed in the trace.
>
> The I-pipe tracer is documented here:
> http://xenomai.org/2014/06/using-the-i-pipe-tracer/
>
Hello,

here is the trace

-------------- next part --------------
A non-text attachment was scrubbed...
Name: frozen.zip
Type: application/zip
Size: 10590 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141114/36700ef=
8/attachment.zip>
