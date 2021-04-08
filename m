From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: Xenomai Community Call Minutes - April 7, 2021
Date: Thu, 8 Apr 2021 08:19:57 +0000
Message-ID: <DM5PR11MB1852F1F506FE58645808D1B2F2749@DM5PR11MB1852.namprd11.prod.outlook.com>
References: <CO6PR11MB56493CA60ADCFBEFC2670FF3BA749@CO6PR11MB5649.namprd11.prod.outlook.com>
In-Reply-To: <CO6PR11MB56493CA60ADCFBEFC2670FF3BA749@CO6PR11MB5649.namprd11.prod.outlook.com>
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

>From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Wang, Rick Y via =
Xenomai
>Sent: Thursday, April 8, 2021 8:52 AM
>To: xenomai@xenomai.org
>Subject: Xenomai Community Call Minutes - April 7, 2021
>
>Attendees:
>
>Jan Kiszka, Florian Bezdeka, Florent Pirou, Hongzhan Chen,
>Dao Zhang, Jianbo Cao, Yanfeng Pu, Rick Wang
>
>
>*Community update
>
>- No code change in the past two weeks
>- Greg is debugging jitter issue on ARM.
>- Siemens is testing WIP-Dovetail branch internally. Some issues were
>reported related to clock source or gdb crash.
>- Jan will log the issues to gitlab Xenomai hacker space:
>https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues
>- For Xenomai 3.2, there are some submitted patches pending on Jan's revie=
w
>and merge. Also some patches in Philippe's private tree are pending on
>submission.
>- Florian and Song are working on Y2038 issue on Philippe's tree. It depen=
ds
>on some Dovetail codes to be merged first.
>- Hongzhan is working on latmus GPIO porting. 5.10 Dovetail-based Xenomai
>and EVL can't boot up on his dev board yet. 5.9 kernel can boot on the

After further debug , when failure happen, actually system is wrong to use =
pit instead of=20
LAPIC as clock event device because pit can not work with dovetail. After c=
heck log , found
that there is abnormal info related to APIC reported "[    2.812126] APIC: =
ACPI MADT or MP tables are not detected"
It mentioned ACPI.  So I traced ACPI related log suggested by Jan and Flori=
an and found that there is
ACPI related error reported earlier in log like " [    0.013416] ACPI BIOS =
Error (bug): A valid RSDP was not found (20200925/tbxfroot-210)".
I googled this error but all the solution related to it  can not fix the is=
sue for example enabling ACPI in BIOS.
And then I captured kernel log for 5.9 and compare them with 5.10 and final=
ly found that there is log info related to ACPI missing with my 5.10 image =
like=20
" [    0.000000] efi: ACPI 2.0=3D0x8c3ee000 ACPI=3D0x8c3ee000 TPMFinalLog=
=3D0x8c4ad000 SMBIOS=3D0x8c9ca000 SMBIOS 3.0=3D0x8c9c9000 MEMATTR=3D0x88059=
418"
After check kernel config, I found  that my 5.10 config actually have not e=
nabled CONFIG_EFI. After enable it, evl successfully boot up on=20
my Rock PI X board now.=20

Thanks for Jan and Florian's suggestions.

Regards

Hongzhan Chen

>same board. It could be related to clock source and ACPI changes in kernel=
.
>
>
>
>Thanks,
>Rick

