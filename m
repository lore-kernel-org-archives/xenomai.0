Message-ID: <52E5616F.90002@grandegger.com>
Date: Sun, 26 Jan 2014 20:26:39 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <52DF9C5F.70005@geral.com> <52DFAA18.6080703@xenomai.org>
 <52DFAD29.4000800@geral.com> <52DFB2DE.4050501@xenomai.org>
 <52DFC734.2090906@geral.com> <52DFC80D.6050101@xenomai.org>
 <52DFCFDE.9060700@geral.com> <52DFD1B0.6070303@xenomai.org>
In-Reply-To: <52DFD1B0.6070303@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] imx28 rtcan flexcan system freezes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Alexandre COFFIGNAL <acoffignal@geral.com>
Cc: xenomai@xenomai.org

On 01/22/2014 03:12 PM, Gilles Chanteperdrix wrote:
> On 01/22/2014 03:04 PM, Alexandre COFFIGNAL wrote:
>>
>> Le 22/01/2014 14:30, Gilles Chanteperdrix a =E9crit :
>>> On 01/22/2014 02:27 PM, Alexandre COFFIGNAL wrote:
>>>>
>>>> Le 22/01/2014 13:00, Gilles Chanteperdrix a =E9crit :
>>>>> On 01/22/2014 12:36 PM, Alexandre COFFIGNAL wrote:
>>>>>>>> +        cf->data[3]=3D((data0 >> 0)  & 0xFF) ;
>>>>>>>> +        cf->data[2]=3D((data0 >> 8)  & 0xFF) ;
>>>>>>>> +        cf->data[1]=3D((data0 >> 16)  & 0xFF) ;
>>>>>>>> +        cf->data[0]=3D((data0 >> 24)  & 0xFF) ;
>>>>>>>> +        cf->data[7]=3D((data1 >> 0)  & 0xFF) ;
>>>>>>>> +        cf->data[6]=3D((data1 >> 8)  & 0xFF) ;
>>>>>>>> +        cf->data[5]=3D((data1 >> 16)  & 0xFF) ;
>>>>>>>> +        cf->data[4]=3D((data1 >> 24)  & 0xFF) ;
>>>>>>>>
>>>>>>>> rtcan flexcan works perfectly.
>>>>>>>> is  anyone know what is the problem with first instructions ?
>>>>>>> Probably mb->data does not have the right alignment. Could you not
>>>>>>> arrange to get it properly aligned? Failing that, you should use
>>>>>>> put_unaligned instead of open coding it.
>>>>>>>
>>>>>>>
>>>>>> here structures used in flexcan driver, it seem to be aligned
>>>>>
>>>>> I am talking about the alignment of cf->data, since obviously, that is
>>>>> the one which is causing problems.
>>>>>
>>>>>
>>>> Thank a lot, put_unaligned fix this issue if you want, i can send a
>>>> path
>>>>
>>>
>>> The other solution (getting cf->data to be properly aligned) would be
>>> more efficient, why is not it possible to get cf->data properly aligned?
>>>
>> I think, i can't get cf->data to be properly aligned because "cf" is
>> receive internal frame representation within the ring buffer
>> of a struct rtcan_socket and struct rtcan_rb_frame is a generic
>> structure used in all rtcan drivers .
>=20
> Well, if you fix rtcan_rb_frame to be aligned, it will be aligned for
> all drivers, so that looks like a worthwile improvement...

I had a closer look. The CAN message (frame) queuing is optimized for
size to get as much as possible messages into the queue. Therefore the
CAN data are copied using memcpy, but only the real bytes. Directly
behind the real data is the 64 bit timestamp, if requested, which is
also not aligned. Therefore I suggest to use memcpy or byte accesses in
the flexcan driver as well. If this was a good decision is another question.

Wolfgang.


