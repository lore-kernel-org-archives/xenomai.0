Date: Fri, 15 Nov 2019 00:31:16 +0000
From: Jeff Webb <w1@codecraftsmen.org>
Reply-To: Jeff Webb <w1@codecraftsmen.org>
Subject: RE: [ANNOUNCE] Xenomai v3.1-rc3 available
Message-ID: <y27Ah4Xs-t8bhib0n5wvb0RE8X2b-B4GbVUz2PHHbETtMbl4SjmsFQP7GPGLfWozQrc_BW9MqoZFFIq0RYnMjvl_VQ0ecJz5Tp5fcaXPKcg=@codecraftsmen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I am building a Xenomai cobalt kernel under Ubuntu 18.04 based on:

   Linux 4.19.75
   Xenomai 3.1-rc3
   ipipe-core-4.19.75-x86-7.patch

After running prepare-kernel.sh and "makeolddefconfig" (using the unmodifie=
d default .config), I get this error:

   WARNING: unmet direct dependencies detected for PARAVIRT
     Depends on [n]: HYPERVISOR_GUEST [=3Dy] && !IPIPE [=3Dy]
     Selected by [m]:
     - HYPERV [=3Dm] && X86 [=3Dy] && ACPI [=3Dy] && X86_LOCAL_APIC [=3Dy] =
&& HYPERVISOR_GUEST [=3Dy]

I turned off HYPERVISOR_GUEST manually to fix the warning.  I hadn't seen t=
his type of error before, but perhaps something could be done in the patch =
to make the default config consistent...  Just FYI.

Otherwise, everything went fine with the build process and initial testing.=
  I will be giving this build some more testing over the next week or so an=
d will let you know if I find any issues.

Thanks,

-Jeff



