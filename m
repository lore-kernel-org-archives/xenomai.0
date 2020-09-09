MIME-Version: 1.0
References: <CAF_6MazWZnuJ3v4XjLLfAWMxrgSKsE2qt_60LLp0ifkC=fqoAQ@mail.gmail.com>
In-Reply-To: <CAF_6MazWZnuJ3v4XjLLfAWMxrgSKsE2qt_60LLp0ifkC=fqoAQ@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 9 Sep 2020 01:27:15 -0400
Message-ID: <CALLqZ8T7fm4-oFhw7NsxGkDiDi=F3CiJeHWaFfJDfcMsLNNhUw@mail.gmail.com>
Subject: Re: Regarding SMBus
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: gopi ratnakaram <gopi.ratnakaram@svayarobotics.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed., Sep. 9, 2020, 1:23 a.m. gopi ratnakaram via Xenomai <
xenomai@xenomai.org> wrote:

> Team,
>
> I am working with xenomai patched with kernel 4.19.59 on an Industrial
> motherboard which has an SMBus. After patching during my testing it was
> observed that the SMbus got some issues and the bus is locking immediately
> after running my application and the error log is as follows. But, when I
> run my SMbus based application in the kernel 4.15.0 without RT patching it
> was working fine. Is there any configuration setting while patching xenomai
> is causing this issue?
>
> --best regards,
> R Gopi Krishna,
> Svaya Robotics Pvt., Ltd.,
> Hyderabad, India.
> T: +91 40 2354 6019
> F: +91 40 2354 7901
>
>
> *DISCLAIMER  :This e-mail and any files transmitted with it may contain
> privileged, undisclosed, or otherwise confidential information of Svaya
> Robotics Pvt. Ltd., and are intended solely for the use of the individual
> or entity to whom they are addressed, shall be maintained in confidence and
> not disclosed to third parties without the written consent of the sender.
> If you have received this E-mail in error, you are hereby notified that any
> review, copying, printing or distribution of it is strictly prohibited.
> Please immediately notify the sender by return e-mail  and destroy the
> original transmittal. Thank you for your cooperation.*
> -------------- next part --------------
> [    1.291726] i801_smbus 0000:00:1f.4: SPD Write Disable is set
> [    1.291801] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
> [  366.625686] i801_smbus 0000:00:1f.4: Timeout waiting for interrupt!
> [  366.625688] i801_smbus 0000:00:1f.4: Transaction timeout
> [  366.832692] i801_smbus 0000:00:1f.4: Timeout waiting for interrupt!
> [  366.832694] i801_smbus 0000:00:1f.4: Transaction timeout
> [  367.040700] i801_smbus 0000:00:1f.4: Timeout waiting for interrupt!
> [  367.040702] i801_smbus 0000:00:1f.4: Transaction timeout
> [  367.050861] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  367.050911] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  367.050957] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  367.051000] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  367.051047] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  367.264710] i801_smbus 0000:00:1f.4: Timeout waiting for interrupt!
> [  367.264712] i801_smbus 0000:00:1f.4: Transaction timeout
> [  369.481794] i801_smbus 0000:00:1f.4: Timeout waiting for interrupt!
> [  369.481796] i801_smbus 0000:00:1f.4: Transaction timeout
> [  369.483827] i801_smbus 0000:00:1f.4: Failed terminating the transaction
> [  369.483900] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.483947] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.483996] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.484043] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.484086] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.484133] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.484180] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.688801] i801_smbus 0000:00:1f.4: Timeout waiting for interrupt!
> [  369.688803] i801_smbus 0000:00:1f.4: Transaction timeout
> [  369.690829] i801_smbus 0000:00:1f.4: Failed terminating the transaction
> [  369.690903] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.690951] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.690998] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691044] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691090] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691134] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691181] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691227] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691274] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691320] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691364] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691410] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691457] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691504] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691549] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691593] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691639] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691686] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691733] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691778] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691829] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691878] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691924] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.691971] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692018] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692064] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692108] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692155] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692201] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692248] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692294] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692338] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692385] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692432] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692479] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692525] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692568] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692615] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692662] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692709] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692756] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692846] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692896] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692943] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.692989] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693032] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693079] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693126] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693173] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693219] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693263] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693310] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693357] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693404] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693450] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693493] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693540] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693587] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693634] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693680] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693723] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693770] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693849] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693895] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693942] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.693988] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694035] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694082] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694126] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694173] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694219] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694266] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694312] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694356] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694404] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694451] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694498] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694544] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694587] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694634] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694681] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694728] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694774] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694853] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694903] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694949] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.694993] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.695040] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.695087] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.695134] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.695181] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.695225] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.695272] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.695319] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.695365] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.695411] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.695455] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  369.695501] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.703199] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.703258] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.703306] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.703352] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.703395] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.703442] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.703489] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.703535] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.703581] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.703625] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.703672] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.703718] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.703765] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.703813] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.703857] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.703913] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.703963] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704009] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704055] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704101] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704145] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704191] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704237] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704284] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704329] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704373] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704419] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704466] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704512] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704558] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704602] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704648] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704694] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704740] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704786] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704830] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704883] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704931] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.704977] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705023] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705069] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705113] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705159] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705205] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705252] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705297] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705341] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705388] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705434] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705480] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705525] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705569] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705616] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705662] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705708] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705754] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705798] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705844] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705891] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705938] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.705984] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706028] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706074] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706120] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706167] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706212] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706256] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706303] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706349] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706395] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706441] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706485] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706531] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706577] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706623] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706669] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706713] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706759] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706805] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706852] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706900] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706943] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.706989] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707036] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707082] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707127] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707172] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707218] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707264] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707311] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707356] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707400] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707447] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707493] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707540] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707585] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707629] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707676] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707722] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707768] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707814] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707858] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707914] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.707961] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.708007] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.708054] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.708099] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.708143] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.708189] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.708235] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.708282] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.708327] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.708371] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.708418] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.708464] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.708510] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
> [  371.708556] i801_smbus 0000:00:1f.4: SMBus is busy, can't use it!
>
What platform are you using? Please provide platform and build info.

Thanks

Greg

>
