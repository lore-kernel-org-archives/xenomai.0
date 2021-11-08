Date: Mon, 8 Nov 2021 13:05:14 +0100 (CET)
From: Paal Tamas <paal_to@freemail.hu>
Subject: Re: RTNET i.mx6 raw packets
In-Reply-To: <d075a68d-5acf-811d-2272-107bf94cfcc3@ba-healthcare.com>
Message-ID: <freemail.20211108130514.39067.1@fmxmldata00.freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear Jean-Baptiste and Jan,  Do you have any update on this topic?  Are you=
 sure that the issue I detected and described in my original mail (trying t=
o use RAW_SOCKET via the fec in my i.mx6 using the mentioned xenomai patch,=
 while PING is working when the UDP layer is loaded) is the cause of the ac=
tual fec driver implemention?I would be satisfied with that implemention if=
 we could make it work somehow.  Thank you vey much again,Tamas=20
Jean-Baptiste Tredez <jean-baptiste.tredez@ba-healthcare.com> =C3=ADrta:
>We are working on a new patch for mainline kernel 5.10 + xenomai=20
>(previous patch was based on nxp kernel 5.4 + xenomai 3.1).
>
>This work is under test. I hope to send a new proposal by the end of the=
=20
>month.
>
>Jean-Baptiste
>
>Le 07/10/2021 =C3=A0 10:12, Jan Kiszka a =C3=A9crit :
>> On 01.10.21 10:03, Paal Tamas via Xenomai wrote:
>>> Dear All, I would like to use RTNET with raw packets on the fec interfa=
ce of my i.mx6 CPU. The purpose of the whole thing is to use the Soem ECAT =
master.
>>> I am lost. I need your help. Xenomai_3.1, kernel 4.14.78.I am using thi=
s rtnet fec patch:
>>> https://xenomai.org/pipermail/xenomai/2019-March/040580.html The fec in=
terface is eth0.
>> There was a proposal to merge that change
>> (https://xenomai.org/pipermail/xenomai/2021-July/046000.html), and I
>> almost did but had to revert it again due to build issues
>> (https://xenomai.org/pipermail/xenomai/2021-August/046088.html). Any
>> news on this, Jean-Baptiste?
>>
>> Jan
>
