From: Lin Zhang <Lin.Zhang@domain.hid>
Date: Tue, 8 Mar 2011 22:45:31 +0100
Message-ID: <FA526D37A62FA141B5D2D8700F5167C83D79AE3E0D@ICTS-S-EXC4-CA.luna.kuleuven.be>
References: <4D7628BD.5050006@domain.hid>
	<4D766E9E.6050207@domain.hid>,<4D766FF4.20503@domain.hid>
In-Reply-To: <4D766FF4.20503@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] [Xenomai-core] [announce] Xenomai 2.5.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Wolfgang Grandegger <wg@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>, Xenomai core <Xenomai-core@domain.hid>

Dear Gilles,=20

Thank you for your kind help, it works now. Xenomai 2.5.6 works on my syste=
m.=20

Best regards,
Lin

________________________________________
From: xenomai-help-bounces@domain.hid [xenomai-help-bounces@domain.hid] On Behalf=
 Of Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]
Sent: Tuesday, March 08, 2011 7:05 PM
To: Wolfgang Grandegger
Cc: Xenomai help; Xenomai core
Subject: Re: [Xenomai-help] [Xenomai-core] [announce] Xenomai 2.5.6

Wolfgang Grandegger wrote:
> Hi Gilles,
>
> On 03/08/2011 02:01 PM, Gilles Chanteperdrix wrote:
>> Hi,
>>
>> Xenomai 2.5.6, a.k.a. "Wormhole Wizards" is available at the usual
>> place:
>> http://download.gna.org/xenomai/stable/xenomai-2.5.6.tar.bz2
>>
>> It contains mainly bug fixes, for:
>> - SMP scheduling bugs introduced by the "optimization" in the last
>> release;
>> - a cleanup of all architectures kernel threads initializations,
>> triggered by an issue on powerpc;
>> - some psos skin updates;
>> - some analogy updates;
>> - some compilation issues on ARM and x86 for latest toolchains, and with
>> uclibc;
>> - some issues with gdb on blackfin.
>>
>> And as usual an update of many I-pipe patches, including modifications
>> to use the latest kernel release to date (2.6.37), and wrappers fixes.
>
> Thanks a lot. I'm looking to the new ARM patches:
>
>   adeos-ipipe-2.6.33-arm-1.18-02.patch
>   adeos-ipipe-2.6.35.9-arm-1.18-01.patch
>
> Why is ipipe version 1.18-01 used for 2.6.35.9 (and not 1.18-02)? Or is
> it just a typo?

Just because 2.6.35.9-1.18-01 was made from 2.6.33-1.18-01, then 2.6.33
was improved, and triggered a new release. There is no reason really.
Maybe calling 2.6.35.9-1.18-00 would have made more sense.

--
                                            Gilles.

_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help

