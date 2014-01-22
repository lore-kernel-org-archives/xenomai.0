Message-ID: <52DFAD29.4000800@geral.com>
Date: Wed, 22 Jan 2014 12:36:09 +0100
From: Alexandre COFFIGNAL <acoffignal@geral.com>
MIME-Version: 1.0
References: <52DF9C5F.70005@geral.com> <52DFAA18.6080703@xenomai.org>
In-Reply-To: <52DFAA18.6080703@xenomai.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


Le 22/01/2014 12:23, Gilles Chanteperdrix a =E9crit :
> On 01/22/2014 11:24 AM, Alexandre COFFIGNAL wrote:
>> Hi all,
>>
>> I use two rtcan flexcan on imx28-evk board.
>>
>> If both rtcan devices receive a data at the same time, this cause a free=
ze.
>> After investigation, i found that if I replace in flexcan_rx_interrupt
>> these instructions :
>> -        *(__be32 *)(cf->data + 0) =3D
>> -            cpu_to_be32(flexcan_read(&mb->data[0]));
>> -        *(__be32 *)(cf->data + 4) =3D
>> -            cpu_to_be32(flexcan_read(&mb->data[1]));
>>
>> by these
>>
>> +        data0 =3D flexcan_read(&mb->data[0]);
>> +        data1 =3D flexcan_read(&mb->data[1]);
>> +
>> +        cf->data[3]=3D((data0 >> 0)  & 0xFF) ;
>> +        cf->data[2]=3D((data0 >> 8)  & 0xFF) ;
>> +        cf->data[1]=3D((data0 >> 16)  & 0xFF) ;
>> +        cf->data[0]=3D((data0 >> 24)  & 0xFF) ;
>> +        cf->data[7]=3D((data1 >> 0)  & 0xFF) ;
>> +        cf->data[6]=3D((data1 >> 8)  & 0xFF) ;
>> +        cf->data[5]=3D((data1 >> 16)  & 0xFF) ;
>> +        cf->data[4]=3D((data1 >> 24)  & 0xFF) ;
>>
>> rtcan flexcan works perfectly.
>> is  anyone know what is the problem with first instructions ?
> Probably mb->data does not have the right alignment. Could you not
> arrange to get it properly aligned? Failing that, you should use
> put_unaligned instead of open coding it.
>
>
here structures used in flexcan driver, it seem to be aligned

/* Structure of the message buffer */
struct flexcan_mb {
     u32 can_ctrl;
     u32 can_id;
     u32 data[2];
};

/* Structure of the hardware registers */
struct flexcan_regs {
     u32 mcr;        /* 0x00 */
     u32 ctrl;        /* 0x04 */
     u32 timer;        /* 0x08 */
     u32 _reserved1;        /* 0x0c */
     u32 rxgmask;        /* 0x10 */
     u32 rx14mask;        /* 0x14 */
     u32 rx15mask;        /* 0x18 */
     u32 ecr;        /* 0x1c */
     u32 esr;        /* 0x20 */
     u32 imask2;        /* 0x24 */
     u32 imask1;        /* 0x28 */
     u32 iflag2;        /* 0x2c */
     u32 iflag1;        /* 0x30 */
     u32 crl2;        /* 0x34 */
     u32 esr2;        /* 0x38 */
     u32 _reserved2[2];
     u32 crcr;        /* 0x44 */
     u32 rxfgmask;        /* 0x48 */
     u32 rxfir;        /* 0x4c */
     u32 _reserved3[12];
     struct flexcan_mb cantxfg[64];
};

