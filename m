From: <dietmar.schindler@manroland-web.com>
Date: Tue, 16 Jul 2013 13:10:34 +0000
Message-ID: <208C6975C932E94F86239FEA59CCA6321892F270@AUSMXMBX02.mrws.biz>
References: <CAOfKkXHkoPvJmp1mFNWCMpiyH1vGP1fjOLs=6awoSc8gF3C_9Q@mail.gmail.com>
	<CAOfKkXE6rb1_aR_Jk_it=D5aVApUWERJxKHZg-4BXfEWdOeMvQ@mail.gmail.com>
	<208C6975C932E94F86239FEA59CCA6321892EB8C@AUSMXMBX02.mrws.biz>
	<51D53DCF.1070704@xenomai.org>
	<208C6975C932E94F86239FEA59CCA6321892EBB8@AUSMXMBX02.mrws.biz>
	<51D565D9.2090007@xenomai.org>
In-Reply-To: <51D565D9.2090007@xenomai.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Xenomai processes crash with "Illegal instruction"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

> Von: Philippe Gerum [mailto:rpm@xenomai.org]
> Gesendet: Donnerstag, 4. Juli 2013 14:09
>
> On 07/04/2013 01:20 PM, dietmar.schindler@manroland-web.com wrote:
> >> Von: Philippe Gerum [mailto:rpm@xenomai.org]
> >> Gesendet: Donnerstag, 4. Juli 2013 11:18
> >>
> >> On 07/04/2013 11:04 AM, dietmar.schindler@manroland-web.com wrote:
> >>> We are having trouble with "Illegal instruction" (illegal opcode) cra=
shes (dumping core) of
> >> two different Xenomai programs on different computers, occuring approx=
imately once every few
> >> days. Here are some perhaps relevant details...
> >>>
> >>> Linux kernel version: 2.6.34
> > ... - Adeos-Patch : ksrc/arch/powerpc/patches/adeos-ipipe-2.6.34.4-powe=
rpc-2.10-05.patch
> >
> >>> So, the two cases look somewhat similar: The "Illegal instruction" is=
 reported around
> >> pthread_setcanceltype@plt; there are legal branch instructions there a=
s well as at the branch
> >> target locations; pthread_setcanceltype@plt is called from timed wait =
functions
> >> (pthread_wait_np() and rt_task_sleep() resp.).
> >>>
> >>> We would be grateful for suggestions how to analyze and cure the prob=
lem.
> >>
> >> This looks like mm woes. Is CONFIG_XENO_HW_UNLOCKED_SWITCH enabled?
> >
> > Yes, CONFIG_XENO_HW_UNLOCKED_SWITCH=3Dy. Should we try with it disabled=
?
>
> Yes please. Until recently, enabling this feature introduced random
> mm-related issues under load. This only got properly fixed in patches
> for 3.5.7 and above.

Systems are running now (with CONFIG_XENO_HW_UNLOCKED_SWITCH not defined) w=
ithout crashes so far; it seems that the issue is thereby prevented. Thank =
you for your advice!
--
Best regards,
Dietmar
________________________________________
manroland web systems GmbH -- Managing Director: Eckhard Hoerner-Marass
Registered Office: Augsburg -- Trade Register: AG Augsburg -- HRB-No. 26816=
 -- VAT: DE281389840

Confidentiality note:
This eMail and any files transmitted with it are confidential and intended =
solely for the use of the individual or entity to whom they are addressed. =
If you are not the intended recipient, you are hereby notified that any use=
 or dissemination of this communication is strictly prohibited. If you have=
 received this eMail in error, then please delete this eMail.

! Please consider your environmental responsibility before printing this eM=
ail
________________________________________

