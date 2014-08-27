From: Asier Tamayo <asier.tamayo@onaedm.com>
Date: Wed, 27 Aug 2014 08:45:40 +0000
Message-ID: <4F6C25B906613147991AA0B688C61D1F41FAFB78@SRVEXCHANGE.ona-electroerosion.com>
Content-Language: es-ES
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Migrating from Xenomai to PREEMPT_RT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello all,

Before all, please let me congratulate the Xenomai maintainers for the new =
website. I really like it a lot.

Summary:=20
I may be forced to leave Xenomai and start using the PREEMPT_RT patch, and =
would like to know if anyone has any experience with it and which problems =
I will find during the process.

Full story:
I have been using Xenomai for some time and must say I am really happy with=
 the results (latencies, ease of programming, clear separation between the =
RT and non-RT parts...). My board is an Atom N270 based one, and runs a ker=
nel 2.6.34 compiled with Sysgo's ELinOS 5.2 tool. I have mainly used the na=
tive skin, as well as some RTDM drivers.

Now, I have to start using a new AMD G-Series T52R based board, and kernel =
2.6.34 shows some problems with it. Therefore, I have to update the kernel =
to a newer one, but ELinOS has dropped the Xenomai support. As far as I can=
 think, I now have three options: try to install Xenomai in ELinOS by mysel=
f, start using another tool or leave Xenomai and use the PREEMPT_RT patch. =
The first option may be very error prone (in fact, I have already updated o=
nce the Xenomai version in ELinOS, but the tool had Xenomai support integra=
ted previously in it). The second solution would surely put me in the Yocto=
 path, which I think can be the correct one, but the learning step might re=
quire too much time from me.

So, maybe the right solution would be to leave Xenomai and embrace the PREE=
MPT_RT patch, which is already supported by ELinOS. Has anyone got any expe=
rience with it? Which difficulties should I expect to find in the migration=
 process? Any special problems with RTDM, shared memory...?

Has anyone got information about latencies and performance comparison betwe=
en Xenomai and PREEMPT_RT patch? I have found some in https://www.osadl.org=
/fileadmin/dam/rtlws/12/Brown.pdf, but would like to have as much as possib=
le to make the choice.
=20
Is Xenomai 3 changing my situation in any way? Maybe using the Mercury arch=
itecture, in which I do not need to patch the kernel?

What do you think about the issue?

[From Xenomai 3 FAQ - http://xenomai.org/introducing-xenomai-3/:=20
    Q: I can run POSIX based applications directly over a PREEMPT_RT kernel=
 on my target system, so what is the point of running Xenomai 3?
    A: If your application is already fully POSIXish, and the performances =
requirements are met, then there is likely no point.(...)]


Best regards,

Asier Tamayo


