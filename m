From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: xenomai warning after upgrade to linux 5.4.115
Date: Wed, 4 Aug 2021 00:32:39 +0000
Message-ID: <BN9PR11MB52273B17E519A34EE80FEC8BF2F19@BN9PR11MB5227.namprd11.prod.outlook.com>
References: <BN9PR11MB52270515FDDDB8D6AFD37F6FF2EB9@BN9PR11MB5227.namprd11.prod.outlook.com>
 <c79cae1e-d905-53eb-4f23-6f9d57d2d34f@siemens.com>
 <4bd7748b-8944-fa68-7130-74cc00055b64@siemens.com>
In-Reply-To: <4bd7748b-8944-fa68-7130-74cc00055b64@siemens.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>



>-----Original Message-----
>From: Jan Kiszka <jan.kiszka@siemens.com>=20
>Sent: Tuesday, August 3, 2021 5:37 PM
>To: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org
>Subject: Re: xenomai warning after upgrade to linux 5.4.115
>
>On 29.07.21 10:02, Jan Kiszka via Xenomai wrote:
>> On 29.07.21 08:43, Chen, Hongzhan wrote:
>>> After we upgraded our linux to 5.4.115 from 5.4.76 and rebased IPIPE pa=
tchset for xenomai 3.1.X,  there is xenomai warning
>>> printed as in attached xenomai_warning_on_linux5.4.115 on some specific=
 boards according to our validation.
>>=20
>> From a first inspection: Linux considers its interrupts to be off around
>>=20
>> xenomai_init
>>   xntimer_grab_hardware
>>     ipipe_timer_start
>>       smp_call_function_single
>>=20
>> But that should not be the case. The call path is valid and used for a
>> long time. The issue should come from somewhere else.
>>=20
>> You you try to debug where interrupts are turned off from Linux
>> perspective? Compare that to boot ups where Linux does not complain.
>>=20
>>> But I cannot reproduce the issue on same type of board like Maxtang tha=
t I have.  In addition,
>>> on one specific board, we found that there is similar warning happened =
in smp_call_function_single  when ACPI init
>>> ahead of warning happened in xenomai init as in attached ACPI_warning_a=
nd_xenomai_warning_on_linux5.4.115.
>>> When we set acpi=3Doff in cmdline for all problematic boards , warning =
totally disappear.  Since I cannot get the problematic board
>>> to further debug, would you mind help check attached logs and kernel co=
nfig and find the root cause out?
>>> Thanks for your help in advance.
>>
>>=20
>> Does that other case only occur when CONFIG_IPIPE is enabled? If it also
>> happens with plain Linux, we may see a mainline issue. Or firmware bugs.
>>=20
>> Jan
>>=20
>
>Any news on this issue?

Finally , we found there is missing code in our split patches.

Regards

Hongzhan Chen
>
>Jan
>
>--=20
>Siemens AG, T RDA IOT
>Corporate Competence Center Embedded Linux

