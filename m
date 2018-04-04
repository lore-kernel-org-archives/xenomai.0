From: Sagi Maimon <SMaimon@advaoptical.com>
Date: Wed, 4 Apr 2018 15:42:08 +0000
Message-ID: <cad2a4c9f8b749109afff86f3ef0f201@advaoptical.com>
References: <mailman.27.1522680894.4366.xenomai@xenomai.org>
 <0A5CA087C7C2B54F937024C86CBC8AD515BA78D3@NDMSMBX402.ndc.nasa.gov>
 <c7227f3e81cd465bb26045a7a4a6f662@advaoptical.com>
 <1542961.KC98kqrEBl@wirbelwind>
In-Reply-To: <1542961.KC98kqrEBl@wirbelwind>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Unrecoverable FP Unavailable Exception 801
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "steven.seeger@nasa.gov" <steven.seeger@nasa.gov>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Thanks for your reply.
You are right, but unfortunately in my ssytem it happens on the Linux side:
The Linux kernel code that fixes the alignment during align exception (600)=
 works most of the time, but sometimes during the alignment fix  "Unrecover=
able FP Unavailable Exception" occurs.
My suspicion is that the xenomai still holds the FPU, but I not familiar en=
ough with the xenomi code.

Any how I still trying to make it occur on the xenomai side.

-----Original Message-----
From: Steven Seeger [mailto:steven.seeger@nasa.gov]=20
Sent: Wednesday, April 04, 2018 18:25
To: Sagi Maimon <SMaimon@advaoptical.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>; xenomai@xenomai.org
Subject: Re: [Xenomai] Unrecoverable FP Unavailable Exception 801

On Wednesday, April 4, 2018 8:57:31 AM EDT Sagi Maimon wrote:
> HI,
> I did it only from Linux side.
> I can try doing it from xenomai side too.
> Please explain how would it help to investigate the problem?
>

If the problem does not occur in a regular linux thread, but only occurs in=
 a xenomai-scheduled thread, then it drastically narrows down where the pro=
blem might be. Plus, you get a further test if you upgrade yuor kernel and =
ipipe patch.

Steven




